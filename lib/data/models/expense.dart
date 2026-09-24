import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.freezed.dart';
part 'expense.g.dart';

enum ExpenseType { diesel, toll, repair, loading, police, food, other }

enum ExpenseStatus { queued, submitted, approved, rejected }

/// Trip expense. Bill photo required above Rs.100. Diesel captures
/// litres + rate (auto-calculates amount). Amounts are integer rupees.
@freezed
abstract class Expense with _$Expense {
  const factory Expense({
    required String id,
    required String tripId,
    required ExpenseType type,
    required int amount,
    double? litres,
    double? rate,
    String? photoPath,
    String? note,
    String? voiceNotePath,
    @Default(ExpenseStatus.queued) ExpenseStatus status,
    @Default(false) bool normFlag,
    required DateTime createdAt,
  }) = _Expense;

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);
}
