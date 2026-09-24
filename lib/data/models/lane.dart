import 'package:freezed_annotation/freezed_annotation.dart';

part 'lane.freezed.dart';
part 'lane.g.dart';

/// Lane master with distance and standard transit time.
@freezed
abstract class Lane with _$Lane {
  const factory Lane({
    required String id,
    required String from,
    required String to,
    required double distanceKm,
    required int transitHrs,
  }) = _Lane;

  factory Lane.fromJson(Map<String, dynamic> json) => _$LaneFromJson(json);
}
