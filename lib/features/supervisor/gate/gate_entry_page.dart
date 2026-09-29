import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../core/widgets/status_chip.dart';
import '../../../data/models/hub.dart';
import '../../../data/repositories/repository_providers.dart';
import '../application/supervisor_providers.dart';

/// V2. Gate: vehicle gate-in (auto time) and gate-out with a
/// reporting-time delta chip (gate-in vs ETA).
class GateEntryPage extends ConsumerStatefulWidget {
  const GateEntryPage({super.key});

  @override
  ConsumerState<GateEntryPage> createState() => _GateEntryPageState();
}

class _GateEntryPageState extends ConsumerState<GateEntryPage> {
  String? _taskId;
  final TextEditingController _vehicle = TextEditingController();
  final TextEditingController _driver = TextEditingController();
  bool _working = false;

  @override
  void dispose() {
    _vehicle.dispose();
    _driver.dispose();
    super.dispose();
  }

  Future<void> _gateIn(HubTask task) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (_vehicle.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.fillAllFields)));
      return;
    }
    setState(() => _working = true);
    try {
      await ref
          .read(hubRepositoryProvider)
          .gateIn(task.id, _vehicle.text.trim(), _driver.text.trim());
    } catch (_) {}
    if (!mounted) return;
    setState(() => _working = false);
    ref.invalidate(hubTasksProvider);
  }

  Future<void> _gateOut(HubTask task) async {
    setState(() => _working = true);
    try {
      await ref.read(hubRepositoryProvider).gateOut(task.id);
    } catch (_) {}
    if (!mounted) return;
    setState(() => _working = false);
    ref.invalidate(hubTasksProvider);
  }

  String _deltaLabel(AppLocalizations l10n, DateTime gateIn, DateTime? eta) {
    if (eta == null) return '';
    final Duration diff = gateIn.difference(eta);
    final String abs = Formatters.duration(diff.abs());
    return diff.isNegative ? l10n.gateEarly(abs) : l10n.gateLate(abs);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<HubTask>> tasks = ref.watch(hubTasksProvider);
    return AppScaffold(
      title: l10n.gateTitle,
      body: tasks.when(
        loading: () => const SkeletonList(),
        error: (e, _) => ErrorState(message: l10n.commonError),
        data: (List<HubTask> items) {
          if (items.isEmpty) {
            return Center(child: Text(l10n.commonEmpty));
          }
          // Default to the first vehicle so the page always shows data.
          final String activeId = items.any((t) => t.id == _taskId)
              ? _taskId!
              : items.first.id;
          HubTask task = items.first;
          for (final HubTask t in items) {
            if (t.id == activeId) task = t;
          }
          final HubTask current = task;
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              DropdownButtonFormField<String>(
                initialValue: current.id,
                decoration: InputDecoration(labelText: l10n.selectVehicle),
                items: [
                  for (final HubTask t in items)
                    DropdownMenuItem(
                      value: t.id,
                      child: Text('${t.vehicleNo} · ${t.customer}'),
                    ),
                ],
                onChanged: (v) => setState(() => _taskId = v),
              ),
              const SizedBox(height: AppSpacing.md),
              _GateStatusCard(task: current),
              const SizedBox(height: AppSpacing.md),
              if (current.gateInAt == null) ...[
                AppTextField(
                  controller: _vehicle,
                  label: l10n.vehicleNoLabel,
                  prefixIcon: Icons.local_shipping_outlined,
                ),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  controller: _driver,
                  label: l10n.driverNameLabel,
                  prefixIcon: Icons.person_outline,
                ),
                const SizedBox(height: AppSpacing.md),
                AppButton(
                  label: l10n.gateInAction,
                  loading: _working,
                  onPressed: _working ? null : () => _gateIn(current),
                ),
              ] else ...[
                Row(
                  children: [
                    StatusChip(
                      label: _deltaLabel(l10n, current.gateInAt!, current.eta),
                      color: AppColors.info,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        '${l10n.gateInAction}: '
                        '${Formatters.dateTime(current.gateInAt!)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: context.tokens.inkMuted,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                if (current.gateOutAt == null)
                  AppButton(
                    label: l10n.gateOutAction,
                    loading: _working,
                    onPressed: _working ? null : () => _gateOut(current),
                  )
                else
                  _DoneRow(
                    label: l10n.gateOutAction,
                    time: Formatters.dateTime(current.gateOutAt!),
                  ),
              ],
            ],
          );
        },
      ),
    );
  }
}

/// Vehicle summary card: number, customer, ETA.
class _GateStatusCard extends StatelessWidget {
  const _GateStatusCard({required this.task});

  final HubTask task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        borderRadius: AppSpacing.cardRadius,
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white24,
            ),
            child: const Icon(
              Icons.local_shipping_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.vehicleNo,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  task.eta == null
                      ? task.customer
                      : '${task.customer} · ETA ${Formatters.time(task.eta!)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          StatusChip(
            label: task.gateOutAt != null
                ? AppLocalizations.of(context).hubDone
                : task.gateInAt != null
                ? AppLocalizations.of(context).hubInProgress
                : AppLocalizations.of(context).hubPending,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

/// Completed timestamp row.
class _DoneRow extends StatelessWidget {
  const _DoneRow({required this.label, required this.time});

  final String label;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.check_circle_outline,
          size: 18,
          color: AppColors.success,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            '$label: $time',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
