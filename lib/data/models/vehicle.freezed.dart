// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VehicleDoc {
  VehicleDocType get type;
  String get number;
  DateTime get expiry;
  String? get photoPath;

  /// Create a copy of VehicleDoc
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VehicleDocCopyWith<VehicleDoc> get copyWith =>
      _$VehicleDocCopyWithImpl<VehicleDoc>(this as VehicleDoc, _$identity);

  /// Serializes this VehicleDoc to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as VehicleDoc;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VehicleDoc &&
            (identical(other.type, _this.type) || other.type == _this.type) &&
            (identical(other.number, _this.number) ||
                other.number == _this.number) &&
            (identical(other.expiry, _this.expiry) ||
                other.expiry == _this.expiry) &&
            (identical(other.photoPath, _this.photoPath) ||
                other.photoPath == _this.photoPath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as VehicleDoc;
    return Object.hash(
        runtimeType, _this.type, _this.number, _this.expiry, _this.photoPath);
  }

  @override
  String toString() {
    final _this = this as VehicleDoc;
    return 'VehicleDoc(type: ${_this.type}, number: ${_this.number}, expiry: ${_this.expiry}, photoPath: ${_this.photoPath})';
  }
}

/// @nodoc
abstract mixin class $VehicleDocCopyWith<$Res> {
  factory $VehicleDocCopyWith(
          VehicleDoc value, $Res Function(VehicleDoc) _then) =
      _$VehicleDocCopyWithImpl;
  @useResult
  $Res call(
      {VehicleDocType type, String number, DateTime expiry, String? photoPath});
}

/// @nodoc
class _$VehicleDocCopyWithImpl<$Res> implements $VehicleDocCopyWith<$Res> {
  _$VehicleDocCopyWithImpl(this._self, this._then);

  final VehicleDoc _self;
  final $Res Function(VehicleDoc) _then;

  /// Create a copy of VehicleDoc
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? number = null,
    Object? expiry = null,
    Object? photoPath = freezed,
  }) {
    return _then(VehicleDoc(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as VehicleDocType,
      number: null == number
          ? _self.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      expiry: null == expiry
          ? _self.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as DateTime,
      photoPath: freezed == photoPath
          ? _self.photoPath
          : photoPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [VehicleDoc].
extension VehicleDocPatterns on VehicleDoc {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_VehicleDoc value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VehicleDoc() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_VehicleDoc value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VehicleDoc():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_VehicleDoc value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VehicleDoc() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(VehicleDocType type, String number, DateTime expiry,
            String? photoPath)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VehicleDoc() when $default != null:
        return $default(
            _that.type, _that.number, _that.expiry, _that.photoPath);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(VehicleDocType type, String number, DateTime expiry,
            String? photoPath)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VehicleDoc():
        return $default(
            _that.type, _that.number, _that.expiry, _that.photoPath);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(VehicleDocType type, String number, DateTime expiry,
            String? photoPath)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VehicleDoc() when $default != null:
        return $default(
            _that.type, _that.number, _that.expiry, _that.photoPath);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _VehicleDoc implements VehicleDoc {
  const _VehicleDoc(
      {required this.type,
      required this.number,
      required this.expiry,
      this.photoPath});
  factory _VehicleDoc.fromJson(Map<String, dynamic> json) =>
      _$VehicleDocFromJson(json);

  @override
  final VehicleDocType type;
  @override
  final String number;
  @override
  final DateTime expiry;
  @override
  final String? photoPath;

  /// Create a copy of VehicleDoc
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VehicleDocCopyWith<_VehicleDoc> get copyWith =>
      __$VehicleDocCopyWithImpl<_VehicleDoc>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VehicleDocToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VehicleDoc &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.expiry, expiry) || other.expiry == expiry) &&
            (identical(other.photoPath, photoPath) ||
                other.photoPath == photoPath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, type, number, expiry, photoPath);
  }

  @override
  String toString() {
    return 'VehicleDoc(type: $type, number: $number, expiry: $expiry, photoPath: $photoPath)';
  }
}

/// @nodoc
abstract mixin class _$VehicleDocCopyWith<$Res>
    implements $VehicleDocCopyWith<$Res> {
  factory _$VehicleDocCopyWith(
          _VehicleDoc value, $Res Function(_VehicleDoc) _then) =
      __$VehicleDocCopyWithImpl;
  @override
  @useResult
  $Res call(
      {VehicleDocType type, String number, DateTime expiry, String? photoPath});
}

/// @nodoc
class __$VehicleDocCopyWithImpl<$Res> implements _$VehicleDocCopyWith<$Res> {
  __$VehicleDocCopyWithImpl(this._self, this._then);

  final _VehicleDoc _self;
  final $Res Function(_VehicleDoc) _then;

  /// Create a copy of VehicleDoc
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? number = null,
    Object? expiry = null,
    Object? photoPath = freezed,
  }) {
    return _then(_VehicleDoc(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as VehicleDocType,
      number: null == number
          ? _self.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      expiry: null == expiry
          ? _self.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as DateTime,
      photoPath: freezed == photoPath
          ? _self.photoPath
          : photoPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$Vehicle {
  String get id;
  String get regNo;
  String get type;
  List<VehicleDoc> get docs;
  double get capacityTons;
  VehicleOwnership get ownership;
  VehicleStatus get status;
  double? get lastLat;
  double? get lastLng;
  DateTime? get lastUpdate;
  int get mileageKm;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VehicleCopyWith<Vehicle> get copyWith =>
      _$VehicleCopyWithImpl<Vehicle>(this as Vehicle, _$identity);

  /// Serializes this Vehicle to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as Vehicle;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Vehicle &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.regNo, _this.regNo) ||
                other.regNo == _this.regNo) &&
            (identical(other.type, _this.type) || other.type == _this.type) &&
            const DeepCollectionEquality().equals(other.docs, _this.docs) &&
            (identical(other.capacityTons, _this.capacityTons) ||
                other.capacityTons == _this.capacityTons) &&
            (identical(other.ownership, _this.ownership) ||
                other.ownership == _this.ownership) &&
            (identical(other.status, _this.status) ||
                other.status == _this.status) &&
            (identical(other.lastLat, _this.lastLat) ||
                other.lastLat == _this.lastLat) &&
            (identical(other.lastLng, _this.lastLng) ||
                other.lastLng == _this.lastLng) &&
            (identical(other.lastUpdate, _this.lastUpdate) ||
                other.lastUpdate == _this.lastUpdate) &&
            (identical(other.mileageKm, _this.mileageKm) ||
                other.mileageKm == _this.mileageKm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as Vehicle;
    return Object.hash(
        runtimeType,
        _this.id,
        _this.regNo,
        _this.type,
        const DeepCollectionEquality().hash(_this.docs),
        _this.capacityTons,
        _this.ownership,
        _this.status,
        _this.lastLat,
        _this.lastLng,
        _this.lastUpdate,
        _this.mileageKm);
  }

  @override
  String toString() {
    final _this = this as Vehicle;
    return 'Vehicle(id: ${_this.id}, regNo: ${_this.regNo}, type: ${_this.type}, docs: ${_this.docs}, capacityTons: ${_this.capacityTons}, ownership: ${_this.ownership}, status: ${_this.status}, lastLat: ${_this.lastLat}, lastLng: ${_this.lastLng}, lastUpdate: ${_this.lastUpdate}, mileageKm: ${_this.mileageKm})';
  }
}

/// @nodoc
abstract mixin class $VehicleCopyWith<$Res> {
  factory $VehicleCopyWith(Vehicle value, $Res Function(Vehicle) _then) =
      _$VehicleCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String regNo,
      String type,
      List<VehicleDoc> docs,
      double capacityTons,
      VehicleOwnership ownership,
      VehicleStatus status,
      double? lastLat,
      double? lastLng,
      DateTime? lastUpdate,
      int mileageKm});
}

/// @nodoc
class _$VehicleCopyWithImpl<$Res> implements $VehicleCopyWith<$Res> {
  _$VehicleCopyWithImpl(this._self, this._then);

  final Vehicle _self;
  final $Res Function(Vehicle) _then;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? regNo = null,
    Object? type = null,
    Object? docs = null,
    Object? capacityTons = null,
    Object? ownership = null,
    Object? status = null,
    Object? lastLat = freezed,
    Object? lastLng = freezed,
    Object? lastUpdate = freezed,
    Object? mileageKm = null,
  }) {
    return _then(Vehicle(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      regNo: null == regNo
          ? _self.regNo
          : regNo // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      docs: null == docs
          ? _self.docs
          : docs // ignore: cast_nullable_to_non_nullable
              as List<VehicleDoc>,
      capacityTons: null == capacityTons
          ? _self.capacityTons
          : capacityTons // ignore: cast_nullable_to_non_nullable
              as double,
      ownership: null == ownership
          ? _self.ownership
          : ownership // ignore: cast_nullable_to_non_nullable
              as VehicleOwnership,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as VehicleStatus,
      lastLat: freezed == lastLat
          ? _self.lastLat
          : lastLat // ignore: cast_nullable_to_non_nullable
              as double?,
      lastLng: freezed == lastLng
          ? _self.lastLng
          : lastLng // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdate: freezed == lastUpdate
          ? _self.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      mileageKm: null == mileageKm
          ? _self.mileageKm
          : mileageKm // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [Vehicle].
extension VehiclePatterns on Vehicle {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Vehicle value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Vehicle() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Vehicle value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Vehicle():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Vehicle value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Vehicle() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String regNo,
            String type,
            List<VehicleDoc> docs,
            double capacityTons,
            VehicleOwnership ownership,
            VehicleStatus status,
            double? lastLat,
            double? lastLng,
            DateTime? lastUpdate,
            int mileageKm)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Vehicle() when $default != null:
        return $default(
            _that.id,
            _that.regNo,
            _that.type,
            _that.docs,
            _that.capacityTons,
            _that.ownership,
            _that.status,
            _that.lastLat,
            _that.lastLng,
            _that.lastUpdate,
            _that.mileageKm);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String regNo,
            String type,
            List<VehicleDoc> docs,
            double capacityTons,
            VehicleOwnership ownership,
            VehicleStatus status,
            double? lastLat,
            double? lastLng,
            DateTime? lastUpdate,
            int mileageKm)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Vehicle():
        return $default(
            _that.id,
            _that.regNo,
            _that.type,
            _that.docs,
            _that.capacityTons,
            _that.ownership,
            _that.status,
            _that.lastLat,
            _that.lastLng,
            _that.lastUpdate,
            _that.mileageKm);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String regNo,
            String type,
            List<VehicleDoc> docs,
            double capacityTons,
            VehicleOwnership ownership,
            VehicleStatus status,
            double? lastLat,
            double? lastLng,
            DateTime? lastUpdate,
            int mileageKm)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Vehicle() when $default != null:
        return $default(
            _that.id,
            _that.regNo,
            _that.type,
            _that.docs,
            _that.capacityTons,
            _that.ownership,
            _that.status,
            _that.lastLat,
            _that.lastLng,
            _that.lastUpdate,
            _that.mileageKm);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Vehicle implements Vehicle {
  const _Vehicle(
      {required this.id,
      required this.regNo,
      required this.type,
      List<VehicleDoc> docs = const [],
      this.capacityTons = 0,
      this.ownership = VehicleOwnership.own,
      this.status = VehicleStatus.idle,
      this.lastLat,
      this.lastLng,
      this.lastUpdate,
      this.mileageKm = 0})
      : _docs = docs;
  factory _Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);

  @override
  final String id;
  @override
  final String regNo;
  @override
  final String type;
  final List<VehicleDoc> _docs;
  @override
  @JsonKey()
  List<VehicleDoc> get docs {
    if (_docs is EqualUnmodifiableListView) return _docs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_docs);
  }

  @override
  @JsonKey()
  final double capacityTons;
  @override
  @JsonKey()
  final VehicleOwnership ownership;
  @override
  @JsonKey()
  final VehicleStatus status;
  @override
  final double? lastLat;
  @override
  final double? lastLng;
  @override
  final DateTime? lastUpdate;
  @override
  @JsonKey()
  final int mileageKm;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VehicleCopyWith<_Vehicle> get copyWith =>
      __$VehicleCopyWithImpl<_Vehicle>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VehicleToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Vehicle &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.regNo, regNo) || other.regNo == regNo) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.docs, _docs) &&
            (identical(other.capacityTons, capacityTons) ||
                other.capacityTons == capacityTons) &&
            (identical(other.ownership, ownership) ||
                other.ownership == ownership) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.lastLat, lastLat) || other.lastLat == lastLat) &&
            (identical(other.lastLng, lastLng) || other.lastLng == lastLng) &&
            (identical(other.lastUpdate, lastUpdate) ||
                other.lastUpdate == lastUpdate) &&
            (identical(other.mileageKm, mileageKm) ||
                other.mileageKm == mileageKm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        id,
        regNo,
        type,
        const DeepCollectionEquality().hash(_docs),
        capacityTons,
        ownership,
        status,
        lastLat,
        lastLng,
        lastUpdate,
        mileageKm);
  }

  @override
  String toString() {
    return 'Vehicle(id: $id, regNo: $regNo, type: $type, docs: $docs, capacityTons: $capacityTons, ownership: $ownership, status: $status, lastLat: $lastLat, lastLng: $lastLng, lastUpdate: $lastUpdate, mileageKm: $mileageKm)';
  }
}

/// @nodoc
abstract mixin class _$VehicleCopyWith<$Res> implements $VehicleCopyWith<$Res> {
  factory _$VehicleCopyWith(_Vehicle value, $Res Function(_Vehicle) _then) =
      __$VehicleCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String regNo,
      String type,
      List<VehicleDoc> docs,
      double capacityTons,
      VehicleOwnership ownership,
      VehicleStatus status,
      double? lastLat,
      double? lastLng,
      DateTime? lastUpdate,
      int mileageKm});
}

/// @nodoc
class __$VehicleCopyWithImpl<$Res> implements _$VehicleCopyWith<$Res> {
  __$VehicleCopyWithImpl(this._self, this._then);

  final _Vehicle _self;
  final $Res Function(_Vehicle) _then;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? regNo = null,
    Object? type = null,
    Object? docs = null,
    Object? capacityTons = null,
    Object? ownership = null,
    Object? status = null,
    Object? lastLat = freezed,
    Object? lastLng = freezed,
    Object? lastUpdate = freezed,
    Object? mileageKm = null,
  }) {
    return _then(_Vehicle(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      regNo: null == regNo
          ? _self.regNo
          : regNo // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      docs: null == docs
          ? _self._docs
          : docs // ignore: cast_nullable_to_non_nullable
              as List<VehicleDoc>,
      capacityTons: null == capacityTons
          ? _self.capacityTons
          : capacityTons // ignore: cast_nullable_to_non_nullable
              as double,
      ownership: null == ownership
          ? _self.ownership
          : ownership // ignore: cast_nullable_to_non_nullable
              as VehicleOwnership,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as VehicleStatus,
      lastLat: freezed == lastLat
          ? _self.lastLat
          : lastLat // ignore: cast_nullable_to_non_nullable
              as double?,
      lastLng: freezed == lastLng
          ? _self.lastLng
          : lastLng // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdate: freezed == lastUpdate
          ? _self.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      mileageKm: null == mileageKm
          ? _self.mileageKm
          : mileageKm // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
