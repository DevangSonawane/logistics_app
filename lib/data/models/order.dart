import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

enum OrderType { ftl, ptl }

enum OrderStatus { pending, planned, running, completed, cancelled }

@freezed
abstract class OrderStop with _$OrderStop {
  const factory OrderStop({
    required String address,
    required double lat,
    required double lng,
    DateTime? windowStart,
    DateTime? windowEnd,
  }) = _OrderStop;

  factory OrderStop.fromJson(Map<String, dynamic> json) =>
      _$OrderStopFromJson(json);
}

/// Customer order. Ops plans it onto a vehicle + driver to create a trip.
@freezed
abstract class Order with _$Order {
  const factory Order({
    required String id,
    required String no,
    required String customerId,
    required String customerName,
    required OrderType type,
    @Default([]) List<OrderStop> stops,
    required String vehicleType,
    required String commodity,
    required double weightKg,
    double? declaredValue,
    required int rate,
    @Default(OrderStatus.pending) OrderStatus status,
    DateTime? neededBy,
    String? tripId,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) =>
      _$OrderFromJson(json);
}
