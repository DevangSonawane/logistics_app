import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'advance_repository.dart';
import 'approval_repository.dart';
import 'auth_repository.dart';
import 'customer_repository.dart';
import 'dashboard_repository.dart';
import 'driver_repository.dart';
import 'exception_repository.dart';
import 'expense_repository.dart';
import 'finance_repository.dart';
import 'hire_repository.dart';
import 'hub_repository.dart';
import 'invoice_repository.dart';
import 'lead_repository.dart';
import 'mock_advance_repository.dart';
import 'mock_approval_repository.dart';
import 'mock_auth_repository.dart';
import 'mock_customer_repository.dart';
import 'mock_dashboard_repository.dart';
import 'mock_driver_repository.dart';
import 'mock_exception_repository.dart';
import 'mock_expense_repository.dart';
import 'mock_finance_repository.dart';
import 'mock_hire_repository.dart';
import 'mock_hub_repository.dart';
import 'mock_invoice_repository.dart';
import 'mock_lead_repository.dart';
import 'mock_notification_repository.dart';
import 'mock_order_repository.dart';
import 'mock_trip_repository.dart';
import 'mock_vehicle_repository.dart';
import 'notification_repository.dart';
import 'order_repository.dart';
import 'trip_repository.dart';
import 'vehicle_repository.dart';

part 'repository_providers.g.dart';

/// Single place to swap mock <-> real implementations.
/// Tests override these providers; UI code never instantiates repositories.
@riverpod
AuthRepository authRepository(Ref ref) => MockAuthRepository();

/// Driver-scope stores with in-memory demo state (Phase 3).
/// Ops/owner/finance repositories land in Phases 4-7.
@Riverpod(keepAlive: true)
TripRepository tripRepository(Ref ref) => MockTripRepository();

/// Mock stores hold demo state per container; keep alive for the session.
@Riverpod(keepAlive: true)
ExpenseRepository expenseRepository(Ref ref) => MockExpenseRepository();

@Riverpod(keepAlive: true)
AdvanceRepository advanceRepository(Ref ref) => MockAdvanceRepository();

@Riverpod(keepAlive: true)
DriverRepository driverRepository(Ref ref) => MockDriverRepository();

@Riverpod(keepAlive: true)
CustomerRepository customerRepository(Ref ref) => MockCustomerRepository();

@Riverpod(keepAlive: true)
OrderRepository orderRepository(Ref ref) => MockOrderRepository();

@Riverpod(keepAlive: true)
VehicleRepository vehicleRepository(Ref ref) => MockVehicleRepository();

@Riverpod(keepAlive: true)
DashboardRepository dashboardRepository(Ref ref) =>
    MockDashboardRepository();

@Riverpod(keepAlive: true)
ApprovalRepository approvalRepository(Ref ref) => MockApprovalRepository();

@Riverpod(keepAlive: true)
FinanceRepository financeRepository(Ref ref) => MockFinanceRepository();

@Riverpod(keepAlive: true)
ExceptionRepository exceptionRepository(Ref ref) =>
    MockExceptionRepository();

@Riverpod(keepAlive: true)
NotificationRepository notificationRepository(Ref ref) =>
    MockNotificationRepository();

/// Hire repo shares the approval store so above-limit advances raise
/// inbox items (wired here to keep UI code free of repository plumbing).
@Riverpod(keepAlive: true)
HireRepository hireRepository(Ref ref) => MockHireRepository(
      approvals: ref.watch(approvalRepositoryProvider),
    );

@Riverpod(keepAlive: true)
LeadRepository leadRepository(Ref ref) => MockLeadRepository();

@Riverpod(keepAlive: true)
HubRepository hubRepository(Ref ref) => MockHubRepository();

@Riverpod(keepAlive: true)
InvoiceRepository invoiceRepository(Ref ref) => MockInvoiceRepository();
