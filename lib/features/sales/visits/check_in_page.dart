import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/services/image_service.dart';
import '../../../core/services/location_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/photo_capture_sheet.dart';
import '../../../data/models/lead.dart';
import '../../../data/repositories/repository_providers.dart';
import '../application/sales_providers.dart';

/// GPS check-in (coordinates + photo + note) and check-out with outcome.
class CheckInPage extends ConsumerStatefulWidget {
  const CheckInPage({super.key});

  @override
  ConsumerState<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends ConsumerState<CheckInPage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _note = TextEditingController();
  final TextEditingController _outcome = TextEditingController();
  String? _photo;
  Visit? _active;
  bool _working = false;

  @override
  void dispose() {
    _title.dispose();
    _note.dispose();
    _outcome.dispose();
    super.dispose();
  }

  Future<void> _capture() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final PhotoSource? source = await PhotoCaptureSheet.show(
      context,
      cameraLabel: l10n.photoCamera,
      galleryLabel: l10n.photoGallery,
    );
    if (source == null || !mounted) return;
    final String? path = await ref
        .read(imageServiceProvider)
        .capture(source: source, tag: 'visit');
    if (!mounted || path == null) return;
    setState(() => _photo = path);
  }

  Future<void> _checkIn() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (_title.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.fillAllFields)),
      );
      return;
    }
    setState(() => _working = true);
    final ({double lat, double lng})? fix =
        await ref.read(locationServiceProvider).currentPosition();
    try {
      final Visit visit =
          await ref.read(leadRepositoryProvider).checkIn(
                Visit(
                  id: 'local',
                  title: _title.text.trim(),
                  plannedAt: DateTime.now(),
                  lat: fix?.lat,
                  lng: fix?.lng,
                  photoPath: _photo,
                  note: _note.text.trim().isEmpty
                      ? null
                      : _note.text.trim(),
                ),
              );
      if (!mounted) return;
      setState(() {
        _working = false;
        _active = visit;
      });
      ref.invalidate(plannedVisitsProvider);
    } catch (_) {
      if (!mounted) return;
      setState(() => _working = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.commonError)),
      );
    }
  }

  Future<void> _checkOut() async {
    if (_active == null || _outcome.text.trim().isEmpty) return;
    setState(() => _working = true);
    try {
      await ref.read(leadRepositoryProvider).checkOut(
            _active!.id,
            _outcome.text.trim(),
          );
    } catch (_) {}
    if (!mounted) return;
    setState(() => _working = false);
    ref.invalidate(plannedVisitsProvider);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppColorTokens tokens = context.tokens;
    return AppScaffold(
      title: l10n.checkInTitle,
      body: Column(
        children: [
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
                          Icons.location_on_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              _active == null
                                  ? l10n.checkInTitle
                                  : _active!.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              _active == null
                                  ? l10n.visitPlanned
                                  : l10n.visitActive,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.white.withValues(
                                      alpha: 0.85,
                                    ),
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                if (_active == null) ...[
                  _FieldCard(
                    child: Column(
                      children: [
                        AppTextField(
                          controller: _title,
                          label: l10n.visitCustomerLabel,
                          prefixIcon:
                              Icons.business_outlined,
                        ),
                        const SizedBox(
                          height: AppSpacing.md,
                        ),
                        AppTextField(
                          controller: _note,
                          label: l10n.noteHint,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  GestureDetector(
                    onTap: _capture,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding:
                          const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: _photo == null
                            ? tokens.primary
                                .withValues(alpha: 0.08)
                            : AppColors.success
                                .withValues(alpha: 0.1),
                        borderRadius: AppSpacing.cardRadius,
                        border: Border.all(
                          color: _photo == null
                              ? tokens.primary
                                  .withValues(alpha: 0.25)
                              : AppColors.success
                                  .withValues(alpha: 0.4),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _photo == null
                                  ? tokens.primary
                                  : AppColors.success,
                            ),
                            child: Icon(
                              _photo == null
                                  ? Icons.photo_camera_outlined
                                  : Icons.check_outlined,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _photo == null
                                      ? l10n.checkinPhoto
                                      : l10n.photoRetake,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: _photo == null
                                            ? tokens.primary
                                            : AppColors.success,
                                      ),
                                ),
                                if (_photo != null)
                                  Text(
                                    _photo!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color:
                                              tokens.inkMuted,
                                        ),
                                    maxLines: 1,
                                    overflow:
                                        TextOverflow.ellipsis,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  _FieldCard(
                    child: AppTextField(
                      controller: _outcome,
                      label: l10n.outcomeLabel,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SafeArea(
            top: false,
            child: _active == null
                ? AppButton(
                    label: l10n.checkInAction,
                    icon: Icons.location_on_outlined,
                    loading: _working,
                    onPressed: _working ? null : _checkIn,
                  )
                : AppButton(
                    label: l10n.checkOutAction,
                    loading: _working,
                    onPressed: _working ? null : _checkOut,
                  ),
          ),
        ],
      ),
    );
  }
}

/// White card grouping form fields.
class _FieldCard extends StatelessWidget {
  const _FieldCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.tokens.surface,
        borderRadius: AppSpacing.cardRadius,
        border: Border.all(color: context.tokens.border),
      ),
      child: child,
    );
  }
}
