// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exception.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExceptionItem _$ExceptionItemFromJson(Map<String, dynamic> json) =>
    _ExceptionItem(
      id: json['id'] as String,
      type: $enumDecode(_$ExceptionTypeEnumMap, json['type']),
      tripId: json['tripId'] as String,
      vehicleReg: json['vehicleReg'] as String,
      driverName: json['driverName'] as String,
      driverPhone: json['driverPhone'] as String,
      severity:
          $enumDecodeNullable(_$ExceptionSeverityEnumMap, json['severity']) ??
          ExceptionSeverity.medium,
      message: json['message'] as String,
      at: DateTime.parse(json['at'] as String),
      resolved: json['resolved'] as bool? ?? false,
      resolutionNote: json['resolutionNote'] as String?,
    );

Map<String, dynamic> _$ExceptionItemToJson(_ExceptionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ExceptionTypeEnumMap[instance.type]!,
      'tripId': instance.tripId,
      'vehicleReg': instance.vehicleReg,
      'driverName': instance.driverName,
      'driverPhone': instance.driverPhone,
      'severity': _$ExceptionSeverityEnumMap[instance.severity]!,
      'message': instance.message,
      'at': instance.at.toIso8601String(),
      'resolved': instance.resolved,
      'resolutionNote': instance.resolutionNote,
    };

const _$ExceptionTypeEnumMap = {
  ExceptionType.delay: 'delay',
  ExceptionType.halt: 'halt',
  ExceptionType.deviation: 'deviation',
  ExceptionType.overspeed: 'overspeed',
  ExceptionType.deviceOff: 'deviceOff',
  ExceptionType.ewayExpiring: 'ewayExpiring',
  ExceptionType.podPending: 'podPending',
  ExceptionType.sos: 'sos',
};

const _$ExceptionSeverityEnumMap = {
  ExceptionSeverity.low: 'low',
  ExceptionSeverity.medium: 'medium',
  ExceptionSeverity.high: 'high',
  ExceptionSeverity.critical: 'critical',
};
