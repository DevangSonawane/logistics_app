import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/services/permission_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../data/models/app_user.dart';
import '../application/session_provider.dart';

/// Role-based permission checklist, one card at a time with a
/// "why we need this" line. Driver background location goes through the
/// prominent-disclosure screen (Accept / Deny) per Play policy.
class PermissionsPage extends ConsumerStatefulWidget {
  const PermissionsPage({super.key});

  @override
  ConsumerState<PermissionsPage> createState() => _PermissionsPageState();
}

class _PermissionsPageState extends ConsumerState<PermissionsPage> {
  int _step = 0;
  bool _working = false;
  bool _disclosureDenied = false;

  List<_PermStep> _stepsFor(AppRole role) {
    switch (role) {
      case AppRole.driver:
        return const [
          _PermStep(
            icon: Icons.notifications_outlined,
            kind: AppPermissionRequest.notifications,
            title: _PermText.notificationsTitle,
            why: _PermText.notificationsWhy,
          ),
          _PermStep(
            icon: Icons.photo_camera_outlined,
            kind: AppPermissionRequest.camera,
            title: _PermText.cameraTitle,
            why: _PermText.cameraWhy,
          ),
          _PermStep(
            icon: Icons.location_on_outlined,
            kind: AppPermissionRequest.locationInUse,
            title: _PermText.locationTitle,
            why: _PermText.locationWhy,
          ),
          _PermStep(
            icon: Icons.location_searching_outlined,
            kind: AppPermissionRequest.locationAlways,
            title: _PermText.locationAlwaysTitle,
            why: _PermText.locationAlwaysWhy,
            disclosure: true,
          ),
          _PermStep(
            icon: Icons.battery_charging_full_outlined,
            kind: AppPermissionRequest.battery,
            title: _PermText.batteryTitle,
            why: _PermText.batteryWhy,
          ),
          _PermStep(
            icon: Icons.mic_outlined,
            kind: AppPermissionRequest.microphone,
            title: _PermText.microphoneTitle,
            why: _PermText.microphoneWhy,
          ),
        ];
      case AppRole.sales:
        return const [
          _PermStep(
            icon: Icons.notifications_outlined,
            kind: AppPermissionRequest.notifications,
            title: _PermText.notificationsTitle,
            why: _PermText.notificationsWhy,
          ),
          _PermStep(
            icon: Icons.photo_camera_outlined,
            kind: AppPermissionRequest.camera,
            title: _PermText.cameraTitle,
            why: _PermText.cameraWhy,
          ),
          _PermStep(
            icon: Icons.mic_outlined,
            kind: AppPermissionRequest.microphone,
            title: _PermText.microphoneTitle,
            why: _PermText.microphoneWhy,
          ),
          _PermStep(
            icon: Icons.location_on_outlined,
            kind: AppPermissionRequest.locationInUse,
            title: _PermText.locationTitle,
            why: _PermText.locationWhy,
          ),
        ];
      case AppRole.supervisor:
        return const [
          _PermStep(
            icon: Icons.notifications_outlined,
            kind: AppPermissionRequest.notifications,
            title: _PermText.notificationsTitle,
            why: _PermText.notificationsWhy,
          ),
          _PermStep(
            icon: Icons.photo_camera_outlined,
            kind: AppPermissionRequest.camera,
            title: _PermText.cameraTitle,
            why: _PermText.cameraWhy,
          ),
        ];
      case AppRole.owner:
      case AppRole.ops:
      case AppRole.accountant:
        return const [
          _PermStep(
            icon: Icons.notifications_outlined,
            kind: AppPermissionRequest.notifications,
            title: _PermText.notificationsTitle,
            why: _PermText.notificationsWhy,
          ),
        ];
    }
  }

  Future<void> _allow(_PermStep step, int total) async {
    setState(() => _working = true);
    await const PermissionService().request(step.kind);
    if (!mounted) return;
    setState(() {
      _working = false;
      _disclosureDenied = false;
    });
    _advance(total);
  }

  void _advance(int total) {
    if (_step >= total - 1) {
      ref.read(sessionProvider.notifier).completePermissions();
    } else {
      setState(() {
        _step++;
        _disclosureDenied = false;
      });
    }
  }

  void _denyDisclosure() {
    setState(() => _disclosureDenied = true);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppRole? role = ref.watch(
      sessionProvider.select((SessionState s) => s.activeRole),
    );
    final List<_PermStep> steps =
        _stepsFor(role ?? AppRole.driver);
    final _PermStep step = steps[_step.clamp(0, steps.length - 1)];
    final bool isLast = _step >= steps.length - 1;

    return AppScaffold(
      showOfflineBanner: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.xl),
          Text(
            l10n.permissionsTitle,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.permissionsSubtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: context.tokens.inkMuted,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Step ${_step + 1} of ${steps.length}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.tokens.inkFaint,
                ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Expanded(
            child: step.disclosure
                ? _DisclosureCard(
                    denied: _disclosureDenied,
                    onAccept: _working ? null : () => _allow(step, steps.length),
                    onDeny: _denyDisclosure,
                    onContinue: () => _advance(steps.length),
                    working: _working,
                  )
                : _PermissionCard(
                    step: step,
                    working: _working,
                    onAllow:
                        _working ? null : () => _allow(step, steps.length),
                    onDeny: _working ? null : () => _advance(steps.length),
                    nextLabel: isLast ? l10n.permissionDone : l10n.permissionNext,
                  ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ),
    );
  }
}

enum _PermText {
  notificationsTitle,
  notificationsWhy,
  cameraTitle,
  cameraWhy,
  locationTitle,
  locationWhy,
  locationAlwaysTitle,
  locationAlwaysWhy,
  batteryTitle,
  batteryWhy,
  microphoneTitle,
  microphoneWhy,
}

class _PermStep {
  const _PermStep({
    required this.icon,
    required this.kind,
    required this.title,
    required this.why,
    this.disclosure = false,
  });

  final IconData icon;
  final AppPermissionRequest kind;
  final _PermText title;
  final _PermText why;
  final bool disclosure;
}

String _text(AppLocalizations l10n, _PermText key) {
  return switch (key) {
    _PermText.notificationsTitle => l10n.permNotificationsTitle,
    _PermText.notificationsWhy => l10n.permNotificationsWhy,
    _PermText.cameraTitle => l10n.permCameraTitle,
    _PermText.cameraWhy => l10n.permCameraWhy,
    _PermText.locationTitle => l10n.permLocationTitle,
    _PermText.locationWhy => l10n.permLocationWhy,
    _PermText.locationAlwaysTitle => l10n.permLocationAlwaysTitle,
    _PermText.locationAlwaysWhy => l10n.permLocationAlwaysWhy,
    _PermText.batteryTitle => l10n.permBatteryTitle,
    _PermText.batteryWhy => l10n.permBatteryWhy,
    _PermText.microphoneTitle => l10n.permMicrophoneTitle,
    _PermText.microphoneWhy => l10n.permMicrophoneWhy,
  };
}

class _PermissionCard extends StatelessWidget {
  const _PermissionCard({
    required this.step,
    required this.working,
    required this.onAllow,
    required this.onDeny,
    required this.nextLabel,
  });

  final _PermStep step;
  final bool working;
  final VoidCallback? onAllow;
  final VoidCallback? onDeny;
  final String nextLabel;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.xxxl),
          decoration: BoxDecoration(
            color: context.tokens.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            step.icon,
            size: AppSpacing.huge,
            color: context.tokens.primary,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          _text(l10n, step.title),
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          _text(l10n, step.why),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: context.tokens.inkMuted,
              ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        AppButton(
          label: l10n.permissionAllow,
          loading: working,
          onPressed: onAllow,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          label: l10n.permissionDeny,
          variant: AppButtonVariant.text,
          onPressed: onDeny,
        ),
      ],
    );
  }
}

/// Prominent disclosure for background location (Play policy): the driver
/// explicitly accepts or denies trip tracking while the app is closed.
class _DisclosureCard extends StatelessWidget {
  const _DisclosureCard({
    required this.denied,
    required this.onAccept,
    required this.onDeny,
    required this.onContinue,
    required this.working,
  });

  final bool denied;
  final VoidCallback? onAccept;
  final VoidCallback onDeny;
  final VoidCallback onContinue;
  final bool working;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Column(
      children: [
        const Icon(
          Icons.location_searching_outlined,
          size: AppSpacing.huge,
          color: AppColors.warning,
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          l10n.locationDisclosure,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        if (denied) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.permLocationAlwaysWhy,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: context.tokens.inkMuted,
                ),
            textAlign: TextAlign.center,
          ),
        ],
        const Spacer(),
        AppButton(
          label: l10n.acceptAction,
          loading: working,
          onPressed: onAccept,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          label: denied ? l10n.permissionNext : l10n.denyAction,
          variant: AppButtonVariant.text,
          onPressed: denied ? onContinue : onDeny,
        ),
      ],
    );
  }
}
