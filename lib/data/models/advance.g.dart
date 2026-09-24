// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Advance _$AdvanceFromJson(Map<String, dynamic> json) => _Advance(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      amount: (json['amount'] as num).toInt(),
      purpose: $enumDecode(_$AdvancePurposeEnumMap, json['purpose']),
      note: json['note'] as String?,
      status: $enumDecodeNullable(_$AdvanceStatusEnumMap, json['status']) ??
          AdvanceStatus.requested,
      requestedAt: DateTime.parse(json['requestedAt'] as String),
    );

Map<String, dynamic> _$AdvanceToJson(_Advance instance) => <String, dynamic>{
      'id': instance.id,
      'tripId': instance.tripId,
      'amount': instance.amount,
      'purpose': _$AdvancePurposeEnumMap[instance.purpose]!,
      'note': instance.note,
      'status': _$AdvanceStatusEnumMap[instance.status]!,
      'requestedAt': instance.requestedAt.toIso8601String(),
    };

const _$AdvancePurposeEnumMap = {
  AdvancePurpose.fuel: 'fuel',
  AdvancePurpose.toll: 'toll',
  AdvancePurpose.repair: 'repair',
  AdvancePurpose.food: 'food',
  AdvancePurpose.other: 'other',
};

const _$AdvanceStatusEnumMap = {
  AdvanceStatus.requested: 'requested',
  AdvanceStatus.approved: 'approved',
  AdvanceStatus.paid: 'paid',
  AdvanceStatus.rejected: 'rejected',
};
