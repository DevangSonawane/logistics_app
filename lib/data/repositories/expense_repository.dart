import '../models/expense.dart';

/// Expense repository: per-trip list + create (queued for sync).
abstract class ExpenseRepository {
  Future<List<Expense>> list(String tripId);

  /// Flags above-norm amounts ([Expense.normFlag]) for Ops review.
  Future<Expense> add(Expense expense, {required double distanceKm});
}

/// Demo route norms shared by the mock store and the add-expense warning.
/// Phase 4 replaces these with the contract rate-card service.
int dieselNormFor(double distanceKm) => (distanceKm * 9.5).round();
const int tollNormAmount = 1500;
const int foodNormAmount = 500;

bool isAboveNorm(ExpenseType type, int amount, double distanceKm) {
  return switch (type) {
    ExpenseType.diesel => amount > dieselNormFor(distanceKm),
    ExpenseType.toll => amount > tollNormAmount,
    ExpenseType.food => amount > foodNormAmount,
    _ => false,
  };
}
