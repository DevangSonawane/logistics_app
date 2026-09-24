// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApprovalItem _$ApprovalItemFromJson(Map<String, dynamic> json) =>
    _ApprovalItem(
      id: json['id'] as String,
      type: $enumDecode(_$ApprovalTypeEnumMap, json['type']),
      requester: json['requester'] as String,
      amount: (json['amount'] as num).toInt(),
      reason: json['reason'] as String,
      riskFlag: json['riskFlag'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      status: $enumDecodeNullable(_$ApprovalStatusEnumMap, json['status']) ??
          ApprovalStatus.pending,
      comment: json['comment'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ApprovalItemToJson(_ApprovalItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ApprovalTypeEnumMap[instance.type]!,
      'requester': instance.requester,
      'amount': instance.amount,
      'reason': instance.reason,
      'riskFlag': instance.riskFlag,
      'attachments': instance.attachments,
      'status': _$ApprovalStatusEnumMap[instance.status]!,
      'comment': instance.comment,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$ApprovalTypeEnumMap = {
  ApprovalType.advance: 'advance',
  ApprovalType.expense: 'expense',
  ApprovalType.rate: 'rate',
  ApprovalType.credit: 'credit',
  ApprovalType.vendor: 'vendor',
  ApprovalType.purchase: 'purchase',
};

const _$ApprovalStatusEnumMap = {
  ApprovalStatus.pending: 'pending',
  ApprovalStatus.approved: 'approved',
  ApprovalStatus.rejected: 'rejected',
  ApprovalStatus.info: 'info',
};
