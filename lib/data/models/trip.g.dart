// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripStep _$TripStepFromJson(Map<String, dynamic> json) => _TripStep(
  type: $enumDecode(_$TripStepTypeEnumMap, json['type']),
  at: DateTime.parse(json['at'] as String),
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
  photoPath: json['photoPath'] as String?,
  note: json['note'] as String?,
);

Map<String, dynamic> _$TripStepToJson(_TripStep instance) => <String, dynamic>{
  'type': _$TripStepTypeEnumMap[instance.type]!,
  'at': instance.at.toIso8601String(),
  'lat': instance.lat,
  'lng': instance.lng,
  'photoPath': instance.photoPath,
  'note': instance.note,
};

const _$TripStepTypeEnumMap = {
  TripStepType.reachedPickup: 'reachedPickup',
  TripStepType.loadingDone: 'loadingDone',
  TripStepType.startTrip: 'startTrip',
  TripStepType.reachedDrop: 'reachedDrop',
  TripStepType.unloaded: 'unloaded',
};

_Trip _$TripFromJson(Map<String, dynamic> json) => _Trip(
  id: json['id'] as String,
  no: json['no'] as String,
  orderId: json['orderId'] as String,
  customer: json['customer'] as String,
  pickupAddress: json['pickupAddress'] as String,
  pickupContact: json['pickupContact'] as String,
  pickupPhone: json['pickupPhone'] as String,
  pickupLat: (json['pickupLat'] as num).toDouble(),
  pickupLng: (json['pickupLng'] as num).toDouble(),
  dropAddress: json['dropAddress'] as String,
  dropContact: json['dropContact'] as String,
  dropPhone: json['dropPhone'] as String,
  dropLat: (json['dropLat'] as num).toDouble(),
  dropLng: (json['dropLng'] as num).toDouble(),
  distanceKm: (json['distanceKm'] as num).toDouble(),
  freightAllowance: (json['freightAllowance'] as num).toInt(),
  pickupBy: DateTime.parse(json['pickupBy'] as String),
  vehicleReg: json['vehicleReg'] as String,
  driverId: json['driverId'] as String,
  status: $enumDecode(_$TripStatusEnumMap, json['status']),
  plannedEta: json['plannedEta'] == null
      ? null
      : DateTime.parse(json['plannedEta'] as String),
  liveEta: json['liveEta'] == null
      ? null
      : DateTime.parse(json['liveEta'] as String),
  steps:
      (json['steps'] as List<dynamic>?)
          ?.map((e) => TripStep.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  lrNo: json['lrNo'] as String?,
  ewayBillNo: json['ewayBillNo'] as String?,
  podStatus:
      $enumDecodeNullable(_$PodStatusEnumMap, json['podStatus']) ??
      PodStatus.pending,
  advanceGiven: (json['advanceGiven'] as num?)?.toInt() ?? 0,
  rejectReason: json['rejectReason'] as String?,
);

Map<String, dynamic> _$TripToJson(_Trip instance) => <String, dynamic>{
  'id': instance.id,
  'no': instance.no,
  'orderId': instance.orderId,
  'customer': instance.customer,
  'pickupAddress': instance.pickupAddress,
  'pickupContact': instance.pickupContact,
  'pickupPhone': instance.pickupPhone,
  'pickupLat': instance.pickupLat,
  'pickupLng': instance.pickupLng,
  'dropAddress': instance.dropAddress,
  'dropContact': instance.dropContact,
  'dropPhone': instance.dropPhone,
  'dropLat': instance.dropLat,
  'dropLng': instance.dropLng,
  'distanceKm': instance.distanceKm,
  'freightAllowance': instance.freightAllowance,
  'pickupBy': instance.pickupBy.toIso8601String(),
  'vehicleReg': instance.vehicleReg,
  'driverId': instance.driverId,
  'status': _$TripStatusEnumMap[instance.status]!,
  'plannedEta': instance.plannedEta?.toIso8601String(),
  'liveEta': instance.liveEta?.toIso8601String(),
  'steps': instance.steps,
  'lrNo': instance.lrNo,
  'ewayBillNo': instance.ewayBillNo,
  'podStatus': _$PodStatusEnumMap[instance.podStatus]!,
  'advanceGiven': instance.advanceGiven,
  'rejectReason': instance.rejectReason,
};

const _$TripStatusEnumMap = {
  TripStatus.offered: 'offered',
  TripStatus.assigned: 'assigned',
  TripStatus.reachedPickup: 'reachedPickup',
  TripStatus.loadingDone: 'loadingDone',
  TripStatus.started: 'started',
  TripStatus.reachedDrop: 'reachedDrop',
  TripStatus.unloaded: 'unloaded',
  TripStatus.podSubmitted: 'podSubmitted',
  TripStatus.delivered: 'delivered',
  TripStatus.closed: 'closed',
  TripStatus.cancelled: 'cancelled',
};

const _$PodStatusEnumMap = {
  PodStatus.pending: 'pending',
  PodStatus.submitted: 'submitted',
  PodStatus.verified: 'verified',
};
