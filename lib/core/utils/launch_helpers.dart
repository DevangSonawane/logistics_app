import 'package:url_launcher/url_launcher.dart';

/// External intents: Google Maps navigation, phone calls, WhatsApp shares.
/// All failures return false so callers can show a fallback message.
abstract final class LaunchHelpers {
  static Future<bool> navigate(double lat, double lng) async {
    final Uri uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng',
    );
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }

  static Future<bool> call(String phone) async {
    try {
      return await launchUrl(Uri(scheme: 'tel', path: phone));
    } catch (_) {
      return false;
    }
  }

  static Future<bool> whatsapp(String phone, String text) async {
    final Uri uri = Uri.parse(
      'https://wa.me/$phone?text=${Uri.encodeComponent(text)}',
    );
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }

  /// Opens WhatsApp's share sheet (no recipient) with prefilled text.
  static Future<bool> whatsappShare(String text) async {
    final Uri uri = Uri.parse(
      'https://wa.me/?text=${Uri.encodeComponent(text)}',
    );
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }
}
