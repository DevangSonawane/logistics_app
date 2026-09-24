import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/app_user.dart';
import '../../data/models/driver.dart';
import '../../data/models/hire.dart';
import '../../data/models/order.dart';
import '../../data/models/trip.dart';
import '../../features/auth/application/logout_flow.dart';
import '../../features/auth/application/session_provider.dart';
import '../../features/auth/presentation/biometric_setup_page.dart';
import '../../features/auth/presentation/lock_page.dart';
import '../../features/auth/presentation/login_page.dart';
import '../../features/auth/presentation/otp_page.dart';
import '../../features/auth/presentation/permissions_page.dart';
import '../../features/auth/presentation/role_picker_page.dart';
import '../../features/common/profile/profile_page.dart';
import '../../features/driver/advances/advance_ledger_page.dart';
import '../../features/driver/advances/request_advance_page.dart';
import '../../features/driver/documents/driver_documents_page.dart';
import '../../features/driver/earnings/earnings_page.dart';
import '../../features/driver/earnings/payslip_page.dart';
import '../../features/driver/expenses/add_expense_page.dart';
import '../../features/driver/expenses/expense_list_page.dart';
import '../../features/driver/my_trip/my_trip_page.dart';
import '../../features/driver/pod/pod_capture_page.dart';
import '../../features/driver/shell/driver_shell.dart';
import '../../features/driver/sos/sos_page.dart';
import '../../features/driver/sync/offline_queue_page.dart';
import '../../features/onboarding/language_select_page.dart';
import '../../features/ops/exceptions/exceptions_feed_page.dart';
import '../../features/ops/market/hire_memo_page.dart';
import '../../features/ops/market/hire_vehicle_page.dart';
import '../../features/ops/orders/create_order_page.dart';
import '../../features/ops/orders/order_detail_page.dart';
import '../../features/ops/orders/order_list_page.dart';
import '../../features/ops/planning/plan_landing_page.dart';
import '../../features/ops/planning/plan_trip_page.dart';
import '../../features/ops/shell/ops_shell.dart';
import '../../features/ops/trips/live_trips_page.dart';
import '../../features/ops/trips/trip_control_page.dart';
import '../../features/owner/accounts/accounts_home_page.dart';
import '../../features/owner/accounts/ageing_page.dart';
import '../../features/owner/accounts/daybook_page.dart';
import '../../features/owner/accounts/ledger_page.dart';
import '../../features/owner/accounts/pnl_page.dart';
import '../../features/owner/approvals/approvals_inbox_page.dart';
import '../../features/owner/brief/daily_brief_page.dart';
import '../../features/owner/dashboard/owner_dashboard_page.dart';
import '../../features/owner/live_map/live_map_page.dart';
import '../../features/owner/more/notification_settings_page.dart';
import '../../features/owner/shell/owner_shell.dart';
import '../../features/splash/splash_page.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../widgets/app_scaffold.dart';
import 'role_guard.dart';
import 'role_labels.dart';
import 'route_names.dart';

part 'app_router.g.dart';

/// App router with role-based redirect guards. The router is created once
/// and re-evaluates [roleGuard] on every session change via refresh().
///
/// Each role gets its own ShellRoute; sales/supervisor/accountant tabbed
/// shells land in Phase 7. Deep links (roadops://trip/{id} ...) are wired
/// in Phase 6 with the notification centre.
/// TODO(Phase 6): notification centre, global search, settings pages.
/// TODO(Phase 7): sales, supervisor and accountant shells.
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    redirect: (BuildContext context, GoRouterState state) =>
        roleGuard(ref.read(sessionProvider), state),
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RouteNames.language,
        builder: (context, state) => const LanguageSelectPage(),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteNames.otp,
        builder: (context, state) {
          final String phone = state.extra as String? ?? '';
          return OtpPage(phone: phone);
        },
      ),
      GoRoute(
        path: RouteNames.rolePicker,
        builder: (context, state) => const RolePickerPage(),
      ),
      GoRoute(
        path: RouteNames.permissions,
        builder: (context, state) => const PermissionsPage(),
      ),
      GoRoute(
        path: RouteNames.biometricSetup,
        builder: (context, state) => const BiometricSetupPage(),
      ),
      GoRoute(
        path: RouteNames.lock,
        builder: (context, state) => const LockPage(),
      ),
      GoRoute(
        path: RouteNames.profile,
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: RouteNames.forbidden,
        builder: (context, state) => const _ForbiddenPage(),
      ),
      for (final AppRole role in AppRole.values)
        if (role != AppRole.driver &&
            role != AppRole.owner &&
            role != AppRole.ops)
          ShellRoute(
            builder: (context, state, child) =>
                _RoleShell(role: role, child: child),
            routes: [
              GoRoute(
                path: '/${role.name}/home',
                builder: (context, state) => _RoleHomePage(role: role),
              ),
            ],
          ),
      // Owner shell: 5 tabs.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            OwnerShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.ownerHome,
                builder: (context, state) => const OwnerDashboardPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.ownerApprovals,
                builder: (context, state) => const ApprovalsInboxPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.ownerAccounts,
                builder: (context, state) => const AccountsHomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.ownerMap,
                builder: (context, state) => const LiveMapPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.ownerMore,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.ownerLedger,
        builder: (context, state) {
          final String kind = state.extra as String? ?? 'customer';
          return LedgerPage(kind: kind);
        },
      ),
      GoRoute(
        path: RouteNames.ownerAgeing,
        builder: (context, state) => const AgeingPage(),
      ),
      GoRoute(
        path: RouteNames.ownerPnl,
        builder: (context, state) => const PnlPage(),
      ),
      GoRoute(
        path: RouteNames.ownerDaybook,
        builder: (context, state) => const DaybookPage(),
      ),
      GoRoute(
        path: RouteNames.ownerBrief,
        builder: (context, state) => const DailyBriefPage(),
      ),
      GoRoute(
        path: RouteNames.ownerAlerts,
        builder: (context, state) => const NotificationSettingsPage(),
      ),
      // Ops shell: 5 tabs.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            OpsShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.opsOrders,
                builder: (context, state) => const OrderListPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.opsPlan,
                builder: (context, state) => const PlanLandingPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.opsTrips,
                builder: (context, state) => const LiveTripsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.opsExceptions,
                builder: (context, state) => const ExceptionsFeedPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.opsMore,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.opsOrderNew,
        builder: (context, state) => const CreateOrderPage(),
      ),
      GoRoute(
        path: '${RouteNames.opsOrders}/:id',
        builder: (context, state) {
          final String id = state.pathParameters['id'] ?? '';
          return OrderDetailPage(orderId: id);
        },
      ),
      GoRoute(
        path: '${RouteNames.opsPlan}/:orderId',
        builder: (context, state) {
          final String orderId = state.pathParameters['orderId'] ?? '';
          return PlanTripPage(orderId: orderId);
        },
      ),
      GoRoute(
        path: '${RouteNames.opsTrips}/:id',
        builder: (context, state) {
          final String id = state.pathParameters['id'] ?? '';
          return TripControlPage(tripId: id);
        },
      ),
      GoRoute(
        path: RouteNames.opsMarket,
        builder: (context, state) => const HireVehiclePage(),
      ),
      GoRoute(
        path: RouteNames.opsMemo,
        builder: (context, state) {
          final MarketVehicle vehicle = state.extra as MarketVehicle;
          return HireMemoPage(vehicle: vehicle);
        },
      ),
      // Driver shell: 4 tabs (My Trip, Earnings, Documents, Profile).
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            DriverShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.driverHome,
                builder: (context, state) => const MyTripPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.driverEarnings,
                builder: (context, state) => const EarningsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.driverDocuments,
                builder: (context, state) => const DriverDocumentsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.driverProfile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.driverPod,
        builder: (context, state) {
          final Trip trip = state.extra as Trip;
          return PodCapturePage(trip: trip);
        },
      ),
      GoRoute(
        path: RouteNames.driverExpenses,
        builder: (context, state) => const ExpenseListPage(),
      ),
      GoRoute(
        path: RouteNames.driverAddExpense,
        builder: (context, state) {
          final Trip trip = state.extra as Trip;
          return AddExpensePage(trip: trip);
        },
      ),
      GoRoute(
        path: RouteNames.driverAdvances,
        builder: (context, state) => const AdvanceLedgerPage(),
      ),
      GoRoute(
        path: RouteNames.driverRequestAdvance,
        builder: (context, state) {
          final Trip trip = state.extra as Trip;
          return RequestAdvancePage(trip: trip);
        },
      ),
      GoRoute(
        path: RouteNames.driverSos,
        builder: (context, state) => const SosPage(),
      ),
      GoRoute(
        path: RouteNames.driverQueue,
        builder: (context, state) => const OfflineQueuePage(),
      ),
      GoRoute(
        path: RouteNames.driverPayslip,
        builder: (context, state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          return PayslipPage(slip: extra['slip'] as SalarySlip);
        },
      ),
    ],
  );
  ref.onDispose(router.dispose);
  ref.listen(sessionProvider, (_, __) => router.refresh());
  return router;
}

/// Minimal role shell for Phase 2. Real tabbed shells arrive per phase.
class _RoleShell extends ConsumerWidget {
  const _RoleShell({required this.role, required this.child});

  final AppRole role;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roleLabel(AppLocalizations.of(context), role)),
        actions: [
          IconButton(
            tooltip: AppLocalizations.of(context).profileTitle,
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.go(RouteNames.profile),
          ),
        ],
      ),
      body: child,
    );
  }
}

class _RoleHomePage extends ConsumerWidget {
  const _RoleHomePage({required this.role});

  final AppRole role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.greeting(ref.watch(
                sessionProvider.select(
                  (SessionState s) => s.user?.name ?? '',
                ),
              )),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(l10n.phaseComingSoon(_phaseFor(role))),
            const SizedBox(height: AppSpacing.xl),
            OutlinedButton.icon(
              icon: const Icon(Icons.logout),
              label: Text(l10n.logoutAction),
              onPressed: () => runLogoutFlow(context, ref),
            ),
          ],
        ),
      ),
    );
  }
}

class _ForbiddenPage extends StatelessWidget {
  const _ForbiddenPage();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.block,
              size: AppSpacing.huge,
              color: AppColors.danger,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.forbiddenTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(l10n.forbiddenMessage),
          ],
        ),
      ),
    );
  }
}

String _phaseFor(AppRole role) {
  return switch (role) {
    AppRole.driver => 'Phase 3',
    AppRole.owner || AppRole.ops => 'Phases 4-5',
    AppRole.sales || AppRole.supervisor || AppRole.accountant => 'Phase 7',
  };
}
