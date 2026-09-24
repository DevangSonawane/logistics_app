import 'package:freezed_annotation/freezed_annotation.dart';

part 'exception.freezed.dart';
part 'exception.g.dart';

enum ExceptionType {
  delay,
  halt,
  deviation,
  overspeed,
  deviceOff,
  ewayExpiring,
  podPending,
  sos,
}

enum ExceptionSeverity { low, medium, high, critical }

/// Ops exceptions feed row. SOS is critical and pins to the top.
@freezed
abstract class ExceptionItem with _$ExceptionItem {
  const factory ExceptionItem({
    required String id,
    required ExceptionType type,
    required String tripId,
    required String vehicleReg,
    required String driverName,
    required String driverPhone,
    @Default(ExceptionSeverity.medium) ExceptionSeverity severity,
    required String message,
    required DateTime at,
    @Default(false) bool resolved,
    String? resolutionNote,
  }) = _ExceptionItem;

  factory ExceptionItem.fromJson(Map<String, dynamic> json) =>
      _$ExceptionItemFromJson(json);
}
