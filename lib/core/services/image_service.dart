import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/constants.dart';
import '../widgets/photo_capture_sheet.dart';

part 'image_service.g.dart';

@Riverpod(keepAlive: true)
ImageService imageService(Ref ref) => ImageService();

/// Capture + compress (max 1280px edge, JPEG q70) into the app documents
/// dir. Files never touch the gallery and stay queued until uploaded.
/// Returns the stored path, or null when cancelled/unavailable.
class ImageService {
  ImageService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  Future<String?> capture({
    required PhotoSource source,
    String? tag,
  }) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: source == PhotoSource.camera
            ? ImageSource.camera
            : ImageSource.gallery,
        maxWidth: AppConstants.imageMaxEdge.toDouble(),
        maxHeight: AppConstants.imageMaxEdge.toDouble(),
        imageQuality: 85,
      );
      if (picked == null) return null;
      final Directory dir = await getApplicationDocumentsDirectory();
      final String target =
          '${dir.path}/roadops_${tag ?? 'img'}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final XFile? compressed =
          await FlutterImageCompress.compressAndGetFile(
        picked.path,
        target,
        quality: AppConstants.imageJpegQuality,
        minWidth: AppConstants.imageMaxEdge,
        minHeight: AppConstants.imageMaxEdge,
      );
      return (compressed ?? picked).path;
    } catch (_) {
      return null;
    }
  }
}
