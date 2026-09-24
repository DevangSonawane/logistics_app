import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/services/image_service.dart';
import '../../../core/services/location_service.dart';
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
    return AppScaffold(
      title: l10n.checkInTitle,
      body: ListView(
        children: [
          if (_active == null) ...[
            AppTextField(
              controller: _title,
              label: l10n.visitCustomerLabel,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: _note,
              label: l10n.noteHint,
            ),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton.icon(
              icon: const Icon(Icons.photo_camera_outlined),
              label: Text(
                _photo == null
                    ? l10n.checkinPhoto
                    : l10n.photoRetake,
              ),
              onPressed: _capture,
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: l10n.checkInAction,
              variant: AppButtonVariant.accent,
              large: true,
              loading: _working,
              icon: Icons.location_on_outlined,
              onPressed: _working ? null : _checkIn,
            ),
          ] else ...[
            AppTextField(
              controller: _outcome,
              label: l10n.outcomeLabel,
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: l10n.checkOutAction,
              loading: _working,
              onPressed: _working ? null : _checkOut,
            ),
          ],
        ],
      ),
    );
  }
}
