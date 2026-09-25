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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.fillAllFields)),
      );
      return;
    }
    setState(() => _working = true);
    try {
      await ref.read(hubRepositoryProvider).gateIn(
            task.id,
            _vehicle.text.trim(),
            _driver.text.trim(),
          );
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

  String _deltaLabel(
    AppLocalizations l10n,
    DateTime gateIn,
    DateTime? eta,
  ) {
    if (eta == null) return '';
    final Duration diff = gateIn.difference(eta);
    final String abs = Formatters.duration(diff.abs());
    return diff.isNegative
        ? l10n.gateEarly(abs)
        : l10n.gateLate(abs);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<HubTask>> tasks =
        ref.watch(hubTasksProvider);
    return AppScaffold(
      title: l10n.gateTitle,
      body: tasks.when(
        loading: () => const SkeletonList(),
        error: (e, _) => ErrorState(message: l10n.commonError),
        data: (List<HubTask> items) {
          HubTask? task;
          for (final HubTask t in items) {
            if (t.id == _taskId) task = t;
          }
          if (task == null) {
            return Center(child: Text(l10n.selectVehicle));
          }
          return ListView(
            children: [
              DropdownButtonFormField<String>(
                initialValue: task.id,
                decoration: InputDecoration(
                  labelText: l10n.selectVehicle,
                ),
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
              if (task.gateInAt == null) ...[
                  AppTextField(
                    controller: _vehicle,
                    label: l10n.vehicleNoLabel,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    controller: _driver,
                    label: l10n.driverNameLabel,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppButton(
                    label: l10n.gateInAction,
                    variant: AppButtonVariant.accent,
                    large: true,
                    loading: _working,
                    onPressed:
                        _working ? null : () => _gateIn(task!),
                  ),
                ] else ...[
                  StatusChip(
                    label: _deltaLabel(
                      l10n,
                      task.gateInAt!,
                      task.eta,
                    ),
                    color: AppColors.info,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    '${l10n.gateInAction}: '
                    '${Formatters.dateTime(task.gateInAt!)}',
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  if (task.gateOutAt == null)
                    AppButton(
                      label: l10n.gateOutAction,
                      large: true,
                      loading: _working,
                      onPressed:
                          _working ? null : () => _gateOut(task!),
                    )
                  else
                    Text(
                      '${l10n.gateOutAction}: '
                      '${Formatters.dateTime(task.gateOutAt!)}',
                    ),
                ],
            ],
          );
        },
      ),
    );
  }
}
