// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Expense {

 String get id; String get tripId; ExpenseType get type; int get amount; double? get litres; double? get rate; String? get photoPath; String? get note; String? get voiceNotePath; ExpenseStatus get status; bool get normFlag; DateTime get createdAt;
/// Create a copy of Expense
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseCopyWith<Expense> get copyWith => _$ExpenseCopyWithImpl<Expense>(this as Expense, _$identity);

  /// Serializes this Expense to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Expense;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Expense&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.litres, _this.litres) || other.litres == _this.litres)&&(identical(other.rate, _this.rate) || other.rate == _this.rate)&&(identical(other.photoPath, _this.photoPath) || other.photoPath == _this.photoPath)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.voiceNotePath, _this.voiceNotePath) || other.voiceNotePath == _this.voiceNotePath)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.normFlag, _this.normFlag) || other.normFlag == _this.normFlag)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Expense;
  return Object.hash(runtimeType,_this.id,_this.tripId,_this.type,_this.amount,_this.litres,_this.rate,_this.photoPath,_this.note,_this.voiceNotePath,_this.status,_this.normFlag,_this.createdAt);
}

@override
String toString() {
  final _this = this as Expense;
  return 'Expense(id: ${_this.id}, tripId: ${_this.tripId}, type: ${_this.type}, amount: ${_this.amount}, litres: ${_this.litres}, rate: ${_this.rate}, photoPath: ${_this.photoPath}, note: ${_this.note}, voiceNotePath: ${_this.voiceNotePath}, status: ${_this.status}, normFlag: ${_this.normFlag}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $ExpenseCopyWith<$Res>  {
  factory $ExpenseCopyWith(Expense value, $Res Function(Expense) _then) = _$ExpenseCopyWithImpl;
@useResult
$Res call({
 String id, String tripId, ExpenseType type, int amount, double? litres, double? rate, String? photoPath, String? note, String? voiceNotePath, ExpenseStatus status, bool normFlag, DateTime createdAt
});




}
/// @nodoc
class _$ExpenseCopyWithImpl<$Res>
    implements $ExpenseCopyWith<$Res> {
  _$ExpenseCopyWithImpl(this._self, this._then);

  final Expense _self;
  final $Res Function(Expense) _then;

/// Create a copy of Expense
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tripId = null,Object? type = null,Object? amount = null,Object? litres = freezed,Object? rate = freezed,Object? photoPath = freezed,Object? note = freezed,Object? voiceNotePath = freezed,Object? status = null,Object? normFlag = null,Object? createdAt = null,}) {
  return _then(Expense(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ExpenseType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,litres: freezed == litres ? _self.litres : litres // ignore: cast_nullable_to_non_nullable
as double?,rate: freezed == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double?,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,voiceNotePath: freezed == voiceNotePath ? _self.voiceNotePath : voiceNotePath // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ExpenseStatus,normFlag: null == normFlag ? _self.normFlag : normFlag // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Expense].
extension ExpensePatterns on Expense {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Expense value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Expense() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Expense value)  $default,){
final _that = this;
switch (_that) {
case _Expense():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Expense value)?  $default,){
final _that = this;
switch (_that) {
case _Expense() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tripId,  ExpenseType type,  int amount,  double? litres,  double? rate,  String? photoPath,  String? note,  String? voiceNotePath,  ExpenseStatus status,  bool normFlag,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Expense() when $default != null:
return $default(_that.id,_that.tripId,_that.type,_that.amount,_that.litres,_that.rate,_that.photoPath,_that.note,_that.voiceNotePath,_that.status,_that.normFlag,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tripId,  ExpenseType type,  int amount,  double? litres,  double? rate,  String? photoPath,  String? note,  String? voiceNotePath,  ExpenseStatus status,  bool normFlag,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Expense():
return $default(_that.id,_that.tripId,_that.type,_that.amount,_that.litres,_that.rate,_that.photoPath,_that.note,_that.voiceNotePath,_that.status,_that.normFlag,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tripId,  ExpenseType type,  int amount,  double? litres,  double? rate,  String? photoPath,  String? note,  String? voiceNotePath,  ExpenseStatus status,  bool normFlag,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Expense() when $default != null:
return $default(_that.id,_that.tripId,_that.type,_that.amount,_that.litres,_that.rate,_that.photoPath,_that.note,_that.voiceNotePath,_that.status,_that.normFlag,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Expense implements Expense {
  const _Expense({required this.id, required this.tripId, required this.type, required this.amount, this.litres, this.rate, this.photoPath, this.note, this.voiceNotePath, this.status = ExpenseStatus.queued, this.normFlag = false, required this.createdAt});
  factory _Expense.fromJson(Map<String, dynamic> json) => _$ExpenseFromJson(json);

@override final  String id;
@override final  String tripId;
@override final  ExpenseType type;
@override final  int amount;
@override final  double? litres;
@override final  double? rate;
@override final  String? photoPath;
@override final  String? note;
@override final  String? voiceNotePath;
@override@JsonKey() final  ExpenseStatus status;
@override@JsonKey() final  bool normFlag;
@override final  DateTime createdAt;

/// Create a copy of Expense
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseCopyWith<_Expense> get copyWith => __$ExpenseCopyWithImpl<_Expense>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Expense&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.litres, litres) || other.litres == litres)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.note, note) || other.note == note)&&(identical(other.voiceNotePath, voiceNotePath) || other.voiceNotePath == voiceNotePath)&&(identical(other.status, status) || other.status == status)&&(identical(other.normFlag, normFlag) || other.normFlag == normFlag)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,tripId,type,amount,litres,rate,photoPath,note,voiceNotePath,status,normFlag,createdAt);
}

@override
String toString() {
    return 'Expense(id: $id, tripId: $tripId, type: $type, amount: $amount, litres: $litres, rate: $rate, photoPath: $photoPath, note: $note, voiceNotePath: $voiceNotePath, status: $status, normFlag: $normFlag, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ExpenseCopyWith<$Res> implements $ExpenseCopyWith<$Res> {
  factory _$ExpenseCopyWith(_Expense value, $Res Function(_Expense) _then) = __$ExpenseCopyWithImpl;
@override @useResult
$Res call({
 String id, String tripId, ExpenseType type, int amount, double? litres, double? rate, String? photoPath, String? note, String? voiceNotePath, ExpenseStatus status, bool normFlag, DateTime createdAt
});




}
/// @nodoc
class __$ExpenseCopyWithImpl<$Res>
    implements _$ExpenseCopyWith<$Res> {
  __$ExpenseCopyWithImpl(this._self, this._then);

  final _Expense _self;
  final $Res Function(_Expense) _then;

/// Create a copy of Expense
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tripId = null,Object? type = null,Object? amount = null,Object? litres = freezed,Object? rate = freezed,Object? photoPath = freezed,Object? note = freezed,Object? voiceNotePath = freezed,Object? status = null,Object? normFlag = null,Object? createdAt = null,}) {
  return _then(_Expense(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ExpenseType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,litres: freezed == litres ? _self.litres : litres // ignore: cast_nullable_to_non_nullable
as double?,rate: freezed == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double?,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,voiceNotePath: freezed == voiceNotePath ? _self.voiceNotePath : voiceNotePath // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ExpenseStatus,normFlag: null == normFlag ? _self.normFlag : normFlag // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
