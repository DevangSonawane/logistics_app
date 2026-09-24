// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LedgerEntry _$LedgerEntryFromJson(Map<String, dynamic> json) => _LedgerEntry(
      id: json['id'] as String,
      accountName: json['accountName'] as String,
      date: DateTime.parse(json['date'] as String),
      particulars: json['particulars'] as String,
      debit: (json['debit'] as num?)?.toInt() ?? 0,
      credit: (json['credit'] as num?)?.toInt() ?? 0,
      balance: (json['balance'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$LedgerEntryToJson(_LedgerEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accountName': instance.accountName,
      'date': instance.date.toIso8601String(),
      'particulars': instance.particulars,
      'debit': instance.debit,
      'credit': instance.credit,
      'balance': instance.balance,
    };

_AgeingBucket _$AgeingBucketFromJson(Map<String, dynamic> json) =>
    _AgeingBucket(
      label: json['label'] as String,
      amount: (json['amount'] as num).toInt(),
    );

Map<String, dynamic> _$AgeingBucketToJson(_AgeingBucket instance) =>
    <String, dynamic>{
      'label': instance.label,
      'amount': instance.amount,
    };

_BankAccount _$BankAccountFromJson(Map<String, dynamic> json) => _BankAccount(
      name: json['name'] as String,
      balance: (json['balance'] as num).toInt(),
    );

Map<String, dynamic> _$BankAccountToJson(_BankAccount instance) =>
    <String, dynamic>{
      'name': instance.name,
      'balance': instance.balance,
    };

_GstSummary _$GstSummaryFromJson(Map<String, dynamic> json) => _GstSummary(
      month: json['month'] as String,
      cgst: (json['cgst'] as num).toInt(),
      sgst: (json['sgst'] as num).toInt(),
      igst: (json['igst'] as num).toInt(),
    );

Map<String, dynamic> _$GstSummaryToJson(_GstSummary instance) =>
    <String, dynamic>{
      'month': instance.month,
      'cgst': instance.cgst,
      'sgst': instance.sgst,
      'igst': instance.igst,
    };

_TripPnl _$TripPnlFromJson(Map<String, dynamic> json) => _TripPnl(
      tripNo: json['tripNo'] as String,
      lane: json['lane'] as String,
      revenue: (json['revenue'] as num).toInt(),
      cost: (json['cost'] as num).toInt(),
      margin: (json['margin'] as num).toInt(),
    );

Map<String, dynamic> _$TripPnlToJson(_TripPnl instance) => <String, dynamic>{
      'tripNo': instance.tripNo,
      'lane': instance.lane,
      'revenue': instance.revenue,
      'cost': instance.cost,
      'margin': instance.margin,
    };

_PnlLine _$PnlLineFromJson(Map<String, dynamic> json) => _PnlLine(
      label: json['label'] as String,
      amount: (json['amount'] as num).toInt(),
    );

Map<String, dynamic> _$PnlLineToJson(_PnlLine instance) => <String, dynamic>{
      'label': instance.label,
      'amount': instance.amount,
    };
