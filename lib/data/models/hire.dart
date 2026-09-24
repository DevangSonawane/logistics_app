import 'package:freezed_annotation/freezed_annotation.dart';

part 'hire.freezed.dart';
part 'hire.g.dart';

/// Market (broker) vehicle hire memo. Balance on POD; advances above the
/// limit raise an approval instead of paying out directly.
@freezed
abstract class HireMemo with _$HireMemo {
  const factory HireMemo({
    required String id,
    required String vehicleNo,
    required String ownerName,
    String? pan,
    required String driverName,
    required String driverPhone,
    required int freight,
    @Default(0) int advance,
    @Default(0) int deductions,
    required DateTime createdAt,
  }) = _HireMemo;

  factory HireMemo.fromJson(Map<String, dynamic> json) =>
      _$HireMemoFromJson(json);
}

/// Broker vehicle master row (KYC photos stored app-private).
@freezed
abstract class MarketVehicle with _$MarketVehicle {
  const factory MarketVehicle({
    required String vehicleNo,
    required String ownerName,
    String? pan,
    required String driverName,
    required String driverPhone,
    @Default([]) List<String> kycPhotos,
  }) = _MarketVehicle;

  factory MarketVehicle.fromJson(Map<String, dynamic> json) =>
      _$MarketVehicleFromJson(json);
}
