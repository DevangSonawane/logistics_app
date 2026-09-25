// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripStep {

 TripStepType get type; DateTime get at; double get lat; double get lng; String? get photoPath; String? get note;
/// Create a copy of TripStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripStepCopyWith<TripStep> get copyWith => _$TripStepCopyWithImpl<TripStep>(this as TripStep, _$identity);

  /// Serializes this TripStep to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripStep;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripStep&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.at, _this.at) || other.at == _this.at)&&(identical(other.lat, _this.lat) || other.lat == _this.lat)&&(identical(other.lng, _this.lng) || other.lng == _this.lng)&&(identical(other.photoPath, _this.photoPath) || other.photoPath == _this.photoPath)&&(identical(other.note, _this.note) || other.note == _this.note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripStep;
  return Object.hash(runtimeType,_this.type,_this.at,_this.lat,_this.lng,_this.photoPath,_this.note);
}

@override
String toString() {
  final _this = this as TripStep;
  return 'TripStep(type: ${_this.type}, at: ${_this.at}, lat: ${_this.lat}, lng: ${_this.lng}, photoPath: ${_this.photoPath}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $TripStepCopyWith<$Res>  {
  factory $TripStepCopyWith(TripStep value, $Res Function(TripStep) _then) = _$TripStepCopyWithImpl;
@useResult
$Res call({
 TripStepType type, DateTime at, double lat, double lng, String? photoPath, String? note
});




}
/// @nodoc
class _$TripStepCopyWithImpl<$Res>
    implements $TripStepCopyWith<$Res> {
  _$TripStepCopyWithImpl(this._self, this._then);

  final TripStep _self;
  final $Res Function(TripStep) _then;

/// Create a copy of TripStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? at = null,Object? lat = null,Object? lng = null,Object? photoPath = freezed,Object? note = freezed,}) {
  return _then(TripStep(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TripStepType,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripStep].
extension TripStepPatterns on TripStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripStep value)  $default,){
final _that = this;
switch (_that) {
case _TripStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripStep value)?  $default,){
final _that = this;
switch (_that) {
case _TripStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TripStepType type,  DateTime at,  double lat,  double lng,  String? photoPath,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripStep() when $default != null:
return $default(_that.type,_that.at,_that.lat,_that.lng,_that.photoPath,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TripStepType type,  DateTime at,  double lat,  double lng,  String? photoPath,  String? note)  $default,) {final _that = this;
switch (_that) {
case _TripStep():
return $default(_that.type,_that.at,_that.lat,_that.lng,_that.photoPath,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TripStepType type,  DateTime at,  double lat,  double lng,  String? photoPath,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _TripStep() when $default != null:
return $default(_that.type,_that.at,_that.lat,_that.lng,_that.photoPath,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripStep implements TripStep {
  const _TripStep({required this.type, required this.at, required this.lat, required this.lng, this.photoPath, this.note});
  factory _TripStep.fromJson(Map<String, dynamic> json) => _$TripStepFromJson(json);

@override final  TripStepType type;
@override final  DateTime at;
@override final  double lat;
@override final  double lng;
@override final  String? photoPath;
@override final  String? note;

/// Create a copy of TripStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripStepCopyWith<_TripStep> get copyWith => __$TripStepCopyWithImpl<_TripStep>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripStepToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripStep&&(identical(other.type, type) || other.type == type)&&(identical(other.at, at) || other.at == at)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,type,at,lat,lng,photoPath,note);
}

@override
String toString() {
    return 'TripStep(type: $type, at: $at, lat: $lat, lng: $lng, photoPath: $photoPath, note: $note)';
}


}

/// @nodoc
abstract mixin class _$TripStepCopyWith<$Res> implements $TripStepCopyWith<$Res> {
  factory _$TripStepCopyWith(_TripStep value, $Res Function(_TripStep) _then) = __$TripStepCopyWithImpl;
@override @useResult
$Res call({
 TripStepType type, DateTime at, double lat, double lng, String? photoPath, String? note
});




}
/// @nodoc
class __$TripStepCopyWithImpl<$Res>
    implements _$TripStepCopyWith<$Res> {
  __$TripStepCopyWithImpl(this._self, this._then);

  final _TripStep _self;
  final $Res Function(_TripStep) _then;

/// Create a copy of TripStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? at = null,Object? lat = null,Object? lng = null,Object? photoPath = freezed,Object? note = freezed,}) {
  return _then(_TripStep(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TripStepType,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Trip {

 String get id; String get no; String get orderId; String get customer; String get pickupAddress; String get pickupContact; String get pickupPhone; double get pickupLat; double get pickupLng; String get dropAddress; String get dropContact; String get dropPhone; double get dropLat; double get dropLng; double get distanceKm; int get freightAllowance; DateTime get pickupBy; String get vehicleReg; String get driverId; TripStatus get status; DateTime? get plannedEta; DateTime? get liveEta; List<TripStep> get steps; String? get lrNo; String? get ewayBillNo; PodStatus get podStatus; int get advanceGiven; String? get rejectReason;
/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripCopyWith<Trip> get copyWith => _$TripCopyWithImpl<Trip>(this as Trip, _$identity);

  /// Serializes this Trip to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Trip;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Trip&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.no, _this.no) || other.no == _this.no)&&(identical(other.orderId, _this.orderId) || other.orderId == _this.orderId)&&(identical(other.customer, _this.customer) || other.customer == _this.customer)&&(identical(other.pickupAddress, _this.pickupAddress) || other.pickupAddress == _this.pickupAddress)&&(identical(other.pickupContact, _this.pickupContact) || other.pickupContact == _this.pickupContact)&&(identical(other.pickupPhone, _this.pickupPhone) || other.pickupPhone == _this.pickupPhone)&&(identical(other.pickupLat, _this.pickupLat) || other.pickupLat == _this.pickupLat)&&(identical(other.pickupLng, _this.pickupLng) || other.pickupLng == _this.pickupLng)&&(identical(other.dropAddress, _this.dropAddress) || other.dropAddress == _this.dropAddress)&&(identical(other.dropContact, _this.dropContact) || other.dropContact == _this.dropContact)&&(identical(other.dropPhone, _this.dropPhone) || other.dropPhone == _this.dropPhone)&&(identical(other.dropLat, _this.dropLat) || other.dropLat == _this.dropLat)&&(identical(other.dropLng, _this.dropLng) || other.dropLng == _this.dropLng)&&(identical(other.distanceKm, _this.distanceKm) || other.distanceKm == _this.distanceKm)&&(identical(other.freightAllowance, _this.freightAllowance) || other.freightAllowance == _this.freightAllowance)&&(identical(other.pickupBy, _this.pickupBy) || other.pickupBy == _this.pickupBy)&&(identical(other.vehicleReg, _this.vehicleReg) || other.vehicleReg == _this.vehicleReg)&&(identical(other.driverId, _this.driverId) || other.driverId == _this.driverId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.plannedEta, _this.plannedEta) || other.plannedEta == _this.plannedEta)&&(identical(other.liveEta, _this.liveEta) || other.liveEta == _this.liveEta)&&const DeepCollectionEquality().equals(other.steps, _this.steps)&&(identical(other.lrNo, _this.lrNo) || other.lrNo == _this.lrNo)&&(identical(other.ewayBillNo, _this.ewayBillNo) || other.ewayBillNo == _this.ewayBillNo)&&(identical(other.podStatus, _this.podStatus) || other.podStatus == _this.podStatus)&&(identical(other.advanceGiven, _this.advanceGiven) || other.advanceGiven == _this.advanceGiven)&&(identical(other.rejectReason, _this.rejectReason) || other.rejectReason == _this.rejectReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Trip;
  return Object.hashAll([runtimeType,_this.id,_this.no,_this.orderId,_this.customer,_this.pickupAddress,_this.pickupContact,_this.pickupPhone,_this.pickupLat,_this.pickupLng,_this.dropAddress,_this.dropContact,_this.dropPhone,_this.dropLat,_this.dropLng,_this.distanceKm,_this.freightAllowance,_this.pickupBy,_this.vehicleReg,_this.driverId,_this.status,_this.plannedEta,_this.liveEta,const DeepCollectionEquality().hash(_this.steps),_this.lrNo,_this.ewayBillNo,_this.podStatus,_this.advanceGiven,_this.rejectReason]);
}

@override
String toString() {
  final _this = this as Trip;
  return 'Trip(id: ${_this.id}, no: ${_this.no}, orderId: ${_this.orderId}, customer: ${_this.customer}, pickupAddress: ${_this.pickupAddress}, pickupContact: ${_this.pickupContact}, pickupPhone: ${_this.pickupPhone}, pickupLat: ${_this.pickupLat}, pickupLng: ${_this.pickupLng}, dropAddress: ${_this.dropAddress}, dropContact: ${_this.dropContact}, dropPhone: ${_this.dropPhone}, dropLat: ${_this.dropLat}, dropLng: ${_this.dropLng}, distanceKm: ${_this.distanceKm}, freightAllowance: ${_this.freightAllowance}, pickupBy: ${_this.pickupBy}, vehicleReg: ${_this.vehicleReg}, driverId: ${_this.driverId}, status: ${_this.status}, plannedEta: ${_this.plannedEta}, liveEta: ${_this.liveEta}, steps: ${_this.steps}, lrNo: ${_this.lrNo}, ewayBillNo: ${_this.ewayBillNo}, podStatus: ${_this.podStatus}, advanceGiven: ${_this.advanceGiven}, rejectReason: ${_this.rejectReason})';
}


}

/// @nodoc
abstract mixin class $TripCopyWith<$Res>  {
  factory $TripCopyWith(Trip value, $Res Function(Trip) _then) = _$TripCopyWithImpl;
@useResult
$Res call({
 String id, String no, String orderId, String customer, String pickupAddress, String pickupContact, String pickupPhone, double pickupLat, double pickupLng, String dropAddress, String dropContact, String dropPhone, double dropLat, double dropLng, double distanceKm, int freightAllowance, DateTime pickupBy, String vehicleReg, String driverId, TripStatus status, DateTime? plannedEta, DateTime? liveEta, List<TripStep> steps, String? lrNo, String? ewayBillNo, PodStatus podStatus, int advanceGiven, String? rejectReason
});




}
/// @nodoc
class _$TripCopyWithImpl<$Res>
    implements $TripCopyWith<$Res> {
  _$TripCopyWithImpl(this._self, this._then);

  final Trip _self;
  final $Res Function(Trip) _then;

/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? no = null,Object? orderId = null,Object? customer = null,Object? pickupAddress = null,Object? pickupContact = null,Object? pickupPhone = null,Object? pickupLat = null,Object? pickupLng = null,Object? dropAddress = null,Object? dropContact = null,Object? dropPhone = null,Object? dropLat = null,Object? dropLng = null,Object? distanceKm = null,Object? freightAllowance = null,Object? pickupBy = null,Object? vehicleReg = null,Object? driverId = null,Object? status = null,Object? plannedEta = freezed,Object? liveEta = freezed,Object? steps = null,Object? lrNo = freezed,Object? ewayBillNo = freezed,Object? podStatus = null,Object? advanceGiven = null,Object? rejectReason = freezed,}) {
  return _then(Trip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,no: null == no ? _self.no : no // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,customer: null == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as String,pickupAddress: null == pickupAddress ? _self.pickupAddress : pickupAddress // ignore: cast_nullable_to_non_nullable
as String,pickupContact: null == pickupContact ? _self.pickupContact : pickupContact // ignore: cast_nullable_to_non_nullable
as String,pickupPhone: null == pickupPhone ? _self.pickupPhone : pickupPhone // ignore: cast_nullable_to_non_nullable
as String,pickupLat: null == pickupLat ? _self.pickupLat : pickupLat // ignore: cast_nullable_to_non_nullable
as double,pickupLng: null == pickupLng ? _self.pickupLng : pickupLng // ignore: cast_nullable_to_non_nullable
as double,dropAddress: null == dropAddress ? _self.dropAddress : dropAddress // ignore: cast_nullable_to_non_nullable
as String,dropContact: null == dropContact ? _self.dropContact : dropContact // ignore: cast_nullable_to_non_nullable
as String,dropPhone: null == dropPhone ? _self.dropPhone : dropPhone // ignore: cast_nullable_to_non_nullable
as String,dropLat: null == dropLat ? _self.dropLat : dropLat // ignore: cast_nullable_to_non_nullable
as double,dropLng: null == dropLng ? _self.dropLng : dropLng // ignore: cast_nullable_to_non_nullable
as double,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,freightAllowance: null == freightAllowance ? _self.freightAllowance : freightAllowance // ignore: cast_nullable_to_non_nullable
as int,pickupBy: null == pickupBy ? _self.pickupBy : pickupBy // ignore: cast_nullable_to_non_nullable
as DateTime,vehicleReg: null == vehicleReg ? _self.vehicleReg : vehicleReg // ignore: cast_nullable_to_non_nullable
as String,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripStatus,plannedEta: freezed == plannedEta ? _self.plannedEta : plannedEta // ignore: cast_nullable_to_non_nullable
as DateTime?,liveEta: freezed == liveEta ? _self.liveEta : liveEta // ignore: cast_nullable_to_non_nullable
as DateTime?,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<TripStep>,lrNo: freezed == lrNo ? _self.lrNo : lrNo // ignore: cast_nullable_to_non_nullable
as String?,ewayBillNo: freezed == ewayBillNo ? _self.ewayBillNo : ewayBillNo // ignore: cast_nullable_to_non_nullable
as String?,podStatus: null == podStatus ? _self.podStatus : podStatus // ignore: cast_nullable_to_non_nullable
as PodStatus,advanceGiven: null == advanceGiven ? _self.advanceGiven : advanceGiven // ignore: cast_nullable_to_non_nullable
as int,rejectReason: freezed == rejectReason ? _self.rejectReason : rejectReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Trip].
extension TripPatterns on Trip {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Trip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Trip() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Trip value)  $default,){
final _that = this;
switch (_that) {
case _Trip():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Trip value)?  $default,){
final _that = this;
switch (_that) {
case _Trip() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String no,  String orderId,  String customer,  String pickupAddress,  String pickupContact,  String pickupPhone,  double pickupLat,  double pickupLng,  String dropAddress,  String dropContact,  String dropPhone,  double dropLat,  double dropLng,  double distanceKm,  int freightAllowance,  DateTime pickupBy,  String vehicleReg,  String driverId,  TripStatus status,  DateTime? plannedEta,  DateTime? liveEta,  List<TripStep> steps,  String? lrNo,  String? ewayBillNo,  PodStatus podStatus,  int advanceGiven,  String? rejectReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Trip() when $default != null:
return $default(_that.id,_that.no,_that.orderId,_that.customer,_that.pickupAddress,_that.pickupContact,_that.pickupPhone,_that.pickupLat,_that.pickupLng,_that.dropAddress,_that.dropContact,_that.dropPhone,_that.dropLat,_that.dropLng,_that.distanceKm,_that.freightAllowance,_that.pickupBy,_that.vehicleReg,_that.driverId,_that.status,_that.plannedEta,_that.liveEta,_that.steps,_that.lrNo,_that.ewayBillNo,_that.podStatus,_that.advanceGiven,_that.rejectReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String no,  String orderId,  String customer,  String pickupAddress,  String pickupContact,  String pickupPhone,  double pickupLat,  double pickupLng,  String dropAddress,  String dropContact,  String dropPhone,  double dropLat,  double dropLng,  double distanceKm,  int freightAllowance,  DateTime pickupBy,  String vehicleReg,  String driverId,  TripStatus status,  DateTime? plannedEta,  DateTime? liveEta,  List<TripStep> steps,  String? lrNo,  String? ewayBillNo,  PodStatus podStatus,  int advanceGiven,  String? rejectReason)  $default,) {final _that = this;
switch (_that) {
case _Trip():
return $default(_that.id,_that.no,_that.orderId,_that.customer,_that.pickupAddress,_that.pickupContact,_that.pickupPhone,_that.pickupLat,_that.pickupLng,_that.dropAddress,_that.dropContact,_that.dropPhone,_that.dropLat,_that.dropLng,_that.distanceKm,_that.freightAllowance,_that.pickupBy,_that.vehicleReg,_that.driverId,_that.status,_that.plannedEta,_that.liveEta,_that.steps,_that.lrNo,_that.ewayBillNo,_that.podStatus,_that.advanceGiven,_that.rejectReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String no,  String orderId,  String customer,  String pickupAddress,  String pickupContact,  String pickupPhone,  double pickupLat,  double pickupLng,  String dropAddress,  String dropContact,  String dropPhone,  double dropLat,  double dropLng,  double distanceKm,  int freightAllowance,  DateTime pickupBy,  String vehicleReg,  String driverId,  TripStatus status,  DateTime? plannedEta,  DateTime? liveEta,  List<TripStep> steps,  String? lrNo,  String? ewayBillNo,  PodStatus podStatus,  int advanceGiven,  String? rejectReason)?  $default,) {final _that = this;
switch (_that) {
case _Trip() when $default != null:
return $default(_that.id,_that.no,_that.orderId,_that.customer,_that.pickupAddress,_that.pickupContact,_that.pickupPhone,_that.pickupLat,_that.pickupLng,_that.dropAddress,_that.dropContact,_that.dropPhone,_that.dropLat,_that.dropLng,_that.distanceKm,_that.freightAllowance,_that.pickupBy,_that.vehicleReg,_that.driverId,_that.status,_that.plannedEta,_that.liveEta,_that.steps,_that.lrNo,_that.ewayBillNo,_that.podStatus,_that.advanceGiven,_that.rejectReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Trip implements Trip {
  const _Trip({required this.id, required this.no, required this.orderId, required this.customer, required this.pickupAddress, required this.pickupContact, required this.pickupPhone, required this.pickupLat, required this.pickupLng, required this.dropAddress, required this.dropContact, required this.dropPhone, required this.dropLat, required this.dropLng, required this.distanceKm, required this.freightAllowance, required this.pickupBy, required this.vehicleReg, required this.driverId, required this.status, this.plannedEta, this.liveEta,  List<TripStep> steps = const [], this.lrNo, this.ewayBillNo, this.podStatus = PodStatus.pending, this.advanceGiven = 0, this.rejectReason}): _steps = steps;
  factory _Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);

@override final  String id;
@override final  String no;
@override final  String orderId;
@override final  String customer;
@override final  String pickupAddress;
@override final  String pickupContact;
@override final  String pickupPhone;
@override final  double pickupLat;
@override final  double pickupLng;
@override final  String dropAddress;
@override final  String dropContact;
@override final  String dropPhone;
@override final  double dropLat;
@override final  double dropLng;
@override final  double distanceKm;
@override final  int freightAllowance;
@override final  DateTime pickupBy;
@override final  String vehicleReg;
@override final  String driverId;
@override final  TripStatus status;
@override final  DateTime? plannedEta;
@override final  DateTime? liveEta;
 final  List<TripStep> _steps;
@override@JsonKey() List<TripStep> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

@override final  String? lrNo;
@override final  String? ewayBillNo;
@override@JsonKey() final  PodStatus podStatus;
@override@JsonKey() final  int advanceGiven;
@override final  String? rejectReason;

/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripCopyWith<_Trip> get copyWith => __$TripCopyWithImpl<_Trip>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Trip&&(identical(other.id, id) || other.id == id)&&(identical(other.no, no) || other.no == no)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.customer, customer) || other.customer == customer)&&(identical(other.pickupAddress, pickupAddress) || other.pickupAddress == pickupAddress)&&(identical(other.pickupContact, pickupContact) || other.pickupContact == pickupContact)&&(identical(other.pickupPhone, pickupPhone) || other.pickupPhone == pickupPhone)&&(identical(other.pickupLat, pickupLat) || other.pickupLat == pickupLat)&&(identical(other.pickupLng, pickupLng) || other.pickupLng == pickupLng)&&(identical(other.dropAddress, dropAddress) || other.dropAddress == dropAddress)&&(identical(other.dropContact, dropContact) || other.dropContact == dropContact)&&(identical(other.dropPhone, dropPhone) || other.dropPhone == dropPhone)&&(identical(other.dropLat, dropLat) || other.dropLat == dropLat)&&(identical(other.dropLng, dropLng) || other.dropLng == dropLng)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.freightAllowance, freightAllowance) || other.freightAllowance == freightAllowance)&&(identical(other.pickupBy, pickupBy) || other.pickupBy == pickupBy)&&(identical(other.vehicleReg, vehicleReg) || other.vehicleReg == vehicleReg)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.status, status) || other.status == status)&&(identical(other.plannedEta, plannedEta) || other.plannedEta == plannedEta)&&(identical(other.liveEta, liveEta) || other.liveEta == liveEta)&&const DeepCollectionEquality().equals(other.steps, _steps)&&(identical(other.lrNo, lrNo) || other.lrNo == lrNo)&&(identical(other.ewayBillNo, ewayBillNo) || other.ewayBillNo == ewayBillNo)&&(identical(other.podStatus, podStatus) || other.podStatus == podStatus)&&(identical(other.advanceGiven, advanceGiven) || other.advanceGiven == advanceGiven)&&(identical(other.rejectReason, rejectReason) || other.rejectReason == rejectReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,no,orderId,customer,pickupAddress,pickupContact,pickupPhone,pickupLat,pickupLng,dropAddress,dropContact,dropPhone,dropLat,dropLng,distanceKm,freightAllowance,pickupBy,vehicleReg,driverId,status,plannedEta,liveEta,const DeepCollectionEquality().hash(_steps),lrNo,ewayBillNo,podStatus,advanceGiven,rejectReason]);
}

@override
String toString() {
    return 'Trip(id: $id, no: $no, orderId: $orderId, customer: $customer, pickupAddress: $pickupAddress, pickupContact: $pickupContact, pickupPhone: $pickupPhone, pickupLat: $pickupLat, pickupLng: $pickupLng, dropAddress: $dropAddress, dropContact: $dropContact, dropPhone: $dropPhone, dropLat: $dropLat, dropLng: $dropLng, distanceKm: $distanceKm, freightAllowance: $freightAllowance, pickupBy: $pickupBy, vehicleReg: $vehicleReg, driverId: $driverId, status: $status, plannedEta: $plannedEta, liveEta: $liveEta, steps: $steps, lrNo: $lrNo, ewayBillNo: $ewayBillNo, podStatus: $podStatus, advanceGiven: $advanceGiven, rejectReason: $rejectReason)';
}


}

/// @nodoc
abstract mixin class _$TripCopyWith<$Res> implements $TripCopyWith<$Res> {
  factory _$TripCopyWith(_Trip value, $Res Function(_Trip) _then) = __$TripCopyWithImpl;
@override @useResult
$Res call({
 String id, String no, String orderId, String customer, String pickupAddress, String pickupContact, String pickupPhone, double pickupLat, double pickupLng, String dropAddress, String dropContact, String dropPhone, double dropLat, double dropLng, double distanceKm, int freightAllowance, DateTime pickupBy, String vehicleReg, String driverId, TripStatus status, DateTime? plannedEta, DateTime? liveEta, List<TripStep> steps, String? lrNo, String? ewayBillNo, PodStatus podStatus, int advanceGiven, String? rejectReason
});




}
/// @nodoc
class __$TripCopyWithImpl<$Res>
    implements _$TripCopyWith<$Res> {
  __$TripCopyWithImpl(this._self, this._then);

  final _Trip _self;
  final $Res Function(_Trip) _then;

/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? no = null,Object? orderId = null,Object? customer = null,Object? pickupAddress = null,Object? pickupContact = null,Object? pickupPhone = null,Object? pickupLat = null,Object? pickupLng = null,Object? dropAddress = null,Object? dropContact = null,Object? dropPhone = null,Object? dropLat = null,Object? dropLng = null,Object? distanceKm = null,Object? freightAllowance = null,Object? pickupBy = null,Object? vehicleReg = null,Object? driverId = null,Object? status = null,Object? plannedEta = freezed,Object? liveEta = freezed,Object? steps = null,Object? lrNo = freezed,Object? ewayBillNo = freezed,Object? podStatus = null,Object? advanceGiven = null,Object? rejectReason = freezed,}) {
  return _then(_Trip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,no: null == no ? _self.no : no // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,customer: null == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as String,pickupAddress: null == pickupAddress ? _self.pickupAddress : pickupAddress // ignore: cast_nullable_to_non_nullable
as String,pickupContact: null == pickupContact ? _self.pickupContact : pickupContact // ignore: cast_nullable_to_non_nullable
as String,pickupPhone: null == pickupPhone ? _self.pickupPhone : pickupPhone // ignore: cast_nullable_to_non_nullable
as String,pickupLat: null == pickupLat ? _self.pickupLat : pickupLat // ignore: cast_nullable_to_non_nullable
as double,pickupLng: null == pickupLng ? _self.pickupLng : pickupLng // ignore: cast_nullable_to_non_nullable
as double,dropAddress: null == dropAddress ? _self.dropAddress : dropAddress // ignore: cast_nullable_to_non_nullable
as String,dropContact: null == dropContact ? _self.dropContact : dropContact // ignore: cast_nullable_to_non_nullable
as String,dropPhone: null == dropPhone ? _self.dropPhone : dropPhone // ignore: cast_nullable_to_non_nullable
as String,dropLat: null == dropLat ? _self.dropLat : dropLat // ignore: cast_nullable_to_non_nullable
as double,dropLng: null == dropLng ? _self.dropLng : dropLng // ignore: cast_nullable_to_non_nullable
as double,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,freightAllowance: null == freightAllowance ? _self.freightAllowance : freightAllowance // ignore: cast_nullable_to_non_nullable
as int,pickupBy: null == pickupBy ? _self.pickupBy : pickupBy // ignore: cast_nullable_to_non_nullable
as DateTime,vehicleReg: null == vehicleReg ? _self.vehicleReg : vehicleReg // ignore: cast_nullable_to_non_nullable
as String,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripStatus,plannedEta: freezed == plannedEta ? _self.plannedEta : plannedEta // ignore: cast_nullable_to_non_nullable
as DateTime?,liveEta: freezed == liveEta ? _self.liveEta : liveEta // ignore: cast_nullable_to_non_nullable
as DateTime?,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<TripStep>,lrNo: freezed == lrNo ? _self.lrNo : lrNo // ignore: cast_nullable_to_non_nullable
as String?,ewayBillNo: freezed == ewayBillNo ? _self.ewayBillNo : ewayBillNo // ignore: cast_nullable_to_non_nullable
as String?,podStatus: null == podStatus ? _self.podStatus : podStatus // ignore: cast_nullable_to_non_nullable
as PodStatus,advanceGiven: null == advanceGiven ? _self.advanceGiven : advanceGiven // ignore: cast_nullable_to_non_nullable
as int,rejectReason: freezed == rejectReason ? _self.rejectReason : rejectReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
