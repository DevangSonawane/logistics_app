/// Field validators. They return booleans only; screens map failures to
/// localized messages from ARB files so no hard-coded strings live here.
abstract final class Validators {
  static final RegExp _phone = RegExp(r'^[6-9]\d{9}$');
  static final RegExp _otp = RegExp(r'^\d{6}$');
  static final RegExp _gstin =
      RegExp(r'^\d{2}[A-Z]{5}\d{4}[A-Z][A-Z\d]Z[A-Z\d]$');
  static final RegExp _pan = RegExp(r'^[A-Z]{5}\d{4}[A-Z]$');
  static final RegExp _vehicleNo =
      RegExp(r'^[A-Z]{2}\s?\d{1,2}\s?[A-Z]{1,3}\s?\d{3,4}$');

  /// 10-digit Indian mobile number without +91 (starts 6-9).
  static bool isPhoneValid(String value) =>
      _phone.hasMatch(value.trim());

  static bool isOtpValid(String value) => _otp.hasMatch(value.trim());

  /// 15-char GSTIN, e.g. 27AAKCS1234F1Z5.
  static bool isGstinValid(String value) =>
      _gstin.hasMatch(value.trim().toUpperCase());

  /// PAN, e.g. AAKCS1234F.
  static bool isPanValid(String value) =>
      _pan.hasMatch(value.trim().toUpperCase());

  /// Indian vehicle registration, e.g. MH 12 AB 1234.
  static bool isVehicleNoValid(String value) =>
      _vehicleNo.hasMatch(value.trim().toUpperCase());

  static bool isRequired(String value) => value.trim().isNotEmpty;

  static bool minLength(String value, int length) =>
      value.trim().length >= length;
}
