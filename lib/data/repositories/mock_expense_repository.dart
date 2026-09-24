import 'package:uuid/uuid.dart';

import '../mock/mock_delay.dart';
import '../mock/mock_driver_data.dart';
import '../models/expense.dart';
import 'expense_repository.dart';
class MockExpenseRepository implements ExpenseRepository {
  MockExpenseRepository() {
    _byTrip['trip-ramesh-1'] = MockDriverData.rameshExpenses();
  }

  final Map<String, List<Expense>> _byTrip = {};
  final Uuid _uuid = const Uuid();

  @override
  Future<List<Expense>> list(String tripId) async {
    await mockDelay();
    throwIfChaos();
    return List.unmodifiable(_byTrip[tripId] ?? const []);
  }

  @override
  Future<Expense> add(Expense expense, {required double distanceKm}) async {
    await mockDelay();
    throwIfChaos();
    final Expense saved = expense.copyWith(
      id: _uuid.v4(),
      normFlag: isAboveNorm(expense.type, expense.amount, distanceKm),
      status: ExpenseStatus.submitted,
      createdAt: DateTime.now(),
    );
    _byTrip.putIfAbsent(expense.tripId, () => []).add(saved);
    return saved;
  }
}
