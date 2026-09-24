import 'package:freezed_annotation/freezed_annotation.dart';

part 'pod.freezed.dart';
part 'pod.g.dart';

/// Consignee confirmation method.
enum PodMethod { otp, signature }

/// POD submission queued from the driver POD flow.
@freezed
abstract class PodSubmission with _$PodSubmission {
  const factory PodSubmission({
    required String tripId,
    required String lrPhotoPath,
    required PodMethod method,
    String? consigneeName,
    @Default(false) bool hasDamageOrShortage,
    String? damageRemark,
    int? damageQty,
    @Default([]) List<String> damagePhotos,
    required DateTime submittedAt,
  }) = _PodSubmission;

  factory PodSubmission.fromJson(Map<String, dynamic> json) =>
      _$PodSubmissionFromJson(json);
}
