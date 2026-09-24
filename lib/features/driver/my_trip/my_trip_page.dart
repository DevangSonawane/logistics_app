import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/trip_labels.dart';
import '../../../core/router/route_names.dart';
import '../../../core/services/image_service.dart';
import '../../../core/services/voice_service.dart';import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/launch_helpers.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/photo_capture_sheet.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../core/widgets/slide_confirm.dart';
import '../../../core/widgets/status_chip.dart';
import '../../../core/widgets/sync_pill.dart';
import '../../../core/widgets/timeline_tile.dart';
import '../../../data/models/trip.dart';
import '../../auth/application/session_provider.dart';
import '../application/driver_settings.dart';
import '../application/driver_trip_controller.dart';
import '../application/gps_controller.dart';

/// D1. My Trip: greeting header, offer / active / empty states, big
/// slide-to-confirm status action with mandatory photo, timeline, SOS FAB.
class MyTripPage extends ConsumerWidget {
  const MyTripPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final SessionState session = ref.watch(sessionProvider);
    final String? driverId = session.user?.id;
    if (driverId == null) {
      return AppScaffold(body: ErrorState(message: l10n.commonError));
    }
    final AsyncValue<DriverTripState> tripState =
        ref.watch(driverTripProvider(driverId));
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        heroTag: 'sos',
        backgroundColor: AppColors.danger,
        onPressed: () => context.push(RouteNames.driverSos),
        child: const Icon(Icons.sos_outlined, color: Colors.white),
      ),
      body: AppScaffold(
        padding: EdgeInsets.zero,
        body: tripState.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: SkeletonList(),
          ),
          error: (e, _) => ErrorState(
            message: l10n.commonError,
            onRetry: () =>
                ref.read(driverTripProvider(driverId).notifier).refresh(),
          ),
          data: (DriverTripState data) => _TripBody(
            driverId: driverId,
            data: data,
          ),
        ),
      ),
    );
  }
}

class _TripBody extends StatelessWidget {
  const _TripBody({required this.driverId, required this.data});

  final String driverId;
  final DriverTripState data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        const _DriverHeader(),
        const SizedBox(height: AppSpacing.lg),
        if (data.offer != null)
          _OfferCard(trip: data.offer!, driverId: driverId)
        else if (data.activeTrip != null)
          _ActiveTripCard(trip: data.activeTrip!, driverId: driverId)
        else
          _EmptyTrip(driverId: driverId),
      ],
    );
  }
}

/// Greeting + vehicle chip + connectivity + SyncPill.
class _DriverHeader extends ConsumerWidget {
  const _DriverHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final SessionState session = ref.watch(sessionProvider);
    final String name = session.user?.name ?? '';
    final bool tracking = ref.watch(
      gpsTrackerProvider.select((s) => s.tracking),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.greeting(name),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            SyncPill(
              onTap: () => context.push(RouteNames.driverQueue),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          children: [
            if (tracking)
              const StatusChip(
                label: 'GPS',
                color: AppColors.success,
              ),
          ],
        ),
      ],
    );
  }
}

/// State A: no trip assigned.
class _EmptyTrip extends ConsumerWidget {
  const _EmptyTrip({required this.driverId});

  final String driverId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return EmptyState(
      title: l10n.noTripTitle,
      message: '',
      icon: Icons.local_shipping_outlined,
      actionLabel: l10n.retryAction,
      onAction: () =>
          ref.read(driverTripProvider(driverId).notifier).refresh(),
    );
  }
}

/// State B: new trip offer with accept / reject (reason required).
class _OfferCard extends ConsumerStatefulWidget {
  const _OfferCard({required this.trip, required this.driverId});

  final Trip trip;
  final String driverId;

  @override
  ConsumerState<_OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends ConsumerState<_OfferCard> {
  bool _working = false;

  Future<void> _accept() async {
    setState(() => _working = true);
    final MutationResult result = await ref
        .read(driverTripProvider(widget.driverId).notifier)
        .respondToOffer(accept: true);
    if (!mounted) return;
    setState(() => _working = false);
    _handle(result);
  }

  Future<void> _reject() async {
    final String? reason = await showModalBottomSheet<String>(
      context: context,
      builder: (_) => const _RejectSheet(),
    );
    if (reason == null || !mounted) return;
    setState(() => _working = true);
    final MutationResult result = await ref
        .read(driverTripProvider(widget.driverId).notifier)
        .respondToOffer(accept: false, reason: reason);
    if (!mounted) return;
    setState(() => _working = false);
    _handle(result);
  }

  void _handle(MutationResult result) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    switch (result.outcome) {
      case MutationOutcome.done:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.stepDone)),
        );
      case MutationOutcome.queued:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.stepQueued)),
        );
      case MutationOutcome.conflict:
        _showConflict(result.message);
      case MutationOutcome.error:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.commonError)),
        );
    }
  }

  Future<void> _showConflict(String? message) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.conflictTitle),
        content: Text(message ?? l10n.conflictMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.okAction),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final Trip trip = widget.trip;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StatusChip(label: l10n.offerTitle, color: AppColors.warning),
          const SizedBox(height: AppSpacing.md),
          Text(
            trip.customer,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          _RouteLines(trip: trip),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _Fact(
                  label: l10n.freightLabel,
                  value: Formatters.inr(trip.freightAllowance),
                ),
              ),
              Expanded(
                child: _Fact(
                  label: l10n.pickupByLabel,
                  value: Formatters.dateTime(trip.pickupBy),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${Formatters.distanceKm(trip.distanceKm)} · ${trip.vehicleReg}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            label: l10n.acceptAction,
            variant: AppButtonVariant.accent,
            large: true,
            loading: _working,
            onPressed: _working ? null : _accept,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: l10n.rejectAction,
            variant: AppButtonVariant.secondary,
            large: true,
            onPressed: _working ? null : _reject,
          ),
        ],
      ),
    );
  }
}

/// Reject reason sheet: reason required, note optional.
class _RejectSheet extends StatefulWidget {
  const _RejectSheet();

  @override
  State<_RejectSheet> createState() => _RejectSheetState();
}

class _RejectSheetState extends State<_RejectSheet> {
  String? _reason;
  final TextEditingController _note = TextEditingController();

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final List<String> reasons = [
      l10n.rejectVehicle,
      l10n.rejectHealth,
      l10n.rejectPersonal,
      l10n.rejectRoute,
      l10n.rejectOther,
    ];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.rejectTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(l10n.rejectReasonLabel),
            for (final String reason in reasons)
              RadioListTile<String>(
                title: Text(reason),
                value: reason,
                groupValue: _reason,
                onChanged: (v) => setState(() => _reason = v),
              ),
            TextField(
              controller: _note,
              decoration: InputDecoration(hintText: l10n.rejectNoteHint),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: l10n.submitAction,
              onPressed: _reason == null
                  ? null
                  : () => Navigator.of(context).pop(
                        _note.text.isEmpty
                            ? _reason
                            : '$_reason - ${_note.text}',
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

/// State C: active trip card + next-step slide + timeline.
class _ActiveTripCard extends ConsumerStatefulWidget {
  const _ActiveTripCard({required this.trip, required this.driverId});

  final Trip trip;
  final String driverId;

  @override
  ConsumerState<_ActiveTripCard> createState() => _ActiveTripCardState();
}

class _ActiveTripCardState extends ConsumerState<_ActiveTripCard> {
  VoiceService get _voice => ref.read(voiceServiceProvider);
  bool _listening = false;
  TripStepType? _voiceCandidate;

  @override
  void dispose() {
    _voice.stopListening();
    _voice.disposeRecorder();
    super.dispose();
  }

  Future<void> _confirmStep(TripStepType step) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final PhotoSource? source = await PhotoCaptureSheet.show(
      context,
      cameraLabel: l10n.photoCamera,
      galleryLabel: l10n.photoGallery,
    );
    if (source == null || !mounted) return;
    final String? path = await ref
        .read(imageServiceProvider)
        .capture(source: source, tag: widget.trip.id);
    if (!mounted) return;
    if (path == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.photoRequired)),
      );
      return;
    }
    final MutationResult result = await ref
        .read(driverTripProvider(widget.driverId).notifier)
        .completeStep(step: step, photoPath: path);
    if (!mounted) return;
    switch (result.outcome) {
      case MutationOutcome.done:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.stepDone)),
        );
      case MutationOutcome.queued:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.stepQueued)),
        );
      case MutationOutcome.conflict:
        await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.conflictTitle),
            content: Text(result.message ?? l10n.conflictMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.okAction),
              ),
            ],
          ),
        );
      case MutationOutcome.error:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.commonError)),
        );
    }
  }

  Future<void> _toggleVoice(TripStepType? next) async {
    if (_listening) {
      await _voice.stopListening();
      if (mounted) setState(() => _listening = false);
      return;
    }
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String locale = Localizations.localeOf(context).languageCode;
    final bool started = await _voice.listen(
      localeId: locale,
      onResult: (words) {
        final TripStepType? match = matchDriverCommand(words, locale);
        if (match != null && mounted) {
          setState(() => _voiceCandidate = match);
        }
      },
    );
    if (!mounted) return;
    if (!started) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.voiceNotAvailable)),
      );
      return;
    }
    setState(() => _listening = true);
  }

  String _stepLabel(AppLocalizations l10n, TripStepType step) =>
      tripStepLabel(l10n, step);

  Future<void> _openDocs(Trip trip) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.lrEwayLabel,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.md),
              // TODO(Phase 6): open the shared PDF viewer with the LR scan.
              Text('LR: ${trip.lrNo ?? '-'}'),
              Text('E-way: ${trip.ewayBillNo ?? '-'}'),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: l10n.closeAction,
                variant: AppButtonVariant.secondary,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final Trip trip = widget.trip;
    final TripStepType? next = nextStepFor(trip.status);
    final bool voiceEnabled = ref.watch(
      driverSettingsProvider.select((s) => s.voiceEnabled),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${trip.no} · ${trip.customer}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  StatusChip(
                    label: tripStatusLabel(l10n, trip.status),
                    color: AppColors.primary,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _RouteLines(trip: trip),
              const SizedBox(height: AppSpacing.md),
              _ContactRow(
                name: trip.pickupContact,
                phone: trip.pickupPhone,
                label: l10n.pickupLabel,
              ),
              _ContactRow(
                name: trip.dropContact,
                phone: trip.dropPhone,
                label: l10n.dropLabel,
              ),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  OutlinedButton.icon(
                    icon: const Icon(Icons.navigation_outlined),
                    label: Text(l10n.navigateAction),
                    onPressed: () => LaunchHelpers.navigate(
                      trip.dropLat,
                      trip.dropLng,
                    ),
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.description_outlined),
                    label: Text(l10n.lrEwayLabel),
                    onPressed: () => _openDocs(trip),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.receipt_outlined),
                      label: Text(l10n.addExpenseAction),
                      onPressed: () => context.push(
                        RouteNames.driverAddExpense,
                        extra: trip,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.payments_outlined),
                      label: Text(l10n.requestAdvanceAction),
                      onPressed: () => context.push(
                        RouteNames.driverRequestAdvance,
                        extra: trip,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (trip.status == TripStatus.unloaded) ...[
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.podPromptTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.md),
                AppButton(
                  label: l10n.podPromptAction,
                  variant: AppButtonVariant.accent,
                  large: true,
                  onPressed: () => context.push(
                    RouteNames.driverPod,
                    extra: trip,
                  ),
                ),
              ],
            ),
          ),
        ],
        if (trip.status == TripStatus.delivered) ...[
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Text(
              l10n.podDone,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
        ],
        if (next != null) ...[
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: SlideConfirm(
                  label: _stepLabel(l10n, next),
                  onConfirm: () => _confirmStep(next),
                ),
              ),
              if (voiceEnabled) ...[
                const SizedBox(width: AppSpacing.sm),
                _DriverIconButton(
                  icon: _listening ? Icons.mic : Icons.mic_none_outlined,
                  onPressed: () => _toggleVoice(next),
                ),
              ],
            ],
          ),
          if (_listening)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: Text(
                l10n.listeningLabel,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
          if (_voiceCandidate != null)
            _VoiceConfirmChip(
              stepLabel: _stepLabel(l10n, _voiceCandidate!),
              onYes: () {
                final TripStepType step = _voiceCandidate!;
                setState(() => _voiceCandidate = null);
                _voice.stopListening();
                setState(() => _listening = false);
                _confirmStep(step);
              },
              onNo: () => setState(() => _voiceCandidate = null),
            ),
        ],
        if (trip.steps.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.timelineTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          for (int i = 0; i < trip.steps.length; i++)
            TimelineTile(
              title: _stepLabel(l10n, trip.steps[i].type),
              time: Formatters.dateTime(trip.steps[i].at),
              color: AppColors.success,
              icon: Icons.check,
              isFirst: i == 0,
              isLast: i == trip.steps.length - 1,
            ),
        ],
      ],
    );
  }
}

/// Voice confirmation chip: never auto-applies without confirmation.
class _VoiceConfirmChip extends StatelessWidget {
  const _VoiceConfirmChip({
    required this.stepLabel,
    required this.onYes,
    required this.onNo,
  });

  final String stepLabel;
  final VoidCallback onYes;
  final VoidCallback onNo;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.15),
        borderRadius: AppSpacing.cardRadius,
        border: Border.all(color: AppColors.accent),
      ),
      child: Column(
        children: [
          Text(l10n.voiceConfirm(stepLabel)),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: onYes,
                child: Text(l10n.yesAction),
              ),
              const SizedBox(width: AppSpacing.sm),
              OutlinedButton(
                onPressed: onNo,
                child: Text(l10n.noAction),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DriverIconButton extends StatelessWidget {
  const _DriverIconButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSpacing.minTapTarget,
      height: AppSpacing.driverButtonHeight,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: AppSpacing.buttonRadius,
          ),
        ),
        onPressed: onPressed,
        child: Icon(icon),
      ),
    );
  }
}

class _RouteLines extends StatelessWidget {
  const _RouteLines({required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _RouteRow(
          dot: AppColors.success,
          label: l10n.pickupLabel,
          value: trip.pickupAddress,
        ),
        Container(
          margin: const EdgeInsets.only(left: 7),
          width: 2,
          height: AppSpacing.lg,
          color: context.tokens.border,
        ),
        _RouteRow(
          dot: AppColors.danger,
          label: l10n.dropLabel,
          value: trip.dropAddress,
        ),
      ],
    );
  }
}

class _RouteRow extends StatelessWidget {
  const _RouteRow({
    required this.dot,
    required this.label,
    required this.value,
  });

  final Color dot;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: AppSpacing.xs),
          width: AppSpacing.lg,
          height: AppSpacing.lg,
          decoration: BoxDecoration(shape: BoxShape.circle, color: dot),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: context.tokens.inkMuted,
                    ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.name,
    required this.phone,
    required this.label,
  });

  final String name;
  final String phone;
  final String label;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(child: Text('$label: $name')),
          SizedBox(
            width: AppSpacing.minTapTarget,
            height: AppSpacing.minTapTarget,
            child: IconButton(
              tooltip: '${l10n.callAction} $name',
              icon: const Icon(Icons.phone_outlined),
              onPressed: () => LaunchHelpers.call(phone),
            ),
          ),
        ],
      ),
    );
  }
}

class _Fact extends StatelessWidget {
  const _Fact({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: context.tokens.inkMuted,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
