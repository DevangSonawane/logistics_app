// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomerContact _$CustomerContactFromJson(Map<String, dynamic> json) =>
    _CustomerContact(
      name: json['name'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$CustomerContactToJson(_CustomerContact instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'role': instance.role,
    };

_Customer _$CustomerFromJson(Map<String, dynamic> json) => _Customer(
  id: json['id'] as String,
  name: json['name'] as String,
  gstin: json['gstin'] as String,
  pan: json['pan'] as String?,
  creditDays: (json['creditDays'] as num?)?.toInt() ?? 30,
  creditLimit: (json['creditLimit'] as num?)?.toInt() ?? 0,
  outstanding: (json['outstanding'] as num?)?.toInt() ?? 0,
  contacts:
      (json['contacts'] as List<dynamic>?)
          ?.map((e) => CustomerContact.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$CustomerToJson(_Customer instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'gstin': instance.gstin,
  'pan': instance.pan,
  'creditDays': instance.creditDays,
  'creditLimit': instance.creditLimit,
  'outstanding': instance.outstanding,
  'contacts': instance.contacts,
};
