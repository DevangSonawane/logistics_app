import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard.freezed.dart';
part 'dashboard.g.dart';

/// Owner dashboard KPI bundle. Money in integer rupees.
@freezed
abstract class DashboardKpis with _$DashboardKpis {
  const factory DashboardKpis({
    @Default(0) int tripsToday,
    @Default(0) int running,
    @Default(0) int delayed,
    @Default(0) int delivered,
    @Default(0) int revenueToday,
    @Default(0) int revenueMonth,
    @Default(0) int collectionsMonth,
    @Default(0) int outstanding,
    @Default(0) int cashBank,
    @Default(0) int utilisationPct,
  }) = _DashboardKpis;

  factory DashboardKpis.fromJson(Map<String, dynamic> json) =>
      _$DashboardKpisFromJson(json);
}

@freezed
abstract class TrendPoint with _$TrendPoint {
  const factory TrendPoint({
    required String day,
    required int revenue,
    required int collection,
  }) = _TrendPoint;

  factory TrendPoint.fromJson(Map<String, dynamic> json) =>
      _$TrendPointFromJson(json);
}

@freezed
abstract class LaneMargin with _$LaneMargin {
  const factory LaneMargin({
    required String lane,
    required int marginPct,
  }) = _LaneMargin;

  factory LaneMargin.fromJson(Map<String, dynamic> json) =>
      _$LaneMarginFromJson(json);
}

@freezed
abstract class CustomerMargin with _$CustomerMargin {
  const factory CustomerMargin({
    required String name,
    required int marginPct,
    required int outstanding,
  }) = _CustomerMargin;

  factory CustomerMargin.fromJson(Map<String, dynamic> json) =>
      _$CustomerMarginFromJson(json);
}

/// Attention strip card: delayed trips, approvals, docs, POD backlog.
@freezed
abstract class AttentionItem with _$AttentionItem {
  const factory AttentionItem({
    required String title,
    required int count,
    required String kind,
  }) = _AttentionItem;

  factory AttentionItem.fromJson(Map<String, dynamic> json) =>
      _$AttentionItemFromJson(json);
}

/// Canned ask-your-data answer with a mini chart series.
@freezed
abstract class DataAnswer with _$DataAnswer {
  const factory DataAnswer({
    required String text,
    @Default([]) List<int> series,
  }) = _DataAnswer;

  factory DataAnswer.fromJson(Map<String, dynamic> json) =>
      _$DataAnswerFromJson(json);
}
