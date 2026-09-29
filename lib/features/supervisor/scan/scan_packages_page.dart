import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:uuid/uuid.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/network/connectivity_provider.dart';
import '../../../core/offline/offline_action.dart';
import '../../../core/offline/offline_queue.dart';
import '../../../core/services/image_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/photo_capture_sheet.dart';
import '../../../data/models/hub.dart';

/// V4. PTL scan: continuous scanner, count vs expected, duplicate
/// beep/vibrate, shortage/damage marking with photo. Queues offline.
class ScanPackagesPage extends ConsumerStatefulWidget {
  const ScanPackagesPage({super.key});

  @override
  ConsumerState<ScanPackagesPage> createState() => _ScanPackagesPageState();
}

class _ScanPackagesPageState extends ConsumerState<ScanPackagesPage> {
  final List<ScanItem> _scanned = [];
  final int _expected = 24;
  bool _working = false;

  void _onDetect(BarcodeCapture capture) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    for (final Barcode barcode in capture.barcodes) {
      final String? code = barcode.rawValue;
      if (code == null || code.isEmpty) continue;
      if (_scanned.any((s) => s.code == code)) {
        HapticFeedback.heavyImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.duplicateScan)),
        );
        continue;
      }
      HapticFeedback.selectionClick();
      setState(
        () => _scanned.add(ScanItem(code: code, at: DateTime.now())),
      );
    }
  }

  Future<void> _markIssue(int index, bool damaged) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    String? photo;
    final PhotoSource? source = await PhotoCaptureSheet.show(
      context,
      cameraLabel: l10n.photoCamera,
      galleryLabel: l10n.photoGallery,
    );
    if (source != null && mounted) {
      photo = await ref
          .read(imageServiceProvider)
          .capture(source: source, tag: 'scan-issue');
    }
    if (!mounted) return;
    setState(() {
      _scanned[index] = _scanned[index].copyWith(
        damaged: damaged,
        shortage: !damaged,
        photoPath: photo,
      );
    });
  }

  Future<void> _save() async {
    setState(() => _working = true);
    final OfflineAction action = OfflineAction(
      id: const Uuid().v4(),
      type: OfflineActionType.scanSubmit,
      payload: {
        'count': _scanned.length,
        'codes': [for (final s in _scanned) s.code],
      },
      createdAt: DateTime.now(),
    );
    await ref.read(offlineQueueProvider.notifier).enqueue(action);
    if (!mounted) return;
    setState(() => _working = false);
    final bool online = ref.read(isOnlineProvider);
    if (!online) {
      final AppLocalizations l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.stepQueued)),
      );
    }
    context.push('/supervisor/manifest', extra: List.of(_scanned));
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppColorTokens tokens = context.tokens;
    final double fraction =
        _expected == 0 ? 0 : (_scanned.length / _expected).clamp(0.0, 1.0);
    return AppScaffold(
      title: l10n.scanTitle,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: tokens.primary.withValues(alpha: 0.08),
              borderRadius: AppSpacing.cardRadius,
            ),
            child: Row(
              children: [
                Text(
                  '${_scanned.length} / $_expected',
                  style: AppTypography.kpiNumber(
                    tokens.primary,
                  ).copyWith(fontSize: 22),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: ClipRRect(
                    borderRadius: AppSpacing.chipRadius,
                    child: LinearProgressIndicator(
                      value: fraction,
                      minHeight: 8,
                      backgroundColor: tokens.surface,
                      valueColor: AlwaysStoppedAnimation(
                        tokens.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  '${(fraction * 100).round()}%',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                        color: tokens.primary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          // Centered viewfinder: caps at 300dp, centers in spare space.
          Expanded(
            flex: 5,
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  decoration: BoxDecoration(
                    borderRadius: AppSpacing.cardRadius,
                    border: Border.all(
                      color: tokens.primary,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusCard - 2,
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        MobileScanner(
                          onDetect: _onDetect,
                          errorBuilder: (context, error) =>
                              Center(
                            child: Padding(
                              padding: const EdgeInsets.all(
                                AppSpacing.lg,
                              ),
                              child: Text(
                                l10n.scannerUnavailable,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        IgnorePointer(
                          child: Center(
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white
                                      .withValues(alpha: 0.9),
                                  width: 2,
                                ),
                                borderRadius:
                                    BorderRadius.circular(
                                  AppSpacing.md,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 120,
            child: _scanned.isEmpty
                ? Center(
                    child: Text(
                      l10n.scanToManifest,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: tokens.inkFaint),
                    ),
                  )
                : ListView.separated(
                    itemCount: _scanned.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(
                      height: AppSpacing.xs,
                    ),
                    itemBuilder: (context, index) {
                      final ScanItem item = _scanned[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: tokens.surface,
                          border: Border.all(
                            color: tokens.border,
                          ),
                          borderRadius: AppSpacing.inputRadius,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.code,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: 14),
                                maxLines: 1,
                                overflow:
                                    TextOverflow.ellipsis,
                              ),
                            ),
                            if (item.damaged || item.shortage)
                              const Padding(
                                padding: EdgeInsets.only(
                                  right: AppSpacing.xs,
                                ),
                                child: Icon(
                                  Icons.warning_amber_outlined,
                                  color: AppColors.warning,
                                  size: 18,
                                ),
                              ),
                            SizedBox(
                              width: 32,
                              height: 32,
                              child: PopupMenuButton<bool>(
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.more_vert_outlined,
                                  size: 20,
                                ),
                                onSelected: (v) =>
                                    _markIssue(index, v),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: true,
                                    child:
                                        Text(l10n.markDamage),
                                  ),
                                  PopupMenuItem(
                                    value: false,
                                    child:
                                        Text(l10n.markShortage),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: AppSpacing.sm),
          SafeArea(
            top: false,
            child: AppButton(
              label:
                  '${l10n.createManifest} (${_scanned.length})',
              loading: _working,
              onPressed:
                  _working || _scanned.isEmpty ? null : _save,
            ),
          ),
        ],
      ),
    );
  }
}
