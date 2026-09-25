// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Expense _$ExpenseFromJson(Map<String, dynamic> json) => _Expense(
  id: json['id'] as String,
  tripId: json['tripId'] as String,
  type: $enumDecode(_$ExpenseTypeEnumMap, json['type']),
  amount: (json['amount'] as num).toInt(),
  litres: (json['litres'] as num?)?.toDouble(),
  rate: (json['rate'] as num?)?.toDouble(),
  photoPath: json['photoPath'] as String?,
  note: json['note'] as String?,
  voiceNotePath: json['voiceNotePath'] as String?,
  status:
      $enumDecodeNullable(_$ExpenseStatusEnumMap, json['status']) ??
      ExpenseStatus.queued,
  normFlag: json['normFlag'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ExpenseToJson(_Expense instance) => <String, dynamic>{
  'id': instance.id,
  'tripId': instance.tripId,
  'type': _$ExpenseTypeEnumMap[instance.type]!,
  'amount': instance.amount,
  'litres': instance.litres,
  'rate': instance.rate,
  'photoPath': instance.photoPath,
  'note': instance.note,
  'voiceNotePath': instance.voiceNotePath,
  'status': _$ExpenseStatusEnumMap[instance.status]!,
  'normFlag': instance.normFlag,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$ExpenseTypeEnumMap = {
  ExpenseType.diesel: 'diesel',
  ExpenseType.toll: 'toll',
  ExpenseType.repair: 'repair',
  ExpenseType.loading: 'loading',
  ExpenseType.police: 'police',
  ExpenseType.food: 'food',
  ExpenseType.other: 'other',
};

const _$ExpenseStatusEnumMap = {
  ExpenseStatus.queued: 'queued',
  ExpenseStatus.submitted: 'submitted',
  ExpenseStatus.approved: 'approved',
  ExpenseStatus.rejected: 'rejected',
};
