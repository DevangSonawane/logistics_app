import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/launch_helpers.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../data/models/dashboard.dart';
import '../application/owner_providers.dart';

/// O5. Daily brief: date pager, money/trips/risks/wins sections,
/// share to WhatsApp.
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
    final DateTime day =
        DateTime.now().add(Duration(days: _dayOffset));
    final AsyncValue<String> brief = ref.watch(dailyBriefProvider);
    final AsyncValue<DashboardKpis> kpis =
        ref.watch(ownerKpisProvider('all'));
    final AsyncValue<List<AttentionItem>> attention =
        ref.watch(attentionProvider);
    return AppScaffold(
      title: l10n.briefTitle,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left_outlined),
                onPressed: _dayOffset > -6
                    ? () => setState(() => _dayOffset--)
                    : null,
              ),
              Text(
                '${day.day}/${day.month}/${day.year}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right_outlined),
                onPressed: _dayOffset < 0
                    ? () => setState(() => _dayOffset++)
                    : null,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: ListView(
              children: [
                AppCard(
                  child: brief.when(
                    loading: () => const SkeletonList(itemCount: 3),
                    error: (e, _) => ErrorState(
                      message: l10n.commonError,
                      onRetry: () =>
                          ref.invalidate(dailyBriefProvider),
                    ),
                    data: (String text) => Text(text),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                AppCard(
                  child: kpis.when(
                    loading: () => const SkeletonList(itemCount: 2),
                    error: (e, _) => ErrorState(
                      message: l10n.commonError,
                    ),
                    data: (DashboardKpis k) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.briefMoney,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall,
                        ),
                        Text(
                          '${l10n.collectionsMonth}: ${k.collectionsMonth} · '
                          '${l10n.outstandingLabel}: ${k.outstanding}',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                AppCard(
                  child: attention.when(
                    loading: () => const SkeletonList(itemCount: 2),
                    error: (e, _) => ErrorState(
                      message: l10n.commonError,
                    ),
                    data: (List<AttentionItem> list) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.briefRisks,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall,
                        ),
                        for (final AttentionItem item in list)
                          Text('• ${item.count} ${item.title}'),
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
    );
  }
}
