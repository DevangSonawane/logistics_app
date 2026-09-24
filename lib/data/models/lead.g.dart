// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Lead _$LeadFromJson(Map<String, dynamic> json) => _Lead(
      id: json['id'] as String,
      company: json['company'] as String,
      contact: json['contact'] as String,
      phone: json['phone'] as String,
      source: $enumDecodeNullable(_$LeadSourceEnumMap, json['source']) ??
          LeadSource.website,
      from: json['from'] as String,
      to: json['to'] as String,
      commodity: json['commodity'] as String?,
      weightKg: (json['weightKg'] as num?)?.toDouble(),
      vehicleType: json['vehicleType'] as String?,
      frequency: json['frequency'] as String?,
      expectedTrips: (json['expectedTrips'] as num?)?.toInt() ?? 0,
      targetRate: (json['targetRate'] as num?)?.toInt() ?? 0,
      stage: $enumDecodeNullable(_$LeadStageEnumMap, json['stage']) ??
          LeadStage.fresh,
      slaDue: json['slaDue'] == null
          ? null
          : DateTime.parse(json['slaDue'] as String),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$LeadToJson(_Lead instance) => <String, dynamic>{
      'id': instance.id,
      'company': instance.company,
      'contact': instance.contact,
      'phone': instance.phone,
      'source': _$LeadSourceEnumMap[instance.source]!,
      'from': instance.from,
      'to': instance.to,
      'commodity': instance.commodity,
      'weightKg': instance.weightKg,
      'vehicleType': instance.vehicleType,
      'frequency': instance.frequency,
      'expectedTrips': instance.expectedTrips,
      'targetRate': instance.targetRate,
      'stage': _$LeadStageEnumMap[instance.stage]!,
      'slaDue': instance.slaDue?.toIso8601String(),
      'notes': instance.notes,
    };

const _$LeadSourceEnumMap = {
  LeadSource.website: 'website',
  LeadSource.whatsapp: 'whatsapp',
  LeadSource.indiamart: 'indiamart',
  LeadSource.justdial: 'justdial',
  LeadSource.ivr: 'ivr',
  LeadSource.email: 'email',
  LeadSource.walkin: 'walkin',
  LeadSource.referral: 'referral',
};

const _$LeadStageEnumMap = {
  LeadStage.fresh: 'fresh',
  LeadStage.contacted: 'contacted',
  LeadStage.quoted: 'quoted',
  LeadStage.negotiation: 'negotiation',
  LeadStage.won: 'won',
  LeadStage.lost: 'lost',
};

_Quote _$QuoteFromJson(Map<String, dynamic> json) => _Quote(
      id: json['id'] as String,
      leadId: json['leadId'] as String?,
      laneFrom: json['laneFrom'] as String,
      laneTo: json['laneTo'] as String,
      vehicleType: json['vehicleType'] as String,
      rate: (json['rate'] as num).toInt(),
      charges: (json['charges'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      validTill: DateTime.parse(json['validTill'] as String),
      status: json['status'] as String? ?? 'draft',
    );

Map<String, dynamic> _$QuoteToJson(_Quote instance) => <String, dynamic>{
      'id': instance.id,
      'leadId': instance.leadId,
      'laneFrom': instance.laneFrom,
      'laneTo': instance.laneTo,
      'vehicleType': instance.vehicleType,
      'rate': instance.rate,
      'charges': instance.charges,
      'validTill': instance.validTill.toIso8601String(),
      'status': instance.status,
    };

_Visit _$VisitFromJson(Map<String, dynamic> json) => _Visit(
      id: json['id'] as String,
      title: json['title'] as String,
      plannedAt: json['plannedAt'] == null
          ? null
          : DateTime.parse(json['plannedAt'] as String),
      checkedInAt: json['checkedInAt'] == null
          ? null
          : DateTime.parse(json['checkedInAt'] as String),
      checkedOutAt: json['checkedOutAt'] == null
          ? null
          : DateTime.parse(json['checkedOutAt'] as String),
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      photoPath: json['photoPath'] as String?,
      note: json['note'] as String?,
      outcome: json['outcome'] as String?,
    );

Map<String, dynamic> _$VisitToJson(_Visit instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'plannedAt': instance.plannedAt?.toIso8601String(),
      'checkedInAt': instance.checkedInAt?.toIso8601String(),
      'checkedOutAt': instance.checkedOutAt?.toIso8601String(),
      'lat': instance.lat,
      'lng': instance.lng,
      'photoPath': instance.photoPath,
      'note': instance.note,
      'outcome': instance.outcome,
    };

_SalesTarget _$SalesTargetFromJson(Map<String, dynamic> json) => _SalesTarget(
      label: json['label'] as String,
      achieved: (json['achieved'] as num).toInt(),
      target: (json['target'] as num).toInt(),
    );

Map<String, dynamic> _$SalesTargetToJson(_SalesTarget instance) =>
    <String, dynamic>{
      'label': instance.label,
      'achieved': instance.achieved,
      'target': instance.target,
    };
