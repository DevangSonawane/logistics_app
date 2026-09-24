import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/driver.dart';
import '../../data/models/hire.dart';
import '../../data/models/trip.dart';
import '../../features/accountant/approvals/account_approvals_page.dart';
import '../../features/accountant/home/accounts_summary_page.dart';
import '../../features/accountant/invoices/invoice_detail_page.dart';
import '../../features/accountant/invoices/invoice_list_page.dart';
import '../../features/accountant/ledgers/account_gst_page.dart';
import '../../features/accountant/ledgers/account_ledgers_page.dart';
import '../../features/accountant/reminders/send_reminder_page.dart';
import '../../features/accountant/receipts/record_receipt_page.dart';
import '../../features/accountant/shell/accountant_shell.dart';
import '../../features/auth/application/session_provider.dart';
import '../../features/auth/presentation/biometric_setup_page.dart';
import '../../features/auth/presentation/lock_page.dart';
import '../../features/auth/presentation/login_page.dart';
import '../../features/auth/presentation/otp_page.dart';
import '../../features/auth/presentation/permissions_page.dart';
import '../../features/auth/presentation/role_picker_page.dart';
import '../../features/common/notifications/notification_center_page.dart';
import '../../features/common/pdf_viewer/pdf_preview_page.dart';
import '../../features/common/profile/language_settings_page.dart';
import '../../features/common/profile/profile_page.dart';
import '../../features/common/profile/settings_page.dart';
import '../../features/common/search/global_search_page.dart';
import '../../features/supervisor/gate/gate_entry_page.dart';
import '../../features/supervisor/loading/loading_flow_page.dart';
import '../../features/supervisor/lr_print/lr_print_page.dart';
import '../../features/supervisor/scan/scan_packages_page.dart';
import '../../features/supervisor/shell/supervisor_shell.dart';
import '../../features/supervisor/today/loadings_arrivals_page.dart';
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
import '../../features/sales/customers/customer_360_page.dart';
import '../../features/sales/leads/add_lead_page.dart';
import '../../features/sales/leads/lead_detail_page.dart';
import '../../features/sales/leads/lead_list_page.dart';
import '../../features/sales/quotes/quote_page.dart';
import '../../features/sales/quotes/quote_preview_page.dart';
import '../../features/sales/shell/sales_shell.dart';
import '../../features/sales/targets/targets_page.dart';
import '../../features/sales/visits/check_in_page.dart';
import '../../features/sales/visits/visit_plan_page.dart';
import '../../features/splash/splash_page.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../widgets/app_scaffold.dart';
import 'role_guard.dart';
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
        path: RouteNames.notifications,
        builder: (context, state) => const NotificationCenterPage(),
      ),
      GoRoute(
        path: RouteNames.search,
        builder: (context, state) => const GlobalSearchPage(),
      ),
      GoRoute(
        path: RouteNames.settings,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: RouteNames.languageSettings,
        builder: (context, state) => const LanguageSettingsPage(),
      ),
      GoRoute(
        path: RouteNames.pdfViewer,
        builder: (context, state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          return PdfPreviewPage(
            title: extra['title'] as String? ?? '',
            bytes: extra['bytes'] as Uint8List,
          );
        },
      ),
      GoRoute(
        path: RouteNames.forbidden,
        builder: (context, state) => const _ForbiddenPage(),
      ),
      // Sales shell: 5 tabs.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            SalesShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.salesLeads,
                builder: (context, state) => const LeadListPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.salesVisits,
                builder: (context, state) => const VisitPlanPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.salesQuote,
                builder: (context, state) => const QuotePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.salesCustomers,
                builder: (context, state) => const CustomerListPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.salesMore,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.salesLeadNew,
        builder: (context, state) => const AddLeadPage(),
      ),
      GoRoute(
        path: '${RouteNames.salesLeads}/:id',
        builder: (context, state) {
          final String id = state.pathParameters['id'] ?? '';
          return LeadDetailPage(leadId: id);
        },
      ),
      GoRoute(
        path: RouteNames.salesVisitCheckin,
        builder: (context, state) => const CheckInPage(),
      ),
      GoRoute(
        path: RouteNames.salesQuotePreview,
        builder: (context, state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          return QuotePreviewPage(args: extra);
        },
      ),
      GoRoute(
        path: '${RouteNames.salesCustomers}/:id',
        builder: (context, state) {
          final String id = state.pathParameters['id'] ?? '';
          return Customer360Page(customerId: id);
        },
      ),
      GoRoute(
        path: RouteNames.salesTargets,
        builder: (context, state) => const TargetsPage(),
      ),
      // Supervisor shell: 5 tabs.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            SupervisorShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.superToday,
                builder: (context, state) =>
                    const LoadingsArrivalsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.superGate,
                builder: (context, state) => const GateEntryPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.superScan,
                builder: (context, state) => const ScanPackagesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.superManifest,
                builder: (context, state) => const ManifestListPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.superMore,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/supervisor/loading/:taskId',
        builder: (context, state) {
          final String taskId = state.pathParameters['taskId'] ?? '';
          return LoadingFlowPage(taskId: taskId);
        },
      ),
      GoRoute(
        path: RouteNames.superLr,
        builder: (context, state) => const LrPrintPage(),
      ),
      // Accountant shell: 5 tabs.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AccountantShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/accountant/home',
                builder: (context, state) =>
                    const AccountsSummaryPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.acctLedgers,
                builder: (context, state) =>
                    const AccountLedgersPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.acctInvoices,
                builder: (context, state) => const InvoiceListPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.acctApprovals,
                builder: (context, state) =>
                    const AccountApprovalsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.acctMore,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/accountant/ledger/:kind',
        builder: (context, state) {
          final String kind = state.pathParameters['kind'] ?? 'customer';
          return LedgerPage(kind: kind);
        },
      ),
      GoRoute(
        path: '/accountant/ageing',
        builder: (context, state) => const AgeingPage(),
      ),
      GoRoute(
        path: '/accountant/pnl',
        builder: (context, state) => const PnlPage(),
      ),
      GoRoute(
        path: '/accountant/daybook',
        builder: (context, state) => const DaybookPage(),
      ),
      GoRoute(
        path: '/accountant/gst',
        builder: (context, state) => const AccountGstPage(),
      ),
      GoRoute(
        path: '${RouteNames.acctInvoices}/:id',
        builder: (context, state) {
          final String id = state.pathParameters['id'] ?? '';
          return InvoiceDetailPage(invoiceId: id);
        },
      ),
      GoRoute(
        path: RouteNames.acctReminders,
        builder: (context, state) => const SendReminderPage(),
      ),
      GoRoute(
        path: RouteNames.acctReceipts,
        builder: (context, state) => const RecordReceiptPage(),
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

