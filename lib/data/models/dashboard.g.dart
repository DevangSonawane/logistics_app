// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardKpis _$DashboardKpisFromJson(Map<String, dynamic> json) =>
    _DashboardKpis(
      tripsToday: (json['tripsToday'] as num?)?.toInt() ?? 0,
      running: (json['running'] as num?)?.toInt() ?? 0,
      delayed: (json['delayed'] as num?)?.toInt() ?? 0,
      delivered: (json['delivered'] as num?)?.toInt() ?? 0,
      revenueToday: (json['revenueToday'] as num?)?.toInt() ?? 0,
      revenueMonth: (json['revenueMonth'] as num?)?.toInt() ?? 0,
      collectionsMonth: (json['collectionsMonth'] as num?)?.toInt() ?? 0,
      outstanding: (json['outstanding'] as num?)?.toInt() ?? 0,
      cashBank: (json['cashBank'] as num?)?.toInt() ?? 0,
      utilisationPct: (json['utilisationPct'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$DashboardKpisToJson(_DashboardKpis instance) =>
    <String, dynamic>{
      'tripsToday': instance.tripsToday,
      'running': instance.running,
      'delayed': instance.delayed,
      'delivered': instance.delivered,
      'revenueToday': instance.revenueToday,
      'revenueMonth': instance.revenueMonth,
      'collectionsMonth': instance.collectionsMonth,
      'outstanding': instance.outstanding,
      'cashBank': instance.cashBank,
      'utilisationPct': instance.utilisationPct,
    };

_TrendPoint _$TrendPointFromJson(Map<String, dynamic> json) => _TrendPoint(
  day: json['day'] as String,
  revenue: (json['revenue'] as num).toInt(),
  collection: (json['collection'] as num).toInt(),
);

Map<String, dynamic> _$TrendPointToJson(_TrendPoint instance) =>
    <String, dynamic>{
      'day': instance.day,
      'revenue': instance.revenue,
      'collection': instance.collection,
    };

_LaneMargin _$LaneMarginFromJson(Map<String, dynamic> json) => _LaneMargin(
  lane: json['lane'] as String,
  marginPct: (json['marginPct'] as num).toInt(),
);

Map<String, dynamic> _$LaneMarginToJson(_LaneMargin instance) =>
    <String, dynamic>{'lane': instance.lane, 'marginPct': instance.marginPct};

_CustomerMargin _$CustomerMarginFromJson(Map<String, dynamic> json) =>
    _CustomerMargin(
      name: json['name'] as String,
      marginPct: (json['marginPct'] as num).toInt(),
      outstanding: (json['outstanding'] as num).toInt(),
    );

Map<String, dynamic> _$CustomerMarginToJson(_CustomerMargin instance) =>
    <String, dynamic>{
      'name': instance.name,
      'marginPct': instance.marginPct,
      'outstanding': instance.outstanding,
    };

_AttentionItem _$AttentionItemFromJson(Map<String, dynamic> json) =>
    _AttentionItem(
      title: json['title'] as String,
      count: (json['count'] as num).toInt(),
      kind: json['kind'] as String,
    );

Map<String, dynamic> _$AttentionItemToJson(_AttentionItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'count': instance.count,
      'kind': instance.kind,
    };

_DataAnswer _$DataAnswerFromJson(Map<String, dynamic> json) => _DataAnswer(
  text: json['text'] as String,
  series:
      (json['series'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
);

Map<String, dynamic> _$DataAnswerToJson(_DataAnswer instance) =>
    <String, dynamic>{'text': instance.text, 'series': instance.series};
