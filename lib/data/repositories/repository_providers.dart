import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'advance_repository.dart';
import 'auth_repository.dart';
import 'driver_repository.dart';
import 'expense_repository.dart';
import 'mock_advance_repository.dart';
import 'mock_auth_repository.dart';
import 'mock_driver_repository.dart';
import 'mock_expense_repository.dart';
import 'mock_trip_repository.dart';
import 'trip_repository.dart';

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

// TODO(Phase 3): tripRepository, orderRepository (ops), vehicleRepository,
// driverRepository, expenseRepository, advanceRepository (+ mocks).
// TODO(Phase 4): dashboardRepository, approvalRepository, financeRepository,
// hubRepository, notificationRepository (+ mocks).
// TODO(Phase 7): leadRepository, quoteRepository, customerRepository (+ mocks).
