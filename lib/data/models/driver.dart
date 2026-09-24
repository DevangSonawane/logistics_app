import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver.freezed.dart';
part 'driver.g.dart';

/// Driver master record (subset needed by driver + ops flows).
@freezed
abstract class Driver with _$Driver {
  const factory Driver({
    required String id,
    required String name,
    required String phone,
    required String licenseNo,
    required DateTime licenseExpiry,
    @Default(0) double rating,
    @Default(0) int onTimePct,
    @Default([]) List<String> languages,
    String? vehicleReg,
  }) = _Driver;

  factory Driver.fromJson(Map<String, dynamic> json) =>
      _$DriverFromJson(json);
}

/// One trip allowance line on the earnings page.
@freezed
abstract class AllowanceEntry with _$AllowanceEntry {
  const factory AllowanceEntry({
    required String tripNo,
    required String lane,
    required int amount,
    required DateTime date,
  }) = _AllowanceEntry;

  factory AllowanceEntry.fromJson(Map<String, dynamic> json) =>
      _$AllowanceEntryFromJson(json);
}

/// Salary slip with a locally generated PDF preview.
@freezed
abstract class SalarySlip with _$SalarySlip {
  const factory SalarySlip({
    required String id,
    required String month,
    required int amount,
  }) = _SalarySlip;

  factory SalarySlip.fromJson(Map<String, dynamic> json) =>
      _$SalarySlipFromJson(json);
}

/// Earnings tab aggregate. Amounts are integer rupees.
@freezed
abstract class EarningsSummary with _$EarningsSummary {
  const factory EarningsSummary({
    required int monthTotal,
    @Default([]) List<AllowanceEntry> allowances,
    @Default(0) int incentives,
    @Default(0) int advanceTaken,
    @Default(0) int expensesTotal,
    @Default(0) int settlementBalance,
    @Default(0) int tripsDone,
    @Default(0) int onTimePct,
    @Default([]) List<SalarySlip> slips,
  }) = _EarningsSummary;

  factory EarningsSummary.fromJson(Map<String, dynamic> json) =>
      _$EarningsSummaryFromJson(json);
}
