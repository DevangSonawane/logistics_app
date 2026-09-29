import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/network/connectivity_provider.dart';
import '../../../core/offline/offline_action.dart';
import '../../../core/offline/offline_queue.dart';
import '../../../core/services/image_service.dart';
import '../../../core/services/voice_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/photo_capture_sheet.dart';
import '../../../data/models/expense.dart';
import '../../../data/models/trip.dart';
import '../../../data/repositories/expense_repository.dart';
import '../../../data/repositories/repository_providers.dart';
import '../application/driver_providers.dart';

/// D3 (add). Type grid, diesel litres x rate auto-calc, bill photo required
/// above Rs.100, note, voice note, live above-norm warning.
class AddExpensePage extends ConsumerStatefulWidget {
  const AddExpensePage({super.key, required this.trip});

  final Trip trip;

  @override
  ConsumerState<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends ConsumerState<AddExpensePage> {
  ExpenseType _type = ExpenseType.diesel;
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _litres = TextEditingController();
  final TextEditingController _rate = TextEditingController();
  final TextEditingController _note = TextEditingController();
  String? _billPhoto;
  String? _voiceNote;
  bool _recording = false;
  bool _working = false;
  String? _error;
  VoiceService? _voiceService;

  VoiceService get _voice {
    _voiceService ??= ref.read(voiceServiceProvider);
    return _voiceService!;
  }

  @override
  void dispose() {
    _amount.dispose();
    _litres.dispose();
    _rate.dispose();
    _note.dispose();
    _voiceService?.disposeRecorder();
    super.dispose();
  }

  int get _parsedAmount => int.tryParse(_amount.text.trim()) ?? 0;

  void _recalcDiesel() {
    if (_type != ExpenseType.diesel) return;
    final double? litres = double.tryParse(_litres.text.trim());
    final double? rate = double.tryParse(_rate.text.trim());
    if (litres != null && rate != null) {
      _amount.text = (litres * rate).round().toString();
      setState(() {});
    }
  }

  bool get _showNormWarning =>
      _parsedAmount > 0 &&
      isAboveNorm(_type, _parsedAmount, widget.trip.distanceKm);

  Future<void> _captureBill() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final PhotoSource? source = await PhotoCaptureSheet.show(
      context,
      cameraLabel: l10n.photoCamera,
      galleryLabel: l10n.photoGallery,
    );
    if (source == null || !mounted) return;
    final String? path = await ref.read(imageServiceProvider).capture(
      source: source,
      tag: '${widget.trip.id}_bill',
    );
    if (!mounted || path == null) return;
    setState(() => _billPhoto = path);
  }

  Future<void> _toggleVoiceNote() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (_recording) {
      final String? path = await _voice.stopNote();
      if (!mounted) return;
      setState(() {
        _recording = false;
        _voiceNote = path;
      });
      return;
    }
    final bool? agreed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.voiceConsentTitle),
        content: Text(l10n.voiceConsentMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancelAction),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.agreeAction),
          ),
        ],
      ),
    );
    if (agreed != true || !mounted) return;
    final String? path = await _voice.startNote();
    if (!mounted) return;
    if (path == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.voiceNotAvailable)),
      );
      return;
    }
    setState(() {
      _recording = true;
      _voiceNote = path;
    });
  }

  Future<void> _save() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final int amount = _parsedAmount;
    if (amount <= 0) {
      setState(() => _error = l10n.amountLabel);
      return;
    }
    if (amount > 100 && _billPhoto == null) {
      setState(() => _error = l10n.billRequired);
      return;
    }
    setState(() {
      _error = null;
      _working = true;
    });
    final Expense expense = Expense(
      id: 'local-${const Uuid().v4()}',
      tripId: widget.trip.id,
      type: _type,
      amount: amount,
      litres: _type == ExpenseType.diesel
          ? double.tryParse(_litres.text.trim())
          : null,
      rate: _type == ExpenseType.diesel
          ? double.tryParse(_rate.text.trim())
          : null,
      photoPath: _billPhoto,
      note: _note.text.trim().isEmpty ? null : _note.text.trim(),
      voiceNotePath: _voiceNote,
      createdAt: DateTime.now(),
    );
    final List<String> attachments = <String?>[
      _billPhoto,
      _voiceNote,
    ].whereType<String>().toList();
    final OfflineAction action = OfflineAction(
      id: const Uuid().v4(),
      type: OfflineActionType.expenseAdd,
      tripId: widget.trip.id,
      payload: {
        'expense': expense.toJson(),
        'distanceKm': widget.trip.distanceKm,
      },
      createdAt: DateTime.now(),
      attachments: attachments,
    );
    await ref.read(offlineQueueProvider.notifier).enqueue(action);
    if (ref.read(isOnlineProvider)) {
      try {
        final Expense saved =
            await ref.read(expenseRepositoryProvider).add(
                  expense,
                  distanceKm: widget.trip.distanceKm,
                );
        await ref.read(offlineQueueProvider.notifier).update(
              action.id,
              (a) => a.copyWith(
                status: OfflineActionStatus.done,
                payload: {
                  ...a.payload,
                  'expense': saved.toJson(),
                },
              ),
            );
      } catch (_) {}
    }
    ref.invalidate(tripExpensesProvider(widget.trip.id));
    if (!mounted) return;
    setState(() => _working = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.expenseSaved)),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final List<(ExpenseType, String, IconData)> types = [
      (ExpenseType.diesel, l10n.expenseDiesel, Icons.local_gas_station_outlined),
      (ExpenseType.toll, l10n.expenseToll, Icons.route_outlined),
      (ExpenseType.repair, l10n.expenseRepair, Icons.build_outlined),
      (ExpenseType.loading, l10n.expenseLoading, Icons.inventory_2_outlined),
      (ExpenseType.police, l10n.expensePolice, Icons.local_police_outlined),
      (ExpenseType.food, l10n.expenseFood, Icons.restaurant_outlined),
      (ExpenseType.other, l10n.expenseOther, Icons.more_horiz_outlined),
    ];
    final AppColorTokens tokens = context.tokens;
    return AppScaffold(
      title: l10n.expenseTitle,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: tokens.primary.withValues(alpha: 0.08),
                    borderRadius: AppSpacing.cardRadius,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet_outlined,
                        size: 18,
                        color: tokens.primary,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          '${l10n.advanceBalance}: '
                          '${Formatters.inr(ref.watch(advanceBalanceProvider(widget.trip.driverId)).value ?? 0)}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: tokens.primary),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: AppSpacing.sm,
                    crossAxisSpacing: AppSpacing.sm,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: types.length,
                  itemBuilder: (context, index) {
                    final (type, label, icon) = types[index];
                    final bool selected = type == _type;
                    return GestureDetector(
                      onTap: () => setState(() => _type = type),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected
                              ? tokens.primary
                              : tokens.surface,
                          borderRadius: AppSpacing.cardRadius,
                          border: Border.all(
                            color: selected
                                ? tokens.primary
                                : tokens.border,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Icon(
                              icon,
                              size: 22,
                              color: selected
                                  ? tokens.onPrimary
                                  : tokens.inkMuted,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              label,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: selected
                                        ? tokens.onPrimary
                                        : tokens.inkMuted,
                                  ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                if (_type == ExpenseType.diesel) ...[
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          controller: _litres,
                          label: l10n.litresLabel,
                          keyboardType:
                              const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          onChanged: (_) => _recalcDiesel(),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: AppTextField(
                          controller: _rate,
                          label: l10n.rateLabel,
                          keyboardType:
                              const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          onChanged: (_) => _recalcDiesel(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                AppTextField(
                  controller: _amount,
                  label: l10n.amountLabel,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.currency_rupee_outlined,
                ),
                if (_showNormWarning) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      const Icon(
                        Icons.warning_amber_outlined,
                        size: 14,
                        color: AppColors.warning,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          l10n.aboveNorm,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: AppColors.warning,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: _AttachTile(
                        icon: Icons.receipt_long_outlined,
                        label: l10n.billPhotoLabel,
                        done: _billPhoto != null,
                        onTap: _captureBill,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _AttachTile(
                        icon: _recording
                            ? Icons.stop_outlined
                            : Icons.mic_none_outlined,
                        label: _recording
                            ? l10n.listeningLabel
                            : l10n.voiceNoteAction,
                        done: _voiceNote != null || _recording,
                        danger: _recording,
                        onTap: _toggleVoiceNote,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  controller: _note,
                  label: l10n.noteHint,
                ),
                if (_error != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _error!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                          color: AppColors.danger,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SafeArea(
            top: false,
            child: AppButton(
              label: l10n.saveAction,
              loading: _working,
              onPressed: _working ? null : _save,
            ),
          ),
        ],
      ),
    );
  }
}

/// Small attachment tile (bill photo / voice note) with done state.
class _AttachTile extends StatelessWidget {
  const _AttachTile({
    required this.icon,
    required this.label,
    required this.done,
    required this.onTap,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final bool done;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    final Color tint =
        danger ? AppColors.danger : done ? AppColors.success : tokens.primary;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: tint.withValues(alpha: 0.08),
          borderRadius: AppSpacing.cardRadius,
          border: Border.all(color: tint.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: tint),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: tint,
                      fontWeight: FontWeight.w700,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
