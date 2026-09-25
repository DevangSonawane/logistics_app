// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approval.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApprovalItem {

 String get id; ApprovalType get type; String get requester; int get amount; String get reason; String? get riskFlag; List<String> get attachments; ApprovalStatus get status; String? get comment; DateTime get createdAt;
/// Create a copy of ApprovalItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApprovalItemCopyWith<ApprovalItem> get copyWith => _$ApprovalItemCopyWithImpl<ApprovalItem>(this as ApprovalItem, _$identity);

  /// Serializes this ApprovalItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ApprovalItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApprovalItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.requester, _this.requester) || other.requester == _this.requester)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.reason, _this.reason) || other.reason == _this.reason)&&(identical(other.riskFlag, _this.riskFlag) || other.riskFlag == _this.riskFlag)&&const DeepCollectionEquality().equals(other.attachments, _this.attachments)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.comment, _this.comment) || other.comment == _this.comment)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ApprovalItem;
  return Object.hash(runtimeType,_this.id,_this.type,_this.requester,_this.amount,_this.reason,_this.riskFlag,const DeepCollectionEquality().hash(_this.attachments),_this.status,_this.comment,_this.createdAt);
}

@override
String toString() {
  final _this = this as ApprovalItem;
  return 'ApprovalItem(id: ${_this.id}, type: ${_this.type}, requester: ${_this.requester}, amount: ${_this.amount}, reason: ${_this.reason}, riskFlag: ${_this.riskFlag}, attachments: ${_this.attachments}, status: ${_this.status}, comment: ${_this.comment}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $ApprovalItemCopyWith<$Res>  {
  factory $ApprovalItemCopyWith(ApprovalItem value, $Res Function(ApprovalItem) _then) = _$ApprovalItemCopyWithImpl;
@useResult
$Res call({
 String id, ApprovalType type, String requester, int amount, String reason, String? riskFlag, List<String> attachments, ApprovalStatus status, String? comment, DateTime createdAt
});




}
/// @nodoc
class _$ApprovalItemCopyWithImpl<$Res>
    implements $ApprovalItemCopyWith<$Res> {
  _$ApprovalItemCopyWithImpl(this._self, this._then);

  final ApprovalItem _self;
  final $Res Function(ApprovalItem) _then;

/// Create a copy of ApprovalItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? requester = null,Object? amount = null,Object? reason = null,Object? riskFlag = freezed,Object? attachments = null,Object? status = null,Object? comment = freezed,Object? createdAt = null,}) {
  return _then(ApprovalItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ApprovalType,requester: null == requester ? _self.requester : requester // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,riskFlag: freezed == riskFlag ? _self.riskFlag : riskFlag // ignore: cast_nullable_to_non_nullable
as String?,attachments: null == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApprovalStatus,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ApprovalItem].
extension ApprovalItemPatterns on ApprovalItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApprovalItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApprovalItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApprovalItem value)  $default,){
final _that = this;
switch (_that) {
case _ApprovalItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApprovalItem value)?  $default,){
final _that = this;
switch (_that) {
case _ApprovalItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ApprovalType type,  String requester,  int amount,  String reason,  String? riskFlag,  List<String> attachments,  ApprovalStatus status,  String? comment,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApprovalItem() when $default != null:
return $default(_that.id,_that.type,_that.requester,_that.amount,_that.reason,_that.riskFlag,_that.attachments,_that.status,_that.comment,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ApprovalType type,  String requester,  int amount,  String reason,  String? riskFlag,  List<String> attachments,  ApprovalStatus status,  String? comment,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _ApprovalItem():
return $default(_that.id,_that.type,_that.requester,_that.amount,_that.reason,_that.riskFlag,_that.attachments,_that.status,_that.comment,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ApprovalType type,  String requester,  int amount,  String reason,  String? riskFlag,  List<String> attachments,  ApprovalStatus status,  String? comment,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ApprovalItem() when $default != null:
return $default(_that.id,_that.type,_that.requester,_that.amount,_that.reason,_that.riskFlag,_that.attachments,_that.status,_that.comment,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApprovalItem implements ApprovalItem {
  const _ApprovalItem({required this.id, required this.type, required this.requester, required this.amount, required this.reason, this.riskFlag,  List<String> attachments = const [], this.status = ApprovalStatus.pending, this.comment, required this.createdAt}): _attachments = attachments;
  factory _ApprovalItem.fromJson(Map<String, dynamic> json) => _$ApprovalItemFromJson(json);

@override final  String id;
@override final  ApprovalType type;
@override final  String requester;
@override final  int amount;
@override final  String reason;
@override final  String? riskFlag;
 final  List<String> _attachments;
@override@JsonKey() List<String> get attachments {
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachments);
}

@override@JsonKey() final  ApprovalStatus status;
@override final  String? comment;
@override final  DateTime createdAt;

/// Create a copy of ApprovalItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApprovalItemCopyWith<_ApprovalItem> get copyWith => __$ApprovalItemCopyWithImpl<_ApprovalItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApprovalItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApprovalItem&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.requester, requester) || other.requester == requester)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.riskFlag, riskFlag) || other.riskFlag == riskFlag)&&const DeepCollectionEquality().equals(other.attachments, _attachments)&&(identical(other.status, status) || other.status == status)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,type,requester,amount,reason,riskFlag,const DeepCollectionEquality().hash(_attachments),status,comment,createdAt);
}

@override
String toString() {
    return 'ApprovalItem(id: $id, type: $type, requester: $requester, amount: $amount, reason: $reason, riskFlag: $riskFlag, attachments: $attachments, status: $status, comment: $comment, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ApprovalItemCopyWith<$Res> implements $ApprovalItemCopyWith<$Res> {
  factory _$ApprovalItemCopyWith(_ApprovalItem value, $Res Function(_ApprovalItem) _then) = __$ApprovalItemCopyWithImpl;
@override @useResult
$Res call({
 String id, ApprovalType type, String requester, int amount, String reason, String? riskFlag, List<String> attachments, ApprovalStatus status, String? comment, DateTime createdAt
});




}
/// @nodoc
class __$ApprovalItemCopyWithImpl<$Res>
    implements _$ApprovalItemCopyWith<$Res> {
  __$ApprovalItemCopyWithImpl(this._self, this._then);

  final _ApprovalItem _self;
  final $Res Function(_ApprovalItem) _then;

/// Create a copy of ApprovalItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? requester = null,Object? amount = null,Object? reason = null,Object? riskFlag = freezed,Object? attachments = null,Object? status = null,Object? comment = freezed,Object? createdAt = null,}) {
  return _then(_ApprovalItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ApprovalType,requester: null == requester ? _self.requester : requester // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,riskFlag: freezed == riskFlag ? _self.riskFlag : riskFlag // ignore: cast_nullable_to_non_nullable
as String?,attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApprovalStatus,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
