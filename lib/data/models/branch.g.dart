// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Branch _$BranchFromJson(Map<String, dynamic> json) => _Branch(
      id: json['id'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$BranchToJson(_Branch instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
      'isActive': instance.isActive,
    };

_Company _$CompanyFromJson(Map<String, dynamic> json) => _Company(
      id: json['id'] as String,
      name: json['name'] as String,
      branches: (json['branches'] as List<dynamic>)
          .map((e) => Branch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompanyToJson(_Company instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'branches': instance.branches,
    };
