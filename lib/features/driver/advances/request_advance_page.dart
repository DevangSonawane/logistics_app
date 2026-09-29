import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/network/connectivity_provider.dart';
import '../../../core/offline/offline_action.dart';
import '../../../core/offline/offline_queue.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../data/models/advance.dart';
import '../../../data/models/trip.dart';
import '../../../data/repositories/repository_providers.dart';
import '../application/driver_providers.dart';

/// D4 (request). Amount + purpose + note; history updates on submit.
class RequestAdvancePage extends ConsumerStatefulWidget {
  const RequestAdvancePage({super.key, required this.trip});

  final Trip trip;

  @override
  ConsumerState<RequestAdvancePage> createState() =>
      _RequestAdvancePageState();
}

class _RequestAdvancePageState extends ConsumerState<RequestAdvancePage> {
  AdvancePurpose _purpose = AdvancePurpose.fuel;
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _note = TextEditingController();
  bool _working = false;
  String? _error;

  @override
  void dispose() {
    _amount.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final int amount = int.tryParse(_amount.text.trim()) ?? 0;
    if (amount <= 0) {
      setState(() => _error = l10n.amountLabel);
      return;
    }
    setState(() {
      _error = null;
      _working = true;
    });
    final Advance advance = Advance(
      id: 'local-${const Uuid().v4()}',
      tripId: widget.trip.id,
      amount: amount,
      purpose: _purpose,
      note: _note.text.trim().isEmpty ? null : _note.text.trim(),
      requestedAt: DateTime.now(),
    );
    final OfflineAction action = OfflineAction(
      id: const Uuid().v4(),
      type: OfflineActionType.advanceRequest,
      tripId: widget.trip.id,
      payload: {'advance': advance.toJson()},
      createdAt: DateTime.now(),
    );
    await ref.read(offlineQueueProvider.notifier).enqueue(action);
    if (ref.read(isOnlineProvider)) {
      try {
        final Advance saved =
            await ref.read(advanceRepositoryProvider).request(advance);
        await ref.read(offlineQueueProvider.notifier).update(
              action.id,
              (a) => a.copyWith(
                status: OfflineActionStatus.done,
                payload: {...a.payload, 'advance': saved.toJson()},
              ),
            );
      } catch (_) {}
    }
    ref.invalidate(tripAdvancesProvider(widget.trip.id));
    if (!mounted) return;
    setState(() => _working = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.advanceRequested)),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final List<(AdvancePurpose, String)> purposes = [
      (AdvancePurpose.fuel, l10n.purposeFuel),
      (AdvancePurpose.toll, l10n.purposeToll),
      (AdvancePurpose.repair, l10n.purposeRepair),
      (AdvancePurpose.food, l10n.purposeFood),
      (AdvancePurpose.other, l10n.purposeOther),
    ];
    final AppColorTokens tokens = context.tokens;
    const List<IconData> icons = [
      Icons.local_gas_station_outlined,
      Icons.route_outlined,
      Icons.build_outlined,
      Icons.restaurant_outlined,
      Icons.more_horiz_outlined,
    ];
    return AppScaffold(
      title: l10n.requestAdvanceTitle,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: AppSpacing.sm,
                    crossAxisSpacing: AppSpacing.sm,
                    childAspectRatio: 1.6,
                  ),
                  itemCount: purposes.length,
                  itemBuilder: (context, index) {
                    final (purpose, label) = purposes[index];
                    final bool selected = _purpose == purpose;
                    return GestureDetector(
                      onTap: () =>
                          setState(() => _purpose = purpose),
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
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Icon(
                              icons[index % icons.length],
                              size: 18,
                              color: selected
                                  ? tokens.onPrimary
                                  : tokens.inkMuted,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Flexible(
                              child: Text(
                                label,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: selected
                                          ? tokens.onPrimary
                                          : tokens.inkMuted,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  controller: _amount,
                  label: l10n.amountLabel,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.currency_rupee_outlined,
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
              label: l10n.requestAction,
              loading: _working,
              onPressed: _working ? null : _submit,
            ),
          ),
        ],
      ),
    );
  }
}
