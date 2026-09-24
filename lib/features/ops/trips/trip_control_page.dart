import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/trip_labels.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/launch_helpers.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../core/widgets/status_chip.dart';
import '../../../core/widgets/timeline_tile.dart';
import '../../../data/models/approval.dart';
import '../../../data/models/driver.dart';
import '../../../data/models/trip.dart';
import '../../../data/repositories/repository_providers.dart';
import '../application/ops_providers.dart';

/// P4. Trip control: timeline, call driver, status on driver's behalf
/// (reason required), raise advance, e-way bill, tracking link, docs.
class TripControlPage extends ConsumerStatefulWidget {
  const TripControlPage({super.key, required this.tripId});

  final String tripId;

  @override
  ConsumerState<TripControlPage> createState() => _TripControlPageState();
}

class _TripControlPageState extends ConsumerState<TripControlPage> {
  final TextEditingController _reason = TextEditingController();
  final TextEditingController _eway = TextEditingController();
  final TextEditingController _advance = TextEditingController();
  bool _working = false;

  @override
  void dispose() {
    _reason.dispose();
    _eway.dispose();
    _advance.dispose();
    super.dispose();
  }

  Future<void> _reload() async {
    setState(() {});
  }

  Future<void> _updateStatus(Trip trip, TripStepType step) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (_reason.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.reasonRequired)),
      );
      return;
    }
    setState(() => _working = true);
    try {
      await ref.read(tripRepositoryProvider).updateStatus(
            tripId: trip.id,
            step: step,
            lat: trip.dropLat,
            lng: trip.dropLng,
            note: 'Ops: ${_reason.text.trim()}',
          );
      ref.invalidate(opsLiveTripsProvider);
    } catch (_) {
      if (!mounted) return;
      setState(() => _working = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.commonError)),
      );
      return;
    }
    if (!mounted) return;
    setState(() {
      _working = false;
      _reason.clear();
    });
    _reload();
  }

  Future<void> _raiseAdvance(Trip trip) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final int amount = int.tryParse(_advance.text.trim()) ?? 0;
    if (amount <= 0) return;
    setState(() => _working = true);
    try {
      await ref.read(approvalRepositoryProvider).create(
            type: ApprovalType.advance,
            requester: 'Ops (on behalf of driver)',
            amount: amount,
            reason: 'Trip ${trip.no}',
          );
    } catch (_) {}
    if (!mounted) return;
    setState(() {
      _working = false;
      _advance.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.advanceRaised)),
    );
  }

  Future<void> _saveEway(Trip trip) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (_eway.text.trim().isEmpty) return;
    setState(() => _working = true);
    try {
      await ref.read(tripRepositoryProvider).updateEway(
            trip.id,
            _eway.text.trim(),
          );
    } catch (_) {
      if (!mounted) return;
      setState(() => _working = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.commonError)),
      );
      return;
    }
    if (!mounted) return;
    setState(() => _working = false);
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return FutureBuilder<Trip?>(
      future: ref.watch(tripRepositoryProvider).getTrip(widget.tripId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppScaffold(
            title: l10n.controlTitle,
            body: const SkeletonList(),
          );
        }
        final Trip? trip = snapshot.data;
        if (trip == null) {
          return AppScaffold(
            title: l10n.controlTitle,
            body: ErrorState(message: l10n.commonError),
          );
        }
        final TripStepType? next = nextStepFor(trip.status);
        return AppScaffold(
          title: trip.no,
          body: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${trip.customer} · ${trip.vehicleReg}',
                      style:
                          Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  StatusChip(
                    label: tripStatusLabel(l10n, trip.status),
                    color: AppColors.primary,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.phone_outlined),
                      label: Text(l10n.callDriver),
                      onPressed: () async {
                        final Driver driver = await ref
                            .read(driverRepositoryProvider)
                            .getDriver(trip.driverId);
                        if (!context.mounted) return;
                        final bool ok = await LaunchHelpers.call(
                          driver.phone,
                        );
                        if (!ok && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.commonError),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.share_outlined),
                      label: Text(l10n.shareTracking),
                      onPressed: () => LaunchHelpers.whatsappShare(
                        'Track ${trip.no}: roadops://trip/${trip.id}',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                l10n.timelineTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              for (int i = 0; i < trip.steps.length; i++)
                TimelineTile(
                  title: tripStepLabel(l10n, trip.steps[i].type),
                  time: Formatters.dateTime(trip.steps[i].at),
                  color: AppColors.success,
                  isFirst: i == 0,
                  isLast: i == trip.steps.length - 1,
                ),
              if (next != null) ...[
                const SizedBox(height: AppSpacing.lg),
                Text(
                  l10n.updateStatusAction,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                AppTextField(
                  controller: _reason,
                  label: l10n.reasonRequired,
                ),
                const SizedBox(height: AppSpacing.sm),
                AppButton(
                  label:
                      '${l10n.updateStatusAction}: ${tripStepLabel(l10n, next)}',
                  loading: _working,
                  onPressed: _working
                      ? null
                      : () => _updateStatus(trip, next),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              Text(
                l10n.raiseAdvanceAction,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: _advance,
                      label: l10n.amountLabel,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  ElevatedButton(
                    onPressed: _working
                        ? null
                        : () => _raiseAdvance(trip),
                    child: Text(l10n.requestAction),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                l10n.ewayLabel,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: _eway,
                      label: trip.ewayBillNo ?? l10n.ewayLabel,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  ElevatedButton(
                    onPressed:
                        _working ? null : () => _saveEway(trip),
                    child: Text(l10n.saveAction),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                l10n.lrEwayLabel,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text('LR: ${trip.lrNo ?? '-'}'),
              Text('${l10n.ewayLabel}: ${trip.ewayBillNo ?? '-'}'),
            ],
          ),
        );
      },
    );
  }
}
