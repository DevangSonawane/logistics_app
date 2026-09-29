import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/trip_labels.dart';
import '../../../core/router/route_names.dart';
import '../../../core/services/image_service.dart';
import '../../../core/services/voice_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
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
    final AsyncValue<DriverTripState> tripState = ref.watch(
      driverTripProvider(driverId),
    );
    return Scaffold(
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
          data: (DriverTripState data) =>
              _TripBody(driverId: driverId, data: data),
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
      padding: EdgeInsets.zero,
      children: [
        const _DriverHeader(),
        // First card bleeds over the header gradient (Rule 3).
        Transform.translate(
          offset: const Offset(0, -28),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: data.offer != null
                ? _OfferCard(trip: data.offer!, driverId: driverId)
                : data.activeTrip != null
                ? _ActiveTripCard(trip: data.activeTrip!, driverId: driverId)
                : _EmptyTrip(driverId: driverId),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

/// Greeting header on the near-white gradient: display-size greeting
/// (Rule 4), vehicle + GPS chips left, sync pill right (Rule 5 asymmetry).
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
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.darkHeroGradient),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.xxxl + 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      l10n.greeting(name),
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                            color: context.tokens.ink,
                            fontWeight: FontWeight.w800,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SyncPill(onTap: () => context.push(RouteNames.driverQueue)),
                  const SizedBox(width: AppSpacing.sm),
                  GestureDetector(
                    onTap: () =>
                        context.push(RouteNames.driverSos),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.danger,
                      ),
                      child: const Icon(
                        Icons.sos_outlined,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                children: [
                  if (tracking)
                    const StatusChip(label: 'GPS', color: AppColors.success),
                ],
              ),
            ],
          ),
        ),
      ),
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
      onAction: () => ref.read(driverTripProvider(driverId).notifier).refresh(),
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.stepDone)));
      case MutationOutcome.queued:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.stepQueued)));
      case MutationOutcome.conflict:
        _showConflict(result.message);
      case MutationOutcome.error:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.commonError)));
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
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              StatusChip(label: l10n.offerTitle, color: AppColors.warning),
              const Spacer(),
              Text(
                Formatters.distanceKm(trip.distanceKm),
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: context.tokens.inkMuted),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            trip.customer,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w700),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // Freight dominates the card (Rule 2 + 4).
          Text(
            Formatters.inr(trip.freightAllowance),
            style: AppTypography.kpiNumber(
              AppColors.secondary,
            ).copyWith(fontSize: 28),
          ),
          Text(
            '${l10n.freightLabel} · ${trip.vehicleReg}',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: context.tokens.inkMuted),
          ),
          const SizedBox(height: AppSpacing.md),
          _RouteLines(trip: trip),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${l10n.pickupByLabel}: ${Formatters.dateTime(trip.pickupBy)}',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: context.tokens.inkMuted),
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(
            label: l10n.acceptAction,
            loading: _working,
            onPressed: _working ? null : _accept,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: l10n.rejectAction,
            variant: AppButtonVariant.text,
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
            RadioGroup<String>(
              groupValue: _reason,
              onChanged: (v) => setState(() => _reason = v),
              child: Column(
                children: [
                  for (final String reason in reasons)
                    RadioListTile<String>(title: Text(reason), value: reason),
                ],
              ),
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
                      _note.text.isEmpty ? _reason : '$_reason - ${_note.text}',
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
  VoiceService? _voiceService;
  bool _listening = false;
  TripStepType? _voiceCandidate;

  VoiceService get _voice {
    _voiceService ??= ref.read(voiceServiceProvider);
    return _voiceService!;
  }

  @override
  void dispose() {
    _voiceService?.stopListening();
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.photoRequired)));
      return;
    }
    final MutationResult result = await ref
        .read(driverTripProvider(widget.driverId).notifier)
        .completeStep(step: step, photoPath: path);
    if (!mounted) return;
    switch (result.outcome) {
      case MutationOutcome.done:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.stepDone)));
      case MutationOutcome.queued:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.stepQueued)));
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.commonError)));
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.voiceNotAvailable)));
      return;
    }
    setState(() => _listening = true);
  }

  String _stepLabel(AppLocalizations l10n, TripStepType step) =>
      tripStepLabel(l10n, step);

  Future<void> _openDocs(Trip trip) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppColorTokens tokens = context.tokens;
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: tokens.primary
                          .withValues(alpha: 0.1),
                    ),
                    child: Icon(
                      Icons.description_outlined,
                      size: 20,
                      color: tokens.primary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      l10n.lrEwayLabel,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              // TODO(Phase 6): open the shared PDF viewer with the LR scan.
              _DocRow(
                label: 'LR',
                value: trip.lrNo ?? '-',
              ),
              const SizedBox(height: AppSpacing.sm),
              _DocRow(
                label: 'E-way',
                value: trip.ewayBillNo ?? '-',
              ),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: l10n.closeAction,
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
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${trip.no} · ${trip.customer}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
              // Asymmetric primary actions: Navigate dominates (3:2).
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.tokens.primary,
                          foregroundColor: context.tokens.onPrimary,
                          shape: const RoundedRectangleBorder(
                            borderRadius: AppSpacing.buttonRadius,
                          ),
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        icon: const Icon(
                          Icons.navigation_outlined,
                          size: 18,
                        ),
                        label: Text(l10n.navigateAction),
                        onPressed: () => LaunchHelpers.navigate(
                          trip.dropLat,
                          trip.dropLng,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 44,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: AppSpacing.buttonRadius,
                          ),
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        onPressed: () => _openDocs(trip),
                        child: Text(
                          l10n.lrEwayLabel,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 40),
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      icon: const Icon(
                        Icons.receipt_outlined,
                        size: 16,
                      ),
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
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 40),
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      icon: const Icon(
                        Icons.payments_outlined,
                        size: 16,
                      ),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (trip.status == TripStatus.unloaded) ...[
                _PodPromptCard(trip: trip),
              ],
              if (trip.status == TripStatus.delivered) ...[
                AppCard(
                  child: Text(
                    l10n.podDone,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              if (next != null) ...[
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
            ],
          ),
        ),
      ],
    );
  }
}

class _PodPromptCard extends StatelessWidget {
  const _PodPromptCard({required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.podPromptTitle,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: l10n.podPromptAction,
            onPressed: () => context.push(RouteNames.driverPod, extra: trip),
          ),
        ],
      ),
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
              ElevatedButton(onPressed: onYes, child: Text(l10n.yesAction)),
              const SizedBox(width: AppSpacing.sm),
              OutlinedButton(onPressed: onNo, child: Text(l10n.noAction)),
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

/// Label/value row for the LR sheet.
class _DocRow extends StatelessWidget {
  const _DocRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.tokens.surfaceAlt,
        borderRadius: AppSpacing.inputRadius,
      ),
      child: Row(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.tokens.inkMuted,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.end,
            ),
          ),
        ],
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
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: context.tokens.inkMuted),
              ),
              Text(value, style: Theme.of(context).textTheme.bodyMedium),
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
