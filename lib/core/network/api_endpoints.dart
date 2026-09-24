/// REST path placeholders for the future real API.
/// The mock layer never reads these; they document the contract only.
abstract final class ApiEndpoints {
  static const String baseUrl = 'https://api.roadops.example.com/v1';

  static const String sendOtp = '/auth/otp/send';
  static const String verifyOtp = '/auth/otp/verify';
  static const String refresh = '/auth/refresh';

  static const String trips = '/trips';
  static const String orders = '/orders';
  static const String vehicles = '/vehicles';
  static const String drivers = '/drivers';
  static const String expenses = '/expenses';
  static const String advances = '/advances';
  static const String approvals = '/approvals';
  static const String leads = '/leads';
  static const String quotes = '/quotes';
  static const String invoices = '/invoices';
  static const String sync = '/sync';
}
