import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/services/image_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/photo_capture_sheet.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../data/models/hub.dart';
import '../../../data/repositories/repository_providers.dart';
import '../application/supervisor_providers.dart';

/// V3. Loading flow: start/end photos, seal number, weighment slip +
/// weight with mismatch warning against declared weight.
class LoadingFlowPage extends ConsumerStatefulWidget {
  const LoadingFlowPage({super.key, required this.taskId});

  final String taskId;

  @override
  ConsumerState<LoadingFlowPage> createState() => _LoadingFlowPageState();
}

class _LoadingFlowPageState extends ConsumerState<LoadingFlowPage> {
  String? _startPhoto;
  String? _endPhoto;
  String? _slipPhoto;
  final TextEditingController _seal = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  bool _working = false;

  @override
  void dispose() {
    _seal.dispose();
    _weight.dispose();
    super.dispose();
  }

  Future<String?> _capture(String tag) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final PhotoSource? source = await PhotoCaptureSheet.show(
      context,
      cameraLabel: l10n.photoCamera,
      galleryLabel: l10n.photoGallery,
    );
    if (source == null || !mounted) return null;
    return ref.read(imageServiceProvider).capture(source: source, tag: tag);
  }

  Future<void> _complete(HubTask task) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (_startPhoto == null || _endPhoto == null || _seal.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.fillAllFields)));
      return;
    }
    setState(() => _working = true);
    try {
      await ref
          .read(hubRepositoryProvider)
          .updateTask(
            task.copyWith(
              sealNo: _seal.text.trim(),
              weighmentKg: double.tryParse(_weight.text.trim()),
              status: HubTaskStatus.done,
            ),
          );
    } catch (_) {}
    if (!mounted) return;
    setState(() => _working = false);
    ref.invalidate(hubTasksProvider);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.loadingComplete)));
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<HubTask>> tasks = ref.watch(hubTasksProvider);
    return tasks.when(
      loading: () =>
          AppScaffold(title: l10n.loadingTitle, body: const SkeletonList()),
      error: (e, _) => AppScaffold(
        title: l10n.loadingTitle,
        body: ErrorState(message: l10n.commonError),
      ),
      data: (List<HubTask> items) {
        HubTask? task;
        for (final HubTask t in items) {
          if (t.id == widget.taskId) task = t;
        }
        if (task == null) {
          return AppScaffold(
            title: l10n.loadingTitle,
            body: ErrorState(message: l10n.commonError),
          );
        }
        final HubTask current = task;
        final double? entered = double.tryParse(_weight.text.trim());
        final bool mismatch =
            entered != null &&
            current.declaredKg != null &&
            (entered - current.declaredKg!).abs() > current.declaredKg! * 0.02;
        return AppScaffold(
          title: '${l10n.loadingTitle} ${current.vehicleNo}',
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _PhotoStep(
                      index: 1,
                      label: l10n.loadingStartPhoto,
                      path: _startPhoto,
                      done: _startPhoto != null,
                      onCapture: () async {
                        final String? path = await _capture(
                          '${current.id}-start',
                        );
                        if (path != null && mounted) {
                          setState(() => _startPhoto = path);
                        }
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _PhotoStep(
                      index: 2,
                      label: l10n.loadingEndPhoto,
                      path: _endPhoto,
                      done: _endPhoto != null,
                      onCapture: () async {
                        final String? path = await _capture(
                          '${current.id}-end',
                        );
                        if (path != null && mounted) {
                          setState(() => _endPhoto = path);
                        }
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _FieldStep(
                      index: 3,
                      child: AppTextField(
                        controller: _seal,
                        label: l10n.sealNoLabel,
                        prefixIcon: Icons.lock_outline,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _PhotoStep(
                      index: 4,
                      label: l10n.weighmentSlip,
                      path: _slipPhoto,
                      done: _slipPhoto != null,
                      optional: true,
                      onCapture: () async {
                        final String? path = await _capture(
                          '${current.id}-weigh',
                        );
                        if (path != null && mounted) {
                          setState(() => _slipPhoto = path);
                        }
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _FieldStep(
                      index: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextField(
                            controller: _weight,
                            label:
                                '${l10n.weightLabel} (declared ${current.declaredKg?.round() ?? '-'} kg)',
                            keyboardType: TextInputType.number,
                            onChanged: (_) => setState(() {}),
                          ),
                          if (mismatch) ...[
                            const SizedBox(height: AppSpacing.xs),
                            Row(
                              children: [
                                const Icon(
                                  Icons.warning_amber_outlined,
                                  size: 14,
                                  color: AppColors.warning,
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Expanded(
                                  child: Text(
                                    l10n.weightMismatch,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: AppColors.warning,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              SafeArea(
                top: false,
                child: AppButton(
                  label: l10n.completeLoading,
                  loading: _working,
                  onPressed: _working ? null : () => _complete(current),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Numbered checklist step with a thumbnail state.
class _PhotoStep extends StatelessWidget {
  const _PhotoStep({
    required this.index,
    required this.label,
    required this.path,
    required this.done,
    required this.onCapture,
    this.optional = false,
  });

  final int index;
  final String label;
  final String? path;
  final bool done;
  final VoidCallback onCapture;
  final bool optional;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    final Color tint = done ? AppColors.success : tokens.primary;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: tokens.surface,
        borderRadius: AppSpacing.cardRadius,
        border: Border.all(
          color: done ? AppColors.success : tokens.border,
          width: done ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: done ? AppColors.success : tint.withValues(alpha: 0.12),
            ),
            child: done
                ? const Icon(
                    Icons.check_outlined,
                    size: 20,
                    color: Colors.white,
                  )
                : Text(
                    '$index',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: tint,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
          if (path != null)
            GestureDetector(
              onTap: onCapture,
              child: ClipRRect(
                borderRadius: AppSpacing.inputRadius,
                child: Image.file(
                  File(path!),
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    width: 48,
                    height: 48,
                    color: tokens.surfaceAlt,
                    child: const Icon(Icons.photo_outlined),
                  ),
                ),
              ),
            )
          else
            IconButton.filledTonal(
              onPressed: onCapture,
              icon: const Icon(Icons.add_a_photo_outlined),
            ),
        ],
      ),
    );
  }
}

/// Numbered checklist step wrapping a form field.
class _FieldStep extends StatelessWidget {
  const _FieldStep({required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: tokens.surface,
        borderRadius: AppSpacing.cardRadius,
        border: Border.all(color: tokens.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: tokens.primary.withValues(alpha: 0.12),
            ),
            child: Text(
              '$index',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: tokens.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: child),
        ],
      ),
    );
  }
}
