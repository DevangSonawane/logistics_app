import '../../data/models/app_user.dart';

/// All route paths. Role homes live under /{role}/home so the guard can
/// enforce isolation in one place.
abstract final class RouteNames {
  static const String splash = '/';
  static const String language = '/language';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String rolePicker = '/role-picker';
  static const String permissions = '/permissions';
  static const String biometricSetup = '/biometric-setup';
  static const String lock = '/lock';
  static const String forbidden = '/403';
  static const String profile = '/profile';

  static const String driverHome = '/driver/home';
  static const String driverEarnings = '/driver/earnings';
  static const String driverDocuments = '/driver/documents';
  static const String driverProfile = '/driver/profile';
  static const String driverPod = '/driver/pod';
  static const String driverExpenses = '/driver/expenses';
  static const String driverAddExpense = '/driver/expenses/add';
  static const String driverAdvances = '/driver/advances';
  static const String driverRequestAdvance = '/driver/advances/request';
  static const String driverSos = '/driver/sos';
  static const String driverQueue = '/driver/queue';
  static const String driverPayslip = '/driver/payslip';
  static const String ownerHome = '/owner/home';
  static const String ownerApprovals = '/owner/approvals';
  static const String ownerAccounts = '/owner/accounts';
  static const String ownerLedger = '/owner/accounts/ledger';
  static const String ownerAgeing = '/owner/accounts/ageing';
  static const String ownerPnl = '/owner/accounts/pnl';
  static const String ownerDaybook = '/owner/accounts/daybook';
  static const String ownerMap = '/owner/map';
  static const String ownerBrief = '/owner/brief';
  static const String ownerAlerts = '/owner/alerts';
  static const String ownerMore = '/owner/more';
  static const String opsOrders = '/ops/orders';
  static const String opsOrderNew = '/ops/orders/new';
  static const String opsPlan = '/ops/plan';
  static const String opsTrips = '/ops/trips';
  static const String opsExceptions = '/ops/exceptions';
  static const String opsMore = '/ops/more';
  static const String opsMarket = '/ops/market';
  static const String opsMemo = '/ops/market/memo';
  static const String salesHome = '/sales/home';
  static const String supervisorHome = '/supervisor/home';
  static const String accountantHome = '/accountant/home';

  /// Home route for a role. Unknown/null falls back to login.
  static String homeFor(AppRole? role) {
    return switch (role) {
      AppRole.driver => driverHome,
      AppRole.owner => ownerHome,
      // Ops lands on the orders tab (shell root has no separate home).
      AppRole.ops => opsOrders,
      AppRole.sales => salesHome,
      AppRole.supervisor => supervisorHome,
      AppRole.accountant => accountantHome,
      null => login,
    };
  }

  /// Role segment owning a path, e.g. /driver/... -> AppRole.driver.
  static AppRole? roleForPath(String path) {
    for (final AppRole role in AppRole.values) {
      if (path == '/${role.name}' || path.startsWith('/${role.name}/')) {
        return role;
      }
    }
    return null;
  }
}
