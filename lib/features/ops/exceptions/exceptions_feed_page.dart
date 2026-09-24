import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/launch_helpers.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../core/widgets/status_chip.dart';
import '../../../data/models/exception.dart';
import '../../../data/repositories/repository_providers.dart';
import '../application/ops_providers.dart';

/// P5. Exceptions feed: SOS pinned red, quick actions per row
/// (call, extend e-way, escalate, resolve with note).
class ExceptionsFeedPage extends ConsumerWidget {
  const ExceptionsFeedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<ExceptionItem>> feed =
        ref.watch(exceptionsFeedProvider);
    return AppScaffold(
      title: l10n.exceptionsTitle,
      refresh: () async {
        ref.invalidate(exceptionsFeedProvider);
      },
      body: feed.when(
        loading: () => const SkeletonList(),
        error: (e, _) => ErrorState(
          message: l10n.commonError,
          onRetry: () => ref.invalidate(exceptionsFeedProvider),
        ),
        data: (List<ExceptionItem> items) {
          final List<ExceptionItem> open =
              items.where((e) => !e.resolved).toList();
          if (open.isEmpty) {
            return EmptyState(
              title: l10n.noExceptions,
              message: '',
              icon: Icons.check_circle_outline,
            );
          }
          return ListView.separated(
            itemCount: open.length,
            separatorBuilder: (_, __) =>
                const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) =>
                _ExceptionCard(item: open[index]),
          );
        },
      ),
    );
  }
}

class _ExceptionCard extends ConsumerStatefulWidget {
  const _ExceptionCard({required this.item});

  final ExceptionItem item;

  @override
  ConsumerState<_ExceptionCard> createState() => _ExceptionCardState();
}

class _ExceptionCardState extends ConsumerState<_ExceptionCard> {
  bool _working = false;

  Color get _color {
    return switch (widget.item.severity) {
      ExceptionSeverity.low => context.tokens.inkFaint,
      ExceptionSeverity.medium => AppColors.warning,
      ExceptionSeverity.high => AppColors.podPending,
      ExceptionSeverity.critical => AppColors.danger,
    };
  }

  Future<void> _resolve([String? preset]) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    String? note = preset;
    if (note == null) {
      final TextEditingController controller = TextEditingController();
      note = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.resolveAction),
          content: AppTextField(
            controller: controller,
            label: l10n.noteHint,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.cancelAction),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(controller.text.trim()),
              child: Text(l10n.resolveAction),
            ),
          ],
        ),
      );
      if (note == null || note.isEmpty || !mounted) return;
    }
    setState(() => _working = true);
    try {
      await ref
          .read(exceptionRepositoryProvider)
          .resolve(widget.item.id, note);
    } catch (_) {}
    if (!mounted) return;
    setState(() => _working = false);
    ref.invalidate(exceptionsFeedProvider);
    ref.invalidate(openExceptionsCountProvider);
  }

  Future<void> _escalate() async {
    setState(() => _working = true);
    try {
      await ref
          .read(exceptionRepositoryProvider)
          .escalate(widget.item.id);
    } catch (_) {}
    if (!mounted) return;
    setState(() => _working = false);
    ref.invalidate(exceptionsFeedProvider);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ExceptionItem item = widget.item;
    final bool isSos = item.type == ExceptionType.sos;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isSos
            ? AppColors.danger.withValues(alpha: 0.06)
            : context.tokens.surface,
        borderRadius: AppSpacing.cardRadius,
        border: Border.all(
          color: isSos ? AppColors.danger : context.tokens.border,
          width: isSos ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (isSos)
                const Padding(
                  padding: EdgeInsets.only(right: AppSpacing.sm),
                  child: Icon(Icons.sos, color: AppColors.danger),
                ),
              Expanded(
                child: Text(
                  item.message,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              StatusChip(
                label: _typeLabel(l10n, item.type),
                color: _color,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${item.vehicleReg} · ${item.driverName} · ${Formatters.dateTime(item.at)}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.tokens.inkMuted,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              OutlinedButton.icon(
                icon: const Icon(Icons.phone_outlined, size: 18),
                label: Text(l10n.callAction),
                onPressed: _working
                    ? null
                    : () => LaunchHelpers.call(item.driverPhone),
              ),
              if (item.type == ExceptionType.ewayExpiring)
                OutlinedButton(
                  onPressed:
                      _working ? null : () => _resolve(l10n.ewayExtended),
                  child: Text(l10n.extendEway),
                ),
              OutlinedButton(
                onPressed: _working ? null : _escalate,
                child: Text(l10n.escalateAction),
              ),
              OutlinedButton(
                onPressed: _working ? null : () => _resolve(),
                child: Text(l10n.resolveAction),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _typeLabel(AppLocalizations l10n, ExceptionType type) {
    return switch (type) {
      ExceptionType.delay => l10n.exDelay,
      ExceptionType.halt => l10n.exHalt,
      ExceptionType.deviation => l10n.exDeviation,
      ExceptionType.overspeed => l10n.exOverspeed,
      ExceptionType.deviceOff => l10n.exDeviceOff,
      ExceptionType.ewayExpiring => l10n.exEway,
      ExceptionType.podPending => l10n.exPod,
      ExceptionType.sos => l10n.sosTitle,
    };
  }
}
