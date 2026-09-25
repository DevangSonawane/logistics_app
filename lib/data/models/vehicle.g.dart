// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VehicleDoc _$VehicleDocFromJson(Map<String, dynamic> json) => _VehicleDoc(
  type: $enumDecode(_$VehicleDocTypeEnumMap, json['type']),
  number: json['number'] as String,
  expiry: DateTime.parse(json['expiry'] as String),
  photoPath: json['photoPath'] as String?,
);

Map<String, dynamic> _$VehicleDocToJson(_VehicleDoc instance) =>
    <String, dynamic>{
      'type': _$VehicleDocTypeEnumMap[instance.type]!,
      'number': instance.number,
      'expiry': instance.expiry.toIso8601String(),
      'photoPath': instance.photoPath,
    };

const _$VehicleDocTypeEnumMap = {
  VehicleDocType.licence: 'licence',
  VehicleDocType.rc: 'rc',
  VehicleDocType.insurance: 'insurance',
  VehicleDocType.fitness: 'fitness',
  VehicleDocType.permit: 'permit',
  VehicleDocType.puc: 'puc',
};

_Vehicle _$VehicleFromJson(Map<String, dynamic> json) => _Vehicle(
  id: json['id'] as String,
  regNo: json['regNo'] as String,
  type: json['type'] as String,
  docs:
      (json['docs'] as List<dynamic>?)
          ?.map((e) => VehicleDoc.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  capacityTons: (json['capacityTons'] as num?)?.toDouble() ?? 0,
  ownership:
      $enumDecodeNullable(_$VehicleOwnershipEnumMap, json['ownership']) ??
      VehicleOwnership.own,
  status:
      $enumDecodeNullable(_$VehicleStatusEnumMap, json['status']) ??
      VehicleStatus.idle,
  lastLat: (json['lastLat'] as num?)?.toDouble(),
  lastLng: (json['lastLng'] as num?)?.toDouble(),
  lastUpdate: json['lastUpdate'] == null
      ? null
      : DateTime.parse(json['lastUpdate'] as String),
  mileageKm: (json['mileageKm'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$VehicleToJson(_Vehicle instance) => <String, dynamic>{
  'id': instance.id,
  'regNo': instance.regNo,
  'type': instance.type,
  'docs': instance.docs,
  'capacityTons': instance.capacityTons,
  'ownership': _$VehicleOwnershipEnumMap[instance.ownership]!,
  'status': _$VehicleStatusEnumMap[instance.status]!,
  'lastLat': instance.lastLat,
  'lastLng': instance.lastLng,
  'lastUpdate': instance.lastUpdate?.toIso8601String(),
  'mileageKm': instance.mileageKm,
};

const _$VehicleOwnershipEnumMap = {
  VehicleOwnership.own: 'own',
  VehicleOwnership.market: 'market',
};

const _$VehicleStatusEnumMap = {
  VehicleStatus.idle: 'idle',
  VehicleStatus.onTrip: 'onTrip',
  VehicleStatus.maintenance: 'maintenance',
};
