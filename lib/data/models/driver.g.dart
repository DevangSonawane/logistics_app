// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Driver _$DriverFromJson(Map<String, dynamic> json) => _Driver(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      licenseNo: json['licenseNo'] as String,
      licenseExpiry: DateTime.parse(json['licenseExpiry'] as String),
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      onTimePct: (json['onTimePct'] as num?)?.toInt() ?? 0,
      languages: (json['languages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      vehicleReg: json['vehicleReg'] as String?,
    );

Map<String, dynamic> _$DriverToJson(_Driver instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'licenseNo': instance.licenseNo,
      'licenseExpiry': instance.licenseExpiry.toIso8601String(),
      'rating': instance.rating,
      'onTimePct': instance.onTimePct,
      'languages': instance.languages,
      'vehicleReg': instance.vehicleReg,
    };

_AllowanceEntry _$AllowanceEntryFromJson(Map<String, dynamic> json) =>
    _AllowanceEntry(
      tripNo: json['tripNo'] as String,
      lane: json['lane'] as String,
      amount: (json['amount'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$AllowanceEntryToJson(_AllowanceEntry instance) =>
    <String, dynamic>{
      'tripNo': instance.tripNo,
      'lane': instance.lane,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
    };

_SalarySlip _$SalarySlipFromJson(Map<String, dynamic> json) => _SalarySlip(
      id: json['id'] as String,
      month: json['month'] as String,
      amount: (json['amount'] as num).toInt(),
    );

Map<String, dynamic> _$SalarySlipToJson(_SalarySlip instance) =>
    <String, dynamic>{
      'id': instance.id,
      'month': instance.month,
      'amount': instance.amount,
    };

_EarningsSummary _$EarningsSummaryFromJson(Map<String, dynamic> json) =>
    _EarningsSummary(
      monthTotal: (json['monthTotal'] as num).toInt(),
      allowances: (json['allowances'] as List<dynamic>?)
              ?.map((e) => AllowanceEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      incentives: (json['incentives'] as num?)?.toInt() ?? 0,
      advanceTaken: (json['advanceTaken'] as num?)?.toInt() ?? 0,
      expensesTotal: (json['expensesTotal'] as num?)?.toInt() ?? 0,
      settlementBalance: (json['settlementBalance'] as num?)?.toInt() ?? 0,
      tripsDone: (json['tripsDone'] as num?)?.toInt() ?? 0,
      onTimePct: (json['onTimePct'] as num?)?.toInt() ?? 0,
      slips: (json['slips'] as List<dynamic>?)
              ?.map((e) => SalarySlip.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$EarningsSummaryToJson(_EarningsSummary instance) =>
    <String, dynamic>{
      'monthTotal': instance.monthTotal,
      'allowances': instance.allowances,
      'incentives': instance.incentives,
      'advanceTaken': instance.advanceTaken,
      'expensesTotal': instance.expensesTotal,
      'settlementBalance': instance.settlementBalance,
      'tripsDone': instance.tripsDone,
      'onTimePct': instance.onTimePct,
      'slips': instance.slips,
    };
