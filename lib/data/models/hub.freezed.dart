// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hub.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HubTask {

 String get id; HubTaskType get type; String get vehicleNo; String get customer; DateTime? get eta; HubTaskStatus get status; DateTime? get gateInAt; DateTime? get gateOutAt; String? get sealNo; double? get weighmentKg; double? get declaredKg; int get expectedPackages;
/// Create a copy of HubTask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HubTaskCopyWith<HubTask> get copyWith => _$HubTaskCopyWithImpl<HubTask>(this as HubTask, _$identity);

  /// Serializes this HubTask to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as HubTask;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HubTask&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.vehicleNo, _this.vehicleNo) || other.vehicleNo == _this.vehicleNo)&&(identical(other.customer, _this.customer) || other.customer == _this.customer)&&(identical(other.eta, _this.eta) || other.eta == _this.eta)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.gateInAt, _this.gateInAt) || other.gateInAt == _this.gateInAt)&&(identical(other.gateOutAt, _this.gateOutAt) || other.gateOutAt == _this.gateOutAt)&&(identical(other.sealNo, _this.sealNo) || other.sealNo == _this.sealNo)&&(identical(other.weighmentKg, _this.weighmentKg) || other.weighmentKg == _this.weighmentKg)&&(identical(other.declaredKg, _this.declaredKg) || other.declaredKg == _this.declaredKg)&&(identical(other.expectedPackages, _this.expectedPackages) || other.expectedPackages == _this.expectedPackages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as HubTask;
  return Object.hash(runtimeType,_this.id,_this.type,_this.vehicleNo,_this.customer,_this.eta,_this.status,_this.gateInAt,_this.gateOutAt,_this.sealNo,_this.weighmentKg,_this.declaredKg,_this.expectedPackages);
}

@override
String toString() {
  final _this = this as HubTask;
  return 'HubTask(id: ${_this.id}, type: ${_this.type}, vehicleNo: ${_this.vehicleNo}, customer: ${_this.customer}, eta: ${_this.eta}, status: ${_this.status}, gateInAt: ${_this.gateInAt}, gateOutAt: ${_this.gateOutAt}, sealNo: ${_this.sealNo}, weighmentKg: ${_this.weighmentKg}, declaredKg: ${_this.declaredKg}, expectedPackages: ${_this.expectedPackages})';
}


}

/// @nodoc
abstract mixin class $HubTaskCopyWith<$Res>  {
  factory $HubTaskCopyWith(HubTask value, $Res Function(HubTask) _then) = _$HubTaskCopyWithImpl;
@useResult
$Res call({
 String id, HubTaskType type, String vehicleNo, String customer, DateTime? eta, HubTaskStatus status, DateTime? gateInAt, DateTime? gateOutAt, String? sealNo, double? weighmentKg, double? declaredKg, int expectedPackages
});




}
/// @nodoc
class _$HubTaskCopyWithImpl<$Res>
    implements $HubTaskCopyWith<$Res> {
  _$HubTaskCopyWithImpl(this._self, this._then);

  final HubTask _self;
  final $Res Function(HubTask) _then;

/// Create a copy of HubTask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? vehicleNo = null,Object? customer = null,Object? eta = freezed,Object? status = null,Object? gateInAt = freezed,Object? gateOutAt = freezed,Object? sealNo = freezed,Object? weighmentKg = freezed,Object? declaredKg = freezed,Object? expectedPackages = null,}) {
  return _then(HubTask(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HubTaskType,vehicleNo: null == vehicleNo ? _self.vehicleNo : vehicleNo // ignore: cast_nullable_to_non_nullable
as String,customer: null == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as String,eta: freezed == eta ? _self.eta : eta // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HubTaskStatus,gateInAt: freezed == gateInAt ? _self.gateInAt : gateInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,gateOutAt: freezed == gateOutAt ? _self.gateOutAt : gateOutAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sealNo: freezed == sealNo ? _self.sealNo : sealNo // ignore: cast_nullable_to_non_nullable
as String?,weighmentKg: freezed == weighmentKg ? _self.weighmentKg : weighmentKg // ignore: cast_nullable_to_non_nullable
as double?,declaredKg: freezed == declaredKg ? _self.declaredKg : declaredKg // ignore: cast_nullable_to_non_nullable
as double?,expectedPackages: null == expectedPackages ? _self.expectedPackages : expectedPackages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HubTask].
extension HubTaskPatterns on HubTask {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HubTask value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HubTask() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HubTask value)  $default,){
final _that = this;
switch (_that) {
case _HubTask():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HubTask value)?  $default,){
final _that = this;
switch (_that) {
case _HubTask() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  HubTaskType type,  String vehicleNo,  String customer,  DateTime? eta,  HubTaskStatus status,  DateTime? gateInAt,  DateTime? gateOutAt,  String? sealNo,  double? weighmentKg,  double? declaredKg,  int expectedPackages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HubTask() when $default != null:
return $default(_that.id,_that.type,_that.vehicleNo,_that.customer,_that.eta,_that.status,_that.gateInAt,_that.gateOutAt,_that.sealNo,_that.weighmentKg,_that.declaredKg,_that.expectedPackages);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  HubTaskType type,  String vehicleNo,  String customer,  DateTime? eta,  HubTaskStatus status,  DateTime? gateInAt,  DateTime? gateOutAt,  String? sealNo,  double? weighmentKg,  double? declaredKg,  int expectedPackages)  $default,) {final _that = this;
switch (_that) {
case _HubTask():
return $default(_that.id,_that.type,_that.vehicleNo,_that.customer,_that.eta,_that.status,_that.gateInAt,_that.gateOutAt,_that.sealNo,_that.weighmentKg,_that.declaredKg,_that.expectedPackages);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  HubTaskType type,  String vehicleNo,  String customer,  DateTime? eta,  HubTaskStatus status,  DateTime? gateInAt,  DateTime? gateOutAt,  String? sealNo,  double? weighmentKg,  double? declaredKg,  int expectedPackages)?  $default,) {final _that = this;
switch (_that) {
case _HubTask() when $default != null:
return $default(_that.id,_that.type,_that.vehicleNo,_that.customer,_that.eta,_that.status,_that.gateInAt,_that.gateOutAt,_that.sealNo,_that.weighmentKg,_that.declaredKg,_that.expectedPackages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HubTask implements HubTask {
  const _HubTask({required this.id, required this.type, required this.vehicleNo, required this.customer, this.eta, this.status = HubTaskStatus.pending, this.gateInAt, this.gateOutAt, this.sealNo, this.weighmentKg, this.declaredKg, this.expectedPackages = 0});
  factory _HubTask.fromJson(Map<String, dynamic> json) => _$HubTaskFromJson(json);

@override final  String id;
@override final  HubTaskType type;
@override final  String vehicleNo;
@override final  String customer;
@override final  DateTime? eta;
@override@JsonKey() final  HubTaskStatus status;
@override final  DateTime? gateInAt;
@override final  DateTime? gateOutAt;
@override final  String? sealNo;
@override final  double? weighmentKg;
@override final  double? declaredKg;
@override@JsonKey() final  int expectedPackages;

/// Create a copy of HubTask
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HubTaskCopyWith<_HubTask> get copyWith => __$HubTaskCopyWithImpl<_HubTask>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HubTaskToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HubTask&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.vehicleNo, vehicleNo) || other.vehicleNo == vehicleNo)&&(identical(other.customer, customer) || other.customer == customer)&&(identical(other.eta, eta) || other.eta == eta)&&(identical(other.status, status) || other.status == status)&&(identical(other.gateInAt, gateInAt) || other.gateInAt == gateInAt)&&(identical(other.gateOutAt, gateOutAt) || other.gateOutAt == gateOutAt)&&(identical(other.sealNo, sealNo) || other.sealNo == sealNo)&&(identical(other.weighmentKg, weighmentKg) || other.weighmentKg == weighmentKg)&&(identical(other.declaredKg, declaredKg) || other.declaredKg == declaredKg)&&(identical(other.expectedPackages, expectedPackages) || other.expectedPackages == expectedPackages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,type,vehicleNo,customer,eta,status,gateInAt,gateOutAt,sealNo,weighmentKg,declaredKg,expectedPackages);
}

@override
String toString() {
    return 'HubTask(id: $id, type: $type, vehicleNo: $vehicleNo, customer: $customer, eta: $eta, status: $status, gateInAt: $gateInAt, gateOutAt: $gateOutAt, sealNo: $sealNo, weighmentKg: $weighmentKg, declaredKg: $declaredKg, expectedPackages: $expectedPackages)';
}


}

/// @nodoc
abstract mixin class _$HubTaskCopyWith<$Res> implements $HubTaskCopyWith<$Res> {
  factory _$HubTaskCopyWith(_HubTask value, $Res Function(_HubTask) _then) = __$HubTaskCopyWithImpl;
@override @useResult
$Res call({
 String id, HubTaskType type, String vehicleNo, String customer, DateTime? eta, HubTaskStatus status, DateTime? gateInAt, DateTime? gateOutAt, String? sealNo, double? weighmentKg, double? declaredKg, int expectedPackages
});




}
/// @nodoc
class __$HubTaskCopyWithImpl<$Res>
    implements _$HubTaskCopyWith<$Res> {
  __$HubTaskCopyWithImpl(this._self, this._then);

  final _HubTask _self;
  final $Res Function(_HubTask) _then;

/// Create a copy of HubTask
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? vehicleNo = null,Object? customer = null,Object? eta = freezed,Object? status = null,Object? gateInAt = freezed,Object? gateOutAt = freezed,Object? sealNo = freezed,Object? weighmentKg = freezed,Object? declaredKg = freezed,Object? expectedPackages = null,}) {
  return _then(_HubTask(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HubTaskType,vehicleNo: null == vehicleNo ? _self.vehicleNo : vehicleNo // ignore: cast_nullable_to_non_nullable
as String,customer: null == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as String,eta: freezed == eta ? _self.eta : eta // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HubTaskStatus,gateInAt: freezed == gateInAt ? _self.gateInAt : gateInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,gateOutAt: freezed == gateOutAt ? _self.gateOutAt : gateOutAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sealNo: freezed == sealNo ? _self.sealNo : sealNo // ignore: cast_nullable_to_non_nullable
as String?,weighmentKg: freezed == weighmentKg ? _self.weighmentKg : weighmentKg // ignore: cast_nullable_to_non_nullable
as double?,declaredKg: freezed == declaredKg ? _self.declaredKg : declaredKg // ignore: cast_nullable_to_non_nullable
as double?,expectedPackages: null == expectedPackages ? _self.expectedPackages : expectedPackages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ScanItem {

 String get code; DateTime get at; bool get damaged; bool get shortage; String? get photoPath;
/// Create a copy of ScanItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanItemCopyWith<ScanItem> get copyWith => _$ScanItemCopyWithImpl<ScanItem>(this as ScanItem, _$identity);

  /// Serializes this ScanItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ScanItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanItem&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.at, _this.at) || other.at == _this.at)&&(identical(other.damaged, _this.damaged) || other.damaged == _this.damaged)&&(identical(other.shortage, _this.shortage) || other.shortage == _this.shortage)&&(identical(other.photoPath, _this.photoPath) || other.photoPath == _this.photoPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ScanItem;
  return Object.hash(runtimeType,_this.code,_this.at,_this.damaged,_this.shortage,_this.photoPath);
}

@override
String toString() {
  final _this = this as ScanItem;
  return 'ScanItem(code: ${_this.code}, at: ${_this.at}, damaged: ${_this.damaged}, shortage: ${_this.shortage}, photoPath: ${_this.photoPath})';
}


}

/// @nodoc
abstract mixin class $ScanItemCopyWith<$Res>  {
  factory $ScanItemCopyWith(ScanItem value, $Res Function(ScanItem) _then) = _$ScanItemCopyWithImpl;
@useResult
$Res call({
 String code, DateTime at, bool damaged, bool shortage, String? photoPath
});




}
/// @nodoc
class _$ScanItemCopyWithImpl<$Res>
    implements $ScanItemCopyWith<$Res> {
  _$ScanItemCopyWithImpl(this._self, this._then);

  final ScanItem _self;
  final $Res Function(ScanItem) _then;

/// Create a copy of ScanItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? at = null,Object? damaged = null,Object? shortage = null,Object? photoPath = freezed,}) {
  return _then(ScanItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,damaged: null == damaged ? _self.damaged : damaged // ignore: cast_nullable_to_non_nullable
as bool,shortage: null == shortage ? _self.shortage : shortage // ignore: cast_nullable_to_non_nullable
as bool,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ScanItem].
extension ScanItemPatterns on ScanItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScanItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScanItem value)  $default,){
final _that = this;
switch (_that) {
case _ScanItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScanItem value)?  $default,){
final _that = this;
switch (_that) {
case _ScanItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  DateTime at,  bool damaged,  bool shortage,  String? photoPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanItem() when $default != null:
return $default(_that.code,_that.at,_that.damaged,_that.shortage,_that.photoPath);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  DateTime at,  bool damaged,  bool shortage,  String? photoPath)  $default,) {final _that = this;
switch (_that) {
case _ScanItem():
return $default(_that.code,_that.at,_that.damaged,_that.shortage,_that.photoPath);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  DateTime at,  bool damaged,  bool shortage,  String? photoPath)?  $default,) {final _that = this;
switch (_that) {
case _ScanItem() when $default != null:
return $default(_that.code,_that.at,_that.damaged,_that.shortage,_that.photoPath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScanItem implements ScanItem {
  const _ScanItem({required this.code, required this.at, this.damaged = false, this.shortage = false, this.photoPath});
  factory _ScanItem.fromJson(Map<String, dynamic> json) => _$ScanItemFromJson(json);

@override final  String code;
@override final  DateTime at;
@override@JsonKey() final  bool damaged;
@override@JsonKey() final  bool shortage;
@override final  String? photoPath;

/// Create a copy of ScanItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanItemCopyWith<_ScanItem> get copyWith => __$ScanItemCopyWithImpl<_ScanItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScanItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanItem&&(identical(other.code, code) || other.code == code)&&(identical(other.at, at) || other.at == at)&&(identical(other.damaged, damaged) || other.damaged == damaged)&&(identical(other.shortage, shortage) || other.shortage == shortage)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,at,damaged,shortage,photoPath);
}

@override
String toString() {
    return 'ScanItem(code: $code, at: $at, damaged: $damaged, shortage: $shortage, photoPath: $photoPath)';
}


}

/// @nodoc
abstract mixin class _$ScanItemCopyWith<$Res> implements $ScanItemCopyWith<$Res> {
  factory _$ScanItemCopyWith(_ScanItem value, $Res Function(_ScanItem) _then) = __$ScanItemCopyWithImpl;
@override @useResult
$Res call({
 String code, DateTime at, bool damaged, bool shortage, String? photoPath
});




}
/// @nodoc
class __$ScanItemCopyWithImpl<$Res>
    implements _$ScanItemCopyWith<$Res> {
  __$ScanItemCopyWithImpl(this._self, this._then);

  final _ScanItem _self;
  final $Res Function(_ScanItem) _then;

/// Create a copy of ScanItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? at = null,Object? damaged = null,Object? shortage = null,Object? photoPath = freezed,}) {
  return _then(_ScanItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,damaged: null == damaged ? _self.damaged : damaged // ignore: cast_nullable_to_non_nullable
as bool,shortage: null == shortage ? _self.shortage : shortage // ignore: cast_nullable_to_non_nullable
as bool,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Manifest {

 String get id; String get destHub; List<ScanItem> get items; DateTime get createdAt;
/// Create a copy of Manifest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManifestCopyWith<Manifest> get copyWith => _$ManifestCopyWithImpl<Manifest>(this as Manifest, _$identity);

  /// Serializes this Manifest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Manifest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Manifest&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.destHub, _this.destHub) || other.destHub == _this.destHub)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Manifest;
  return Object.hash(runtimeType,_this.id,_this.destHub,const DeepCollectionEquality().hash(_this.items),_this.createdAt);
}

@override
String toString() {
  final _this = this as Manifest;
  return 'Manifest(id: ${_this.id}, destHub: ${_this.destHub}, items: ${_this.items}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $ManifestCopyWith<$Res>  {
  factory $ManifestCopyWith(Manifest value, $Res Function(Manifest) _then) = _$ManifestCopyWithImpl;
@useResult
$Res call({
 String id, String destHub, List<ScanItem> items, DateTime createdAt
});




}
/// @nodoc
class _$ManifestCopyWithImpl<$Res>
    implements $ManifestCopyWith<$Res> {
  _$ManifestCopyWithImpl(this._self, this._then);

  final Manifest _self;
  final $Res Function(Manifest) _then;

/// Create a copy of Manifest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? destHub = null,Object? items = null,Object? createdAt = null,}) {
  return _then(Manifest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,destHub: null == destHub ? _self.destHub : destHub // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ScanItem>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Manifest].
extension ManifestPatterns on Manifest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Manifest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Manifest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Manifest value)  $default,){
final _that = this;
switch (_that) {
case _Manifest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Manifest value)?  $default,){
final _that = this;
switch (_that) {
case _Manifest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String destHub,  List<ScanItem> items,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Manifest() when $default != null:
return $default(_that.id,_that.destHub,_that.items,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String destHub,  List<ScanItem> items,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Manifest():
return $default(_that.id,_that.destHub,_that.items,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String destHub,  List<ScanItem> items,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Manifest() when $default != null:
return $default(_that.id,_that.destHub,_that.items,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Manifest implements Manifest {
  const _Manifest({required this.id, required this.destHub,  List<ScanItem> items = const [], required this.createdAt}): _items = items;
  factory _Manifest.fromJson(Map<String, dynamic> json) => _$ManifestFromJson(json);

@override final  String id;
@override final  String destHub;
 final  List<ScanItem> _items;
@override@JsonKey() List<ScanItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  DateTime createdAt;

/// Create a copy of Manifest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ManifestCopyWith<_Manifest> get copyWith => __$ManifestCopyWithImpl<_Manifest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ManifestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Manifest&&(identical(other.id, id) || other.id == id)&&(identical(other.destHub, destHub) || other.destHub == destHub)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,destHub,const DeepCollectionEquality().hash(_items),createdAt);
}

@override
String toString() {
    return 'Manifest(id: $id, destHub: $destHub, items: $items, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ManifestCopyWith<$Res> implements $ManifestCopyWith<$Res> {
  factory _$ManifestCopyWith(_Manifest value, $Res Function(_Manifest) _then) = __$ManifestCopyWithImpl;
@override @useResult
$Res call({
 String id, String destHub, List<ScanItem> items, DateTime createdAt
});




}
/// @nodoc
class __$ManifestCopyWithImpl<$Res>
    implements _$ManifestCopyWith<$Res> {
  __$ManifestCopyWithImpl(this._self, this._then);

  final _Manifest _self;
  final $Res Function(_Manifest) _then;

/// Create a copy of Manifest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? destHub = null,Object? items = null,Object? createdAt = null,}) {
  return _then(_Manifest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,destHub: null == destHub ? _self.destHub : destHub // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ScanItem>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
