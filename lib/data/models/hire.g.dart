// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hire.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HireMemo _$HireMemoFromJson(Map<String, dynamic> json) => _HireMemo(
  id: json['id'] as String,
  vehicleNo: json['vehicleNo'] as String,
  ownerName: json['ownerName'] as String,
  pan: json['pan'] as String?,
  driverName: json['driverName'] as String,
  driverPhone: json['driverPhone'] as String,
  freight: (json['freight'] as num).toInt(),
  advance: (json['advance'] as num?)?.toInt() ?? 0,
  deductions: (json['deductions'] as num?)?.toInt() ?? 0,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$HireMemoToJson(_HireMemo instance) => <String, dynamic>{
  'id': instance.id,
  'vehicleNo': instance.vehicleNo,
  'ownerName': instance.ownerName,
  'pan': instance.pan,
  'driverName': instance.driverName,
  'driverPhone': instance.driverPhone,
  'freight': instance.freight,
  'advance': instance.advance,
  'deductions': instance.deductions,
  'createdAt': instance.createdAt.toIso8601String(),
};

_MarketVehicle _$MarketVehicleFromJson(Map<String, dynamic> json) =>
    _MarketVehicle(
      vehicleNo: json['vehicleNo'] as String,
      ownerName: json['ownerName'] as String,
      pan: json['pan'] as String?,
      driverName: json['driverName'] as String,
      driverPhone: json['driverPhone'] as String,
      kycPhotos:
          (json['kycPhotos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MarketVehicleToJson(_MarketVehicle instance) =>
    <String, dynamic>{
      'vehicleNo': instance.vehicleNo,
      'ownerName': instance.ownerName,
      'pan': instance.pan,
      'driverName': instance.driverName,
      'driverPhone': instance.driverPhone,
      'kycPhotos': instance.kycPhotos,
    };
