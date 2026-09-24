// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OfflineAction _$OfflineActionFromJson(Map<String, dynamic> json) =>
    _OfflineAction(
      id: json['id'] as String,
      type: json['type'] as String,
      tripId: json['tripId'] as String?,
      payload: json['payload'] as Map<String, dynamic>,
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
      status:
          $enumDecodeNullable(_$OfflineActionStatusEnumMap, json['status']) ??
              OfflineActionStatus.pending,
      failureReason: json['failureReason'] as String?,
    );

Map<String, dynamic> _$OfflineActionToJson(_OfflineAction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'tripId': instance.tripId,
      'payload': instance.payload,
      'attachments': instance.attachments,
      'createdAt': instance.createdAt.toIso8601String(),
      'retryCount': instance.retryCount,
      'status': _$OfflineActionStatusEnumMap[instance.status]!,
      'failureReason': instance.failureReason,
    };

const _$OfflineActionStatusEnumMap = {
  OfflineActionStatus.pending: 'pending',
  OfflineActionStatus.uploading: 'uploading',
  OfflineActionStatus.failed: 'failed',
  OfflineActionStatus.done: 'done',
  OfflineActionStatus.rejected: 'rejected',
};
