import 'package:freezed_annotation/freezed_annotation.dart';

part 'finance.freezed.dart';
part 'finance.g.dart';

/// Ledger line with running balance. Money in integer rupees.
@freezed
abstract class LedgerEntry with _$LedgerEntry {
  const factory LedgerEntry({
    required String id,
    required String accountName,
    required DateTime date,
    required String particulars,
    @Default(0) int debit,
    @Default(0) int credit,
    @Default(0) int balance,
  }) = _LedgerEntry;

  factory LedgerEntry.fromJson(Map<String, dynamic> json) =>
      _$LedgerEntryFromJson(json);
}

@freezed
abstract class AgeingBucket with _$AgeingBucket {
  const factory AgeingBucket({
    required String label,
    required int amount,
  }) = _AgeingBucket;

  factory AgeingBucket.fromJson(Map<String, dynamic> json) =>
      _$AgeingBucketFromJson(json);
}

@freezed
abstract class BankAccount with _$BankAccount {
  const factory BankAccount({
    required String name,
    required int balance,
  }) = _BankAccount;

  factory BankAccount.fromJson(Map<String, dynamic> json) =>
      _$BankAccountFromJson(json);
}

@freezed
abstract class GstSummary with _$GstSummary {
  const factory GstSummary({
    required String month,
    required int cgst,
    required int sgst,
    required int igst,
  }) = _GstSummary;

  factory GstSummary.fromJson(Map<String, dynamic> json) =>
      _$GstSummaryFromJson(json);
}

/// Per-trip profit line for the owner Trip P&L view.
@freezed
abstract class TripPnl with _$TripPnl {
  const factory TripPnl({
    required String tripNo,
    required String lane,
    required int revenue,
    required int cost,
    required int margin,
  }) = _TripPnl;

  factory TripPnl.fromJson(Map<String, dynamic> json) =>
      _$TripPnlFromJson(json);
}

/// P&L section line (grouped by branch/vehicle/customer/lane upstream).
@freezed
abstract class PnlLine with _$PnlLine {
  const factory PnlLine({
    required String label,
    required int amount,
  }) = _PnlLine;

  factory PnlLine.fromJson(Map<String, dynamic> json) =>
      _$PnlLineFromJson(json);
}
