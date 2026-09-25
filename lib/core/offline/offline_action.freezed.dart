// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offline_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OfflineAction {

 String get id; String get type; String? get tripId; Map<String, dynamic> get payload; List<String> get attachments; DateTime get createdAt; int get retryCount; OfflineActionStatus get status; String? get failureReason;
/// Create a copy of OfflineAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfflineActionCopyWith<OfflineAction> get copyWith => _$OfflineActionCopyWithImpl<OfflineAction>(this as OfflineAction, _$identity);

  /// Serializes this OfflineAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OfflineAction;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OfflineAction&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&const DeepCollectionEquality().equals(other.payload, _this.payload)&&const DeepCollectionEquality().equals(other.attachments, _this.attachments)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.retryCount, _this.retryCount) || other.retryCount == _this.retryCount)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.failureReason, _this.failureReason) || other.failureReason == _this.failureReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OfflineAction;
  return Object.hash(runtimeType,_this.id,_this.type,_this.tripId,const DeepCollectionEquality().hash(_this.payload),const DeepCollectionEquality().hash(_this.attachments),_this.createdAt,_this.retryCount,_this.status,_this.failureReason);
}

@override
String toString() {
  final _this = this as OfflineAction;
  return 'OfflineAction(id: ${_this.id}, type: ${_this.type}, tripId: ${_this.tripId}, payload: ${_this.payload}, attachments: ${_this.attachments}, createdAt: ${_this.createdAt}, retryCount: ${_this.retryCount}, status: ${_this.status}, failureReason: ${_this.failureReason})';
}


}

/// @nodoc
abstract mixin class $OfflineActionCopyWith<$Res>  {
  factory $OfflineActionCopyWith(OfflineAction value, $Res Function(OfflineAction) _then) = _$OfflineActionCopyWithImpl;
@useResult
$Res call({
 String id, String type, String? tripId, Map<String, dynamic> payload, List<String> attachments, DateTime createdAt, int retryCount, OfflineActionStatus status, String? failureReason
});




}
/// @nodoc
class _$OfflineActionCopyWithImpl<$Res>
    implements $OfflineActionCopyWith<$Res> {
  _$OfflineActionCopyWithImpl(this._self, this._then);

  final OfflineAction _self;
  final $Res Function(OfflineAction) _then;

/// Create a copy of OfflineAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? tripId = freezed,Object? payload = null,Object? attachments = null,Object? createdAt = null,Object? retryCount = null,Object? status = null,Object? failureReason = freezed,}) {
  return _then(OfflineAction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String?,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,attachments: null == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,retryCount: null == retryCount ? _self.retryCount : retryCount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OfflineActionStatus,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OfflineAction].
extension OfflineActionPatterns on OfflineAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OfflineAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OfflineAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OfflineAction value)  $default,){
final _that = this;
switch (_that) {
case _OfflineAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OfflineAction value)?  $default,){
final _that = this;
switch (_that) {
case _OfflineAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String? tripId,  Map<String, dynamic> payload,  List<String> attachments,  DateTime createdAt,  int retryCount,  OfflineActionStatus status,  String? failureReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OfflineAction() when $default != null:
return $default(_that.id,_that.type,_that.tripId,_that.payload,_that.attachments,_that.createdAt,_that.retryCount,_that.status,_that.failureReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String? tripId,  Map<String, dynamic> payload,  List<String> attachments,  DateTime createdAt,  int retryCount,  OfflineActionStatus status,  String? failureReason)  $default,) {final _that = this;
switch (_that) {
case _OfflineAction():
return $default(_that.id,_that.type,_that.tripId,_that.payload,_that.attachments,_that.createdAt,_that.retryCount,_that.status,_that.failureReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String? tripId,  Map<String, dynamic> payload,  List<String> attachments,  DateTime createdAt,  int retryCount,  OfflineActionStatus status,  String? failureReason)?  $default,) {final _that = this;
switch (_that) {
case _OfflineAction() when $default != null:
return $default(_that.id,_that.type,_that.tripId,_that.payload,_that.attachments,_that.createdAt,_that.retryCount,_that.status,_that.failureReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OfflineAction implements OfflineAction {
  const _OfflineAction({required this.id, required this.type, this.tripId, required  Map<String, dynamic> payload,  List<String> attachments = const [], required this.createdAt, this.retryCount = 0, this.status = OfflineActionStatus.pending, this.failureReason}): _payload = payload,_attachments = attachments;
  factory _OfflineAction.fromJson(Map<String, dynamic> json) => _$OfflineActionFromJson(json);

@override final  String id;
@override final  String type;
@override final  String? tripId;
 final  Map<String, dynamic> _payload;
@override Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}

 final  List<String> _attachments;
@override@JsonKey() List<String> get attachments {
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachments);
}

@override final  DateTime createdAt;
@override@JsonKey() final  int retryCount;
@override@JsonKey() final  OfflineActionStatus status;
@override final  String? failureReason;

/// Create a copy of OfflineAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OfflineActionCopyWith<_OfflineAction> get copyWith => __$OfflineActionCopyWithImpl<_OfflineAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OfflineActionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OfflineAction&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&const DeepCollectionEquality().equals(other.payload, _payload)&&const DeepCollectionEquality().equals(other.attachments, _attachments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.retryCount, retryCount) || other.retryCount == retryCount)&&(identical(other.status, status) || other.status == status)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,type,tripId,const DeepCollectionEquality().hash(_payload),const DeepCollectionEquality().hash(_attachments),createdAt,retryCount,status,failureReason);
}

@override
String toString() {
    return 'OfflineAction(id: $id, type: $type, tripId: $tripId, payload: $payload, attachments: $attachments, createdAt: $createdAt, retryCount: $retryCount, status: $status, failureReason: $failureReason)';
}


}

/// @nodoc
abstract mixin class _$OfflineActionCopyWith<$Res> implements $OfflineActionCopyWith<$Res> {
  factory _$OfflineActionCopyWith(_OfflineAction value, $Res Function(_OfflineAction) _then) = __$OfflineActionCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String? tripId, Map<String, dynamic> payload, List<String> attachments, DateTime createdAt, int retryCount, OfflineActionStatus status, String? failureReason
});




}
/// @nodoc
class __$OfflineActionCopyWithImpl<$Res>
    implements _$OfflineActionCopyWith<$Res> {
  __$OfflineActionCopyWithImpl(this._self, this._then);

  final _OfflineAction _self;
  final $Res Function(_OfflineAction) _then;

/// Create a copy of OfflineAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? tripId = freezed,Object? payload = null,Object? attachments = null,Object? createdAt = null,Object? retryCount = null,Object? status = null,Object? failureReason = freezed,}) {
  return _then(_OfflineAction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String?,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,retryCount: null == retryCount ? _self.retryCount : retryCount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OfflineActionStatus,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
