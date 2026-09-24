import 'package:freezed_annotation/freezed_annotation.dart';

part 'advance.freezed.dart';
part 'advance.g.dart';

enum AdvancePurpose { fuel, toll, repair, food, other }

enum AdvanceStatus { requested, approved, paid, rejected }

/// Cash advance against a trip. Status changes arrive via notification.
/// Amounts are integer rupees.
@freezed
abstract class Advance with _$Advance {
  const factory Advance({
    required String id,
    required String tripId,
    required int amount,
    required AdvancePurpose purpose,
    String? note,
    @Default(AdvanceStatus.requested) AdvanceStatus status,
    required DateTime requestedAt,
  }) = _Advance;

  factory Advance.fromJson(Map<String, dynamic> json) =>
      _$AdvanceFromJson(json);
}
