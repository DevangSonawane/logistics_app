// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  id: json['id'] as String,
  name: json['name'] as String,
  phone: json['phone'] as String,
  roles: (json['roles'] as List<dynamic>)
      .map((e) => $enumDecode(_$AppRoleEnumMap, e))
      .toList(),
  branchIds: (json['branchIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  avatarUrl: json['avatarUrl'] as String?,
  language: json['language'] as String,
  canRecordReceipt: json['canRecordReceipt'] as bool? ?? false,
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'phone': instance.phone,
  'roles': instance.roles.map((e) => _$AppRoleEnumMap[e]!).toList(),
  'branchIds': instance.branchIds,
  'avatarUrl': instance.avatarUrl,
  'language': instance.language,
  'canRecordReceipt': instance.canRecordReceipt,
  'isActive': instance.isActive,
};

const _$AppRoleEnumMap = {
  AppRole.driver: 'driver',
  AppRole.owner: 'owner',
  AppRole.ops: 'ops',
  AppRole.sales: 'sales',
  AppRole.supervisor: 'supervisor',
  AppRole.accountant: 'accountant',
};
