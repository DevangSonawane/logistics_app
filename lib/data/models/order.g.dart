// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderStop _$OrderStopFromJson(Map<String, dynamic> json) => _OrderStop(
      address: json['address'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      windowStart: json['windowStart'] == null
          ? null
          : DateTime.parse(json['windowStart'] as String),
      windowEnd: json['windowEnd'] == null
          ? null
          : DateTime.parse(json['windowEnd'] as String),
    );

Map<String, dynamic> _$OrderStopToJson(_OrderStop instance) =>
    <String, dynamic>{
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'windowStart': instance.windowStart?.toIso8601String(),
      'windowEnd': instance.windowEnd?.toIso8601String(),
    };

_Order _$OrderFromJson(Map<String, dynamic> json) => _Order(
      id: json['id'] as String,
      no: json['no'] as String,
      customerId: json['customerId'] as String,
      customerName: json['customerName'] as String,
      type: $enumDecode(_$OrderTypeEnumMap, json['type']),
      stops: (json['stops'] as List<dynamic>?)
              ?.map((e) => OrderStop.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      vehicleType: json['vehicleType'] as String,
      commodity: json['commodity'] as String,
      weightKg: (json['weightKg'] as num).toDouble(),
      declaredValue: (json['declaredValue'] as num?)?.toDouble(),
      rate: (json['rate'] as num).toInt(),
      status: $enumDecodeNullable(_$OrderStatusEnumMap, json['status']) ??
          OrderStatus.pending,
      neededBy: json['neededBy'] == null
          ? null
          : DateTime.parse(json['neededBy'] as String),
      tripId: json['tripId'] as String?,
    );

Map<String, dynamic> _$OrderToJson(_Order instance) => <String, dynamic>{
      'id': instance.id,
      'no': instance.no,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'type': _$OrderTypeEnumMap[instance.type]!,
      'stops': instance.stops,
      'vehicleType': instance.vehicleType,
      'commodity': instance.commodity,
      'weightKg': instance.weightKg,
      'declaredValue': instance.declaredValue,
      'rate': instance.rate,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'neededBy': instance.neededBy?.toIso8601String(),
      'tripId': instance.tripId,
    };

const _$OrderTypeEnumMap = {
  OrderType.ftl: 'ftl',
  OrderType.ptl: 'ptl',
};

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.planned: 'planned',
  OrderStatus.running: 'running',
  OrderStatus.completed: 'completed',
  OrderStatus.cancelled: 'cancelled',
};
