import 'package:freezed_annotation/freezed_annotation.dart';

part 'lead.freezed.dart';
part 'lead.g.dart';

enum LeadStage { fresh, contacted, quoted, negotiation, won, lost }

enum LeadSource {
  website,
  whatsapp,
  indiamart,
  justdial,
  ivr,
  email,
  walkin,
  referral,
}

/// Sales lead with SLA clock and stage pipeline.
@freezed
abstract class Lead with _$Lead {
  const factory Lead({
    required String id,
    required String company,
    required String contact,
    required String phone,
    @Default(LeadSource.website) LeadSource source,
    required String from,
    required String to,
    String? commodity,
    double? weightKg,
    String? vehicleType,
    String? frequency,
    @Default(0) int expectedTrips,
    @Default(0) int targetRate,
    @Default(LeadStage.fresh) LeadStage stage,
    DateTime? slaDue,
    String? notes,
  }) = _Lead;

  factory Lead.fromJson(Map<String, dynamic> json) => _$LeadFromJson(json);
}

/// Quick quote with extra charges. Margin is never shown to sales.
@freezed
abstract class Quote with _$Quote {
  const factory Quote({
    required String id,
    String? leadId,
    required String laneFrom,
    required String laneTo,
    required String vehicleType,
    required int rate,
    @Default({}) Map<String, int> charges,
    required DateTime validTill,
    @Default('draft') String status,
  }) = _Quote;

  factory Quote.fromJson(Map<String, dynamic> json) =>
      _$QuoteFromJson(json);
}

/// Customer visit with GPS check-in/out.
@freezed
abstract class Visit with _$Visit {
  const factory Visit({
    required String id,
    required String title,
    DateTime? plannedAt,
    DateTime? checkedInAt,
    DateTime? checkedOutAt,
    double? lat,
    double? lng,
    String? photoPath,
    String? note,
    String? outcome,
  }) = _Visit;

  factory Visit.fromJson(Map<String, dynamic> json) =>
      _$VisitFromJson(json);
}

/// Sales targets vs achievement ring data.
@freezed
abstract class SalesTarget with _$SalesTarget {
  const factory SalesTarget({
    required String label,
    required int achieved,
    required int target,
  }) = _SalesTarget;

  factory SalesTarget.fromJson(Map<String, dynamic> json) =>
      _$SalesTargetFromJson(json);
}
