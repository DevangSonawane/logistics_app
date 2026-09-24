// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PodSubmission _$PodSubmissionFromJson(Map<String, dynamic> json) =>
    _PodSubmission(
      tripId: json['tripId'] as String,
      lrPhotoPath: json['lrPhotoPath'] as String,
      method: $enumDecode(_$PodMethodEnumMap, json['method']),
      consigneeName: json['consigneeName'] as String?,
      hasDamageOrShortage: json['hasDamageOrShortage'] as bool? ?? false,
      damageRemark: json['damageRemark'] as String?,
      damageQty: (json['damageQty'] as num?)?.toInt(),
      damagePhotos: (json['damagePhotos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      submittedAt: DateTime.parse(json['submittedAt'] as String),
    );

Map<String, dynamic> _$PodSubmissionToJson(_PodSubmission instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'lrPhotoPath': instance.lrPhotoPath,
      'method': _$PodMethodEnumMap[instance.method]!,
      'consigneeName': instance.consigneeName,
      'hasDamageOrShortage': instance.hasDamageOrShortage,
      'damageRemark': instance.damageRemark,
      'damageQty': instance.damageQty,
      'damagePhotos': instance.damagePhotos,
      'submittedAt': instance.submittedAt.toIso8601String(),
    };

const _$PodMethodEnumMap = {
  PodMethod.otp: 'otp',
  PodMethod.signature: 'signature',
};
