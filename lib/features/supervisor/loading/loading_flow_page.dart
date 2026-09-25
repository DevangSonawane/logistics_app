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
    return ref
        .read(imageServiceProvider)
        .capture(source: source, tag: tag);
  }

  Future<void> _complete(HubTask task) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (_startPhoto == null ||
        _endPhoto == null ||
        _seal.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.fillAllFields)),
      );
      return;
    }
    setState(() => _working = true);
    try {
      await ref.read(hubRepositoryProvider).updateTask(
            task.copyWith(
              sealNo: _seal.text.trim(),
              weighmentKg:
                  double.tryParse(_weight.text.trim()),
              status: HubTaskStatus.done,
            ),
          );
    } catch (_) {}
    if (!mounted) return;
    setState(() => _working = false);
    ref.invalidate(hubTasksProvider);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.loadingComplete)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<HubTask>> tasks =
        ref.watch(hubTasksProvider);
    return tasks.when(
      loading: () => AppScaffold(
        title: l10n.loadingTitle,
        body: const SkeletonList(),
      ),
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
        final bool mismatch = entered != null &&
            current.declaredKg != null &&
            (entered - current.declaredKg!).abs() >
                current.declaredKg! * 0.02;
        return AppScaffold(
          title: '${l10n.loadingTitle} ${current.vehicleNo}',
          body: ListView(
            children: [
              _PhotoRow(
                label: l10n.loadingStartPhoto,
                path: _startPhoto,
                onCapture: () async {
                  final String? path =
                      await _capture('${current.id}-start');
                  if (path != null && mounted) {
                    setState(() => _startPhoto = path);
                  }
                },
              ),
              const SizedBox(height: AppSpacing.md),
              _PhotoRow(
                label: l10n.loadingEndPhoto,
                path: _endPhoto,
                onCapture: () async {
                  final String? path =
                      await _capture('${current.id}-end');
                  if (path != null && mounted) {
                    setState(() => _endPhoto = path);
                  }
                },
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _seal,
                label: l10n.sealNoLabel,
              ),
              const SizedBox(height: AppSpacing.md),
              _PhotoRow(
                label: l10n.weighmentSlip,
                path: _slipPhoto,
                onCapture: () async {
                  final String? path =
                      await _capture('${current.id}-weigh');
                  if (path != null && mounted) {
                    setState(() => _slipPhoto = path);
                  }
                },
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _weight,
                label:
                    '${l10n.weightLabel} (declared ${current.declaredKg?.round() ?? '-'} kg)',
                keyboardType: TextInputType.number,
                onChanged: (_) => setState(() {}),
              ),
              if (mismatch) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.weightMismatch,
                  style: const TextStyle(color: AppColors.warning),
                ),
              ],
              const SizedBox(height: AppSpacing.xl),
              AppButton(
                label: l10n.completeLoading,
                variant: AppButtonVariant.accent,
                large: true,
                loading: _working,
                onPressed:
                    _working ? null : () => _complete(current),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PhotoRow extends StatelessWidget {
  const _PhotoRow({
    required this.label,
    required this.path,
    required this.onCapture,
  });

  final String label;
  final String? path;
  final VoidCallback onCapture;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        if (path != null)
          ClipRRect(
            borderRadius: AppSpacing.inputRadius,
            child: Image.file(
              File(path!),
              width: AppSpacing.huge,
              height: AppSpacing.huge,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: AppSpacing.huge,
                height: AppSpacing.huge,
                color: context.tokens.surfaceAlt,
                child: const Icon(Icons.photo_outlined),
              ),
            ),
          )
        else
          OutlinedButton.icon(
            icon: const Icon(Icons.add_a_photo_outlined),
            label: Text(label),
            onPressed: onCapture,
          ),
      ],
    );
  }
}
