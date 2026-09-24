import 'package:freezed_annotation/freezed_annotation.dart';

part 'offline_action.freezed.dart';
part 'offline_action.g.dart';

/// Lifecycle of a queued offline action.
enum OfflineActionStatus { pending, uploading, failed, done, rejected }

/// One mutating driver/supervisor action stored in Hive and synced FIFO.
/// Attachments are app-private file paths until uploaded.
@freezed
abstract class OfflineAction with _$OfflineAction {
  const factory OfflineAction({
    required String id,
    required String type,
    String? tripId,
    required Map<String, dynamic> payload,
    @Default([]) List<String> attachments,
    required DateTime createdAt,
    @Default(0) int retryCount,
    @Default(OfflineActionStatus.pending) OfflineActionStatus status,
    String? failureReason,
  }) = _OfflineAction;

  factory OfflineAction.fromJson(Map<String, dynamic> json) =>
      _$OfflineActionFromJson(json);
}

/// Well-known action types produced by driver/supervisor flows.
abstract final class OfflineActionType {
  static const String tripStatus = 'trip_status';
  static const String tripOfferResponse = 'trip_offer_response';
  static const String podSubmit = 'pod_submit';
  static const String expenseAdd = 'expense_add';
  static const String advanceRequest = 'advance_request';
  static const String sos = 'sos';
  static const String gpsBatch = 'gps_batch';
  static const String scanSubmit = 'scan_submit';
  static const String gateEvent = 'gate_event';
  static const String visitCheckIn = 'visit_checkin';
}
