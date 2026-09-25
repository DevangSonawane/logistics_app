// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lane.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Lane _$LaneFromJson(Map<String, dynamic> json) => _Lane(
  id: json['id'] as String,
  from: json['from'] as String,
  to: json['to'] as String,
  distanceKm: (json['distanceKm'] as num).toDouble(),
  transitHrs: (json['transitHrs'] as num).toInt(),
);

Map<String, dynamic> _$LaneToJson(_Lane instance) => <String, dynamic>{
  'id': instance.id,
  'from': instance.from,
  'to': instance.to,
  'distanceKm': instance.distanceKm,
  'transitHrs': instance.transitHrs,
};
