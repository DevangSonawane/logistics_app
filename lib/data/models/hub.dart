import 'package:freezed_annotation/freezed_annotation.dart';

part 'hub.freezed.dart';
part 'hub.g.dart';

enum HubTaskType { loading, arrival }

enum HubTaskStatus { pending, inProgress, done }

/// Loading / arrival card for the supervisor's hub.
@freezed
abstract class HubTask with _$HubTask {
  const factory HubTask({
    required String id,
    required HubTaskType type,
    required String vehicleNo,
    required String customer,
    DateTime? eta,
    @Default(HubTaskStatus.pending) HubTaskStatus status,
    DateTime? gateInAt,
    DateTime? gateOutAt,
    String? sealNo,
    double? weighmentKg,
    double? declaredKg,
    @Default(0) int expectedPackages,
  }) = _HubTask;

  factory HubTask.fromJson(Map<String, dynamic> json) =>
      _$HubTaskFromJson(json);
}

/// Scanned PTL package (continuous scanner list).
@freezed
abstract class ScanItem with _$ScanItem {
  const factory ScanItem({
    required String code,
    required DateTime at,
    @Default(false) bool damaged,
    @Default(false) bool shortage,
    String? photoPath,
  }) = _ScanItem;

  factory ScanItem.fromJson(Map<String, dynamic> json) =>
      _$ScanItemFromJson(json);
}

/// PTL manifest built from scanned items.
@freezed
abstract class Manifest with _$Manifest {
  const factory Manifest({
    required String id,
    required String destHub,
    @Default([]) List<ScanItem> items,
    required DateTime createdAt,
  }) = _Manifest;

  factory Manifest.fromJson(Map<String, dynamic> json) =>
      _$ManifestFromJson(json);
}
