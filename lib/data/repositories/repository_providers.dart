import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_repository.dart';
import 'mock_auth_repository.dart';

part 'repository_providers.g.dart';

/// Single place to swap mock <-> real implementations.
/// Tests override these providers; UI code never instantiates repositories.
@riverpod
AuthRepository authRepository(Ref ref) => MockAuthRepository();

// TODO(Phase 3): tripRepository, orderRepository (ops), vehicleRepository,
// driverRepository, expenseRepository, advanceRepository (+ mocks).
// TODO(Phase 4): dashboardRepository, approvalRepository, financeRepository,
// hubRepository, notificationRepository (+ mocks).
// TODO(Phase 7): leadRepository, quoteRepository, customerRepository (+ mocks).
