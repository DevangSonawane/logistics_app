import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle.freezed.dart';
part 'vehicle.g.dart';

enum VehicleDocType { licence, rc, insurance, fitness, permit, puc }

/// One vehicle document with expiry tracking. Cached offline.
@freezed
abstract class VehicleDoc with _$VehicleDoc {
  const factory VehicleDoc({
    required VehicleDocType type,
    required String number,
    required DateTime expiry,
    String? photoPath,
  }) = _VehicleDoc;

  factory VehicleDoc.fromJson(Map<String, dynamic> json) =>
      _$VehicleDocFromJson(json);
}

/// Expiry countdown band: green > 30 d, amber <= 30, red <= 7 or expired.
enum DocExpiryBand { ok, warning, critical }

DocExpiryBand expiryBand(DateTime expiry, DateTime now) {
  final int days = expiry.difference(now).inDays;
  if (days <= 7) return DocExpiryBand.critical;
  if (days <= 30) return DocExpiryBand.warning;
  return DocExpiryBand.ok;
}

@freezed
abstract class Vehicle with _$Vehicle {
  const factory Vehicle({
    required String id,
    required String regNo,
    required String type,
    @Default([]) List<VehicleDoc> docs,
  }) = _Vehicle;

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);
}
