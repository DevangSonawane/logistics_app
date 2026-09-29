import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/network/connectivity_provider.dart';
import '../../../core/offline/offline_action.dart';
import '../../../core/offline/offline_queue.dart';
import '../../../core/offline/sync_engine.dart';
import '../../../core/services/location_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/launch_helpers.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_filter_chip.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/slide_confirm.dart';
import '../../auth/application/session_provider.dart';
import '../application/driver_trip_controller.dart';

/// D7. SOS: pick a type, slide to send. Location attaches automatically;
/// offline actions queue. Pulsing red trigger + call-Ops fallback.
class SosPage extends ConsumerStatefulWidget {
  const SosPage({super.key});

  @override
  ConsumerState<SosPage> createState() => _SosPageState();
}

class _SosPageState extends ConsumerState<SosPage>
    with SingleTickerProviderStateMixin {
  String? _type;
  bool _sent = false;
  bool _working = false;
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (_type == null || _working) return;
    setState(() => _working = true);
    final SessionState session = ref.read(sessionProvider);
    String? tripId;
    if (session.user != null) {
      tripId = ref
          .read(driverTripProvider(session.user!.id))
          .value
          ?.activeTrip
          ?.id;
    }
    final ({double lat, double lng})? fix =
        await ref.read(locationServiceProvider).currentPosition();
    final OfflineAction action = OfflineAction(
      id: const Uuid().v4(),
      type: OfflineActionType.sos,
      tripId: tripId,
      payload: {
        'sosType': _type,
        'lat': fix?.lat,
        'lng': fix?.lng,
        'at': DateTime.now().toIso8601String(),
      },
      createdAt: DateTime.now(),
    );
    await ref.read(offlineQueueProvider.notifier).enqueue(action);
    final bool online = ref.read(isOnlineProvider);
    if (online) {
      await ref.read(syncControllerProvider.notifier).syncNow();
    }
    if (!mounted) return;
    setState(() {
      _working = false;
      _sent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final List<(String, String)> types = [
      ('breakdown', l10n.sosBreakdown),
      ('accident', l10n.sosAccident),
      ('medical', l10n.sosMedical),
      ('threat', l10n.sosThreat),
      ('other', l10n.sosOther),
    ];
    final AppColorTokens tokens = context.tokens;
    return AppScaffold(
      title: l10n.sosTitle,
      body: _sent
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 56,
                  color: AppColors.success,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  ref.read(isOnlineProvider)
                      ? l10n.sosSent
                      : l10n.sosQueued,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.lg),
                AppButton(
                  label: l10n.callOps,
                  variant: AppButtonVariant.danger,
                  icon: Icons.phone_outlined,
                  onPressed: () => LaunchHelpers.call('9000000021'),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        AnimatedBuilder(
                          animation: _pulse,
                          builder: (context, child) =>
                              Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(
                              AppSpacing.lg +
                                  _pulse.value * AppSpacing.sm,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.danger.withValues(
                                alpha:
                                    0.12 + _pulse.value * 0.1,
                              ),
                            ),
                            child: child,
                          ),
                          child: const Icon(
                            Icons.sos,
                            size: 56,
                            color: AppColors.danger,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          l10n.sosSelectType,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.sm,
                          children: [
                            for (final (id, label) in types)
                              AppFilterChip(
                                label: label,
                                selected: _type == id,
                                onTap: () =>
                                    setState(() => _type = id),
                              ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          l10n.sosPrompt,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: tokens.inkMuted,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                SafeArea(
                  top: false,
                  child: SlideConfirm(
                    label: l10n.sosTitle,
                    enabled: _type != null && !_working,
                    onConfirm: _send,
                  ),
                ),
              ],
            ),
    );
  }
}
