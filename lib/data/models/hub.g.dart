// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hub.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HubTask _$HubTaskFromJson(Map<String, dynamic> json) => _HubTask(
  id: json['id'] as String,
  type: $enumDecode(_$HubTaskTypeEnumMap, json['type']),
  vehicleNo: json['vehicleNo'] as String,
  customer: json['customer'] as String,
  eta: json['eta'] == null ? null : DateTime.parse(json['eta'] as String),
  status:
      $enumDecodeNullable(_$HubTaskStatusEnumMap, json['status']) ??
      HubTaskStatus.pending,
  gateInAt: json['gateInAt'] == null
      ? null
      : DateTime.parse(json['gateInAt'] as String),
  gateOutAt: json['gateOutAt'] == null
      ? null
      : DateTime.parse(json['gateOutAt'] as String),
  sealNo: json['sealNo'] as String?,
  weighmentKg: (json['weighmentKg'] as num?)?.toDouble(),
  declaredKg: (json['declaredKg'] as num?)?.toDouble(),
  expectedPackages: (json['expectedPackages'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$HubTaskToJson(_HubTask instance) => <String, dynamic>{
  'id': instance.id,
  'type': _$HubTaskTypeEnumMap[instance.type]!,
  'vehicleNo': instance.vehicleNo,
  'customer': instance.customer,
  'eta': instance.eta?.toIso8601String(),
  'status': _$HubTaskStatusEnumMap[instance.status]!,
  'gateInAt': instance.gateInAt?.toIso8601String(),
  'gateOutAt': instance.gateOutAt?.toIso8601String(),
  'sealNo': instance.sealNo,
  'weighmentKg': instance.weighmentKg,
  'declaredKg': instance.declaredKg,
  'expectedPackages': instance.expectedPackages,
};

const _$HubTaskTypeEnumMap = {
  HubTaskType.loading: 'loading',
  HubTaskType.arrival: 'arrival',
};

const _$HubTaskStatusEnumMap = {
  HubTaskStatus.pending: 'pending',
  HubTaskStatus.inProgress: 'inProgress',
  HubTaskStatus.done: 'done',
};

_ScanItem _$ScanItemFromJson(Map<String, dynamic> json) => _ScanItem(
  code: json['code'] as String,
  at: DateTime.parse(json['at'] as String),
  damaged: json['damaged'] as bool? ?? false,
  shortage: json['shortage'] as bool? ?? false,
  photoPath: json['photoPath'] as String?,
);

Map<String, dynamic> _$ScanItemToJson(_ScanItem instance) => <String, dynamic>{
  'code': instance.code,
  'at': instance.at.toIso8601String(),
  'damaged': instance.damaged,
  'shortage': instance.shortage,
  'photoPath': instance.photoPath,
};

_Manifest _$ManifestFromJson(Map<String, dynamic> json) => _Manifest(
  id: json['id'] as String,
  destHub: json['destHub'] as String,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => ScanItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ManifestToJson(_Manifest instance) => <String, dynamic>{
  'id': instance.id,
  'destHub': instance.destHub,
  'items': instance.items,
  'createdAt': instance.createdAt.toIso8601String(),
};
