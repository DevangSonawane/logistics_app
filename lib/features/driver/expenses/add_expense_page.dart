import 'dart:io';

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
    return AppScaffold(
      title: l10n.expenseTitle,
      body: ListView(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: AppSpacing.sm,
              crossAxisSpacing: AppSpacing.sm,
              childAspectRatio: 0.85,
            ),
            itemCount: types.length,
            itemBuilder: (context, index) {
              final (type, label, icon) = types[index];
              final bool selected = type == _type;
              return GestureDetector(
                onTap: () => setState(() => _type = type),
                child: Container(
                  decoration: BoxDecoration(
                    color: selected
                        ? context.tokens.primary.withValues(alpha: 0.12)
                        : context.tokens.surface,
                    borderRadius: AppSpacing.cardRadius,
                    border: Border.all(
                      color: selected
                          ? context.tokens.primary
                          : context.tokens.border,
                      width: selected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: selected
                            ? context.tokens.primary
                            : context.tokens.inkMuted,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        label,
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          if (_type == ExpenseType.diesel) ...[
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _litres,
                    label: l10n.litresLabel,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (_) => _recalcDiesel(),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: AppTextField(
                    controller: _rate,
                    label: l10n.rateLabel,
                    keyboardType: const TextInputType.numberWithOptions(
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
          ),
          if (_showNormWarning) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.aboveNorm,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.warning),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.receipt_long_outlined),
                  label: Text(l10n.billPhotoLabel),
                  onPressed: _captureBill,
                ),
              ),
              if (_billPhoto != null) ...[
                const SizedBox(width: AppSpacing.sm),
                ClipRRect(
                  borderRadius: AppSpacing.inputRadius,
                  child: Image.file(
                    File(_billPhoto!),
                    width: AppSpacing.minTapTarget,
                    height: AppSpacing.minTapTarget,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      width: AppSpacing.minTapTarget,
                      height: AppSpacing.minTapTarget,
                      color: context.tokens.surfaceAlt,
                      child: const Icon(Icons.receipt_outlined),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _note,
            label: l10n.noteHint,
          ),
          const SizedBox(height: AppSpacing.md),
          OutlinedButton.icon(
            icon: Icon(
              _recording ? Icons.stop_outlined : Icons.mic_none_outlined,
              color: _recording ? AppColors.danger : null,
            ),
            label: Text(
              _recording ? l10n.listeningLabel : l10n.voiceNoteAction,
            ),
            onPressed: _toggleVoiceNote,
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              _error!,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.danger),
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            label: l10n.saveAction,
            variant: AppButtonVariant.accent,
            large: true,
            loading: _working,
            onPressed: _working ? null : _save,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${l10n.advanceBalance}: '
            '${Formatters.inr(ref.watch(advanceBalanceProvider(widget.trip.driverId)).value ?? 0)}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
