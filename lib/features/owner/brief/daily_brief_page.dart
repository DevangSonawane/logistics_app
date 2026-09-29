import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/launch_helpers.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../data/models/dashboard.dart';
import '../application/owner_providers.dart';

/// O5. Daily brief: date pager, summary, trips / money / risks sections,
/// share to WhatsApp. Share action sits in a SafeArea with bottom
/// padding so it never slides under the system nav bar.
class DailyBriefPage extends ConsumerStatefulWidget {
  const DailyBriefPage({super.key});

  @override
  ConsumerState<DailyBriefPage> createState() => _DailyBriefPageState();
}

class _DailyBriefPageState extends ConsumerState<DailyBriefPage> {
  int _dayOffset = 0;

  Future<void> _share(String brief) async {
    await LaunchHelpers.whatsappShare('RoadOps daily brief:\n$brief');
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppColorTokens tokens = context.tokens;
    final DateTime day =
        DateTime.now().add(Duration(days: _dayOffset));
    final AsyncValue<String> brief = ref.watch(dailyBriefProvider);
    final AsyncValue<DashboardKpis> kpis =
        ref.watch(ownerKpisProvider('all'));
    final AsyncValue<List<AttentionItem>> attention =
        ref.watch(attentionProvider);
    return AppScaffold(
      title: l10n.briefTitle,
      padding: EdgeInsets.zero,
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            children: [
              AppCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left_outlined),
                      onPressed: _dayOffset > -6
                          ? () => setState(() => _dayOffset--)
                          : null,
                    ),
                    Expanded(
                      child: Text(
                        Formatters.date(day),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right_outlined),
                      onPressed: _dayOffset < 0
                          ? () => setState(() => _dayOffset++)
                          : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary,
                            AppColors.primaryDark,
                          ],
                        ),
                        borderRadius: AppSpacing.cardRadius,
                      ),
                      child: brief.when(
                        loading: () =>
                            const SkeletonList(itemCount: 3),
                        error: (e, _) => ErrorState(
                          message: l10n.commonError,
                          onRetry: () =>
                              ref.invalidate(dailyBriefProvider),
                        ),
                        data: (String text) => Text(
                          text,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Colors.white.withValues(alpha: 0.95),
                                height: 1.5,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    kpis.when(
                      loading: () => const SkeletonList(itemCount: 2),
                      error: (e, _) => ErrorState(
                        message: l10n.commonError,
                      ),
                      data: (DashboardKpis k) => AppCard(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            _SectionTitle(
                              icon: Icons.local_shipping_outlined,
                              title:
                                  '${l10n.tripsToday}: ${k.tripsToday}',
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              '${l10n.collectionsMonth}: '
                              '${Formatters.inr(k.collectionsMonth)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: tokens.inkMuted),
                            ),
                            Text(
                              '${l10n.outstandingLabel}: '
                              '${Formatters.inr(k.outstanding)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: tokens.inkMuted),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    attention.when(
                      loading: () => const SkeletonList(itemCount: 2),
                      error: (e, _) => ErrorState(
                        message: l10n.commonError,
                      ),
                      data: (List<AttentionItem> list) => AppCard(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            _SectionTitle(
                              icon: Icons.warning_amber_outlined,
                              title: l10n.briefRisks,
                              tint: AppColors.warning,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            for (final AttentionItem item in list)
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: AppSpacing.xs,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.danger,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: AppSpacing.sm,
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${item.count} ${item.title}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppButton(
                label: l10n.shareWhatsapp,
                icon: Icons.share_outlined,
                onPressed: () => _share(brief.value ?? ''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.icon,
    required this.title,
    this.tint,
  });

  final IconData icon;
  final String title;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    final Color color = tint ?? context.tokens.primary;
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.12),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
