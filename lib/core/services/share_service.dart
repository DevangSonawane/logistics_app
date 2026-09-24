import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'pdf_service.dart';

/// Share sheets for tracking links, PDFs, quotes and payment reminders.
/// TODO(Phase 7): WhatsApp Business API templates for reminders.
class ShareService {
  /// Generates a statement PDF and opens the system share sheet
  /// (user picks WhatsApp, Mail, Drive...).
  Future<bool> sharePdf(String title, List<(String, String)> rows) async {
    try {
      final Uint8List bytes =
          await PdfService().statement(title: title, rows: rows);
      final Directory dir = await getTemporaryDirectory();
      final String path =
          '${dir.path}/roadops_${DateTime.now().millisecondsSinceEpoch}.pdf';
      await File(path).writeAsBytes(bytes);
      await Share.shareXFiles([XFile(path)], text: title);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> shareText(String text) async {
    try {
      await Share.share(text);
      return true;
    } catch (_) {
      return false;
    }
  }
}
