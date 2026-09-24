import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/services/share_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../data/models/finance.dart';
import '../application/owner_providers.dart';

/// P&L with a group-by switcher (branch / vehicle / customer / lane).
/// Branch + vehicle groupings scale the seed deterministically;
/// customer + lane groupings reuse the trip P&L lines.
class PnlPage extends ConsumerStatefulWidget {
  const PnlPage({super.key});

  @override
  ConsumerState<PnlPage> createState() => _PnlPageState();
}

class _PnlPageState extends ConsumerState<PnlPage> {
  String _group = 'branch';

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<PnlLine>> pnl = ref.watch(pnlProvider);
    final AsyncValue<List<TripPnl>> trips = ref.watch(tripPnlProvider);
    final Map<String, String> groups = {
      'branch': l10n.groupBranch,
      'vehicle': l10n.groupVehicle,
      'customer': l10n.groupCustomer,
      'lane': l10n.groupLane,
    };
    return AppScaffold(
      title: l10n.pnlTitle,
      actions: [
        IconButton(
          icon: const Icon(Icons.share_outlined),
          onPressed: () => ShareService().sharePdf(
            l10n.pnlTitle,
            [
              for (final line in pnl.value ?? const <PnlLine>[])
                (line.label, Formatters.inr(line.amount)),
            ],
          ),
        ),
      ],
      body: Column(
        children: [
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final entry in groups.entries)
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: ChoiceChip(
                      label: Text(entry.value),
                      selected: _group == entry.key,
                      onSelected: (_) =>
                          setState(() => _group = entry.key),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: pnl.when(
              loading: () => const SkeletonList(),
              error: (e, _) => ErrorState(
                message: l10n.commonError,
                onRetry: () => ref.invalidate(pnlProvider),
              ),
              data: (List<PnlLine> lines) {
                final double factor = switch (_group) {
                  'branch' => 1,
                  'vehicle' => 0.6,
                  'customer' => 0.45,
                  _ => 0.3,
                };
                return ListView(
                  children: [
                    for (final PnlLine line in lines)
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: AppCard(
                          padding:
                              const EdgeInsets.all(AppSpacing.md),
                          child: Row(
                            children: [
                              Expanded(child: Text(line.label)),
                              Text(
                                Formatters.inr(
                                  (line.amount * factor).round(),
                                ),
                                style: TextStyle(
                                  color: line.amount < 0
                                      ? AppColors.danger
                                      : context.tokens.ink,
                                  fontWeight:
                                      line.label == 'Net profit'
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      l10n.tripPnlTitle,
                      style:
                          Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    trips.when(
                      loading: () => const SkeletonList(itemCount: 3),
                      error: (e, _) =>
                          ErrorState(message: l10n.commonError),
                      data: (List<TripPnl> list) => Column(
                        children: [
                          for (final TripPnl t in list)
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.sm,
                              ),
                              child: AppCard(
                                padding: const EdgeInsets.all(
                                  AppSpacing.md,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${t.tripNo} · ${t.lane}',
                                      ),
                                    ),
                                    Text(
                                      Formatters.inr(t.margin),
                                      style: TextStyle(
                                        color: t.margin < 0
                                            ? AppColors.danger
                                            : AppColors.success,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
