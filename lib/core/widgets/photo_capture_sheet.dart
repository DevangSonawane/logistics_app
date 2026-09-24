import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

/// Which source the user picked in the photo capture sheet.
/// Capture + compression itself is wired in Phase 3 (image_service).
enum PhotoSource { camera, gallery }

/// Bottom sheet: camera or gallery choice with preview handled by callers.
/// Labels are passed in (localized) so the sheet holds no strings.
class PhotoCaptureSheet extends StatelessWidget {
  const PhotoCaptureSheet({
    super.key,
    required this.cameraLabel,
    required this.galleryLabel,
  });

  final String cameraLabel;
  final String galleryLabel;

  static Future<PhotoSource?> show(
    BuildContext context, {
    required String cameraLabel,
    required String galleryLabel,
  }) {
    return showModalBottomSheet<PhotoSource>(
      context: context,
      builder: (_) => PhotoCaptureSheet(
        cameraLabel: cameraLabel,
        galleryLabel: galleryLabel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: Text(cameraLabel),
              onTap: () => Navigator.of(context).pop(PhotoSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(galleryLabel),
              onTap: () => Navigator.of(context).pop(PhotoSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}
