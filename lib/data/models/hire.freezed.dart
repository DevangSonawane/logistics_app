// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hire.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HireMemo {
  String get id;
  String get vehicleNo;
  String get ownerName;
  String? get pan;
  String get driverName;
  String get driverPhone;
  int get freight;
  int get advance;
  int get deductions;
  DateTime get createdAt;

  /// Create a copy of HireMemo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HireMemoCopyWith<HireMemo> get copyWith =>
      _$HireMemoCopyWithImpl<HireMemo>(this as HireMemo, _$identity);

  /// Serializes this HireMemo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as HireMemo;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HireMemo &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.vehicleNo, _this.vehicleNo) ||
                other.vehicleNo == _this.vehicleNo) &&
            (identical(other.ownerName, _this.ownerName) ||
                other.ownerName == _this.ownerName) &&
            (identical(other.pan, _this.pan) || other.pan == _this.pan) &&
            (identical(other.driverName, _this.driverName) ||
                other.driverName == _this.driverName) &&
            (identical(other.driverPhone, _this.driverPhone) ||
                other.driverPhone == _this.driverPhone) &&
            (identical(other.freight, _this.freight) ||
                other.freight == _this.freight) &&
            (identical(other.advance, _this.advance) ||
                other.advance == _this.advance) &&
            (identical(other.deductions, _this.deductions) ||
                other.deductions == _this.deductions) &&
            (identical(other.createdAt, _this.createdAt) ||
                other.createdAt == _this.createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as HireMemo;
    return Object.hash(
        runtimeType,
        _this.id,
        _this.vehicleNo,
        _this.ownerName,
        _this.pan,
        _this.driverName,
        _this.driverPhone,
        _this.freight,
        _this.advance,
        _this.deductions,
        _this.createdAt);
  }

  @override
  String toString() {
    final _this = this as HireMemo;
    return 'HireMemo(id: ${_this.id}, vehicleNo: ${_this.vehicleNo}, ownerName: ${_this.ownerName}, pan: ${_this.pan}, driverName: ${_this.driverName}, driverPhone: ${_this.driverPhone}, freight: ${_this.freight}, advance: ${_this.advance}, deductions: ${_this.deductions}, createdAt: ${_this.createdAt})';
  }
}

/// @nodoc
abstract mixin class $HireMemoCopyWith<$Res> {
  factory $HireMemoCopyWith(HireMemo value, $Res Function(HireMemo) _then) =
      _$HireMemoCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String vehicleNo,
      String ownerName,
      String? pan,
      String driverName,
      String driverPhone,
      int freight,
      int advance,
      int deductions,
      DateTime createdAt});
}

/// @nodoc
class _$HireMemoCopyWithImpl<$Res> implements $HireMemoCopyWith<$Res> {
  _$HireMemoCopyWithImpl(this._self, this._then);

  final HireMemo _self;
  final $Res Function(HireMemo) _then;

  /// Create a copy of HireMemo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? vehicleNo = null,
    Object? ownerName = null,
    Object? pan = freezed,
    Object? driverName = null,
    Object? driverPhone = null,
    Object? freight = null,
    Object? advance = null,
    Object? deductions = null,
    Object? createdAt = null,
  }) {
    return _then(HireMemo(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleNo: null == vehicleNo
          ? _self.vehicleNo
          : vehicleNo // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName: null == ownerName
          ? _self.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      pan: freezed == pan
          ? _self.pan
          : pan // ignore: cast_nullable_to_non_nullable
              as String?,
      driverName: null == driverName
          ? _self.driverName
          : driverName // ignore: cast_nullable_to_non_nullable
              as String,
      driverPhone: null == driverPhone
          ? _self.driverPhone
          : driverPhone // ignore: cast_nullable_to_non_nullable
              as String,
      freight: null == freight
          ? _self.freight
          : freight // ignore: cast_nullable_to_non_nullable
              as int,
      advance: null == advance
          ? _self.advance
          : advance // ignore: cast_nullable_to_non_nullable
              as int,
      deductions: null == deductions
          ? _self.deductions
          : deductions // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [HireMemo].
extension HireMemoPatterns on HireMemo {
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
    TResult Function(_HireMemo value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HireMemo() when $default != null:
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
    TResult Function(_HireMemo value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HireMemo():
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
    TResult? Function(_HireMemo value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HireMemo() when $default != null:
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
            String vehicleNo,
            String ownerName,
            String? pan,
            String driverName,
            String driverPhone,
            int freight,
            int advance,
            int deductions,
            DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HireMemo() when $default != null:
        return $default(
            _that.id,
            _that.vehicleNo,
            _that.ownerName,
            _that.pan,
            _that.driverName,
            _that.driverPhone,
            _that.freight,
            _that.advance,
            _that.deductions,
            _that.createdAt);
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
            String vehicleNo,
            String ownerName,
            String? pan,
            String driverName,
            String driverPhone,
            int freight,
            int advance,
            int deductions,
            DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HireMemo():
        return $default(
            _that.id,
            _that.vehicleNo,
            _that.ownerName,
            _that.pan,
            _that.driverName,
            _that.driverPhone,
            _that.freight,
            _that.advance,
            _that.deductions,
            _that.createdAt);
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
            String vehicleNo,
            String ownerName,
            String? pan,
            String driverName,
            String driverPhone,
            int freight,
            int advance,
            int deductions,
            DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HireMemo() when $default != null:
        return $default(
            _that.id,
            _that.vehicleNo,
            _that.ownerName,
            _that.pan,
            _that.driverName,
            _that.driverPhone,
            _that.freight,
            _that.advance,
            _that.deductions,
            _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HireMemo implements HireMemo {
  const _HireMemo(
      {required this.id,
      required this.vehicleNo,
      required this.ownerName,
      this.pan,
      required this.driverName,
      required this.driverPhone,
      required this.freight,
      this.advance = 0,
      this.deductions = 0,
      required this.createdAt});
  factory _HireMemo.fromJson(Map<String, dynamic> json) =>
      _$HireMemoFromJson(json);

  @override
  final String id;
  @override
  final String vehicleNo;
  @override
  final String ownerName;
  @override
  final String? pan;
  @override
  final String driverName;
  @override
  final String driverPhone;
  @override
  final int freight;
  @override
  @JsonKey()
  final int advance;
  @override
  @JsonKey()
  final int deductions;
  @override
  final DateTime createdAt;

  /// Create a copy of HireMemo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HireMemoCopyWith<_HireMemo> get copyWith =>
      __$HireMemoCopyWithImpl<_HireMemo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HireMemoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HireMemo &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.vehicleNo, vehicleNo) ||
                other.vehicleNo == vehicleNo) &&
            (identical(other.ownerName, ownerName) ||
                other.ownerName == ownerName) &&
            (identical(other.pan, pan) || other.pan == pan) &&
            (identical(other.driverName, driverName) ||
                other.driverName == driverName) &&
            (identical(other.driverPhone, driverPhone) ||
                other.driverPhone == driverPhone) &&
            (identical(other.freight, freight) || other.freight == freight) &&
            (identical(other.advance, advance) || other.advance == advance) &&
            (identical(other.deductions, deductions) ||
                other.deductions == deductions) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, id, vehicleNo, ownerName, pan, driverName,
        driverPhone, freight, advance, deductions, createdAt);
  }

  @override
  String toString() {
    return 'HireMemo(id: $id, vehicleNo: $vehicleNo, ownerName: $ownerName, pan: $pan, driverName: $driverName, driverPhone: $driverPhone, freight: $freight, advance: $advance, deductions: $deductions, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$HireMemoCopyWith<$Res>
    implements $HireMemoCopyWith<$Res> {
  factory _$HireMemoCopyWith(_HireMemo value, $Res Function(_HireMemo) _then) =
      __$HireMemoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String vehicleNo,
      String ownerName,
      String? pan,
      String driverName,
      String driverPhone,
      int freight,
      int advance,
      int deductions,
      DateTime createdAt});
}

/// @nodoc
class __$HireMemoCopyWithImpl<$Res> implements _$HireMemoCopyWith<$Res> {
  __$HireMemoCopyWithImpl(this._self, this._then);

  final _HireMemo _self;
  final $Res Function(_HireMemo) _then;

  /// Create a copy of HireMemo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? vehicleNo = null,
    Object? ownerName = null,
    Object? pan = freezed,
    Object? driverName = null,
    Object? driverPhone = null,
    Object? freight = null,
    Object? advance = null,
    Object? deductions = null,
    Object? createdAt = null,
  }) {
    return _then(_HireMemo(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleNo: null == vehicleNo
          ? _self.vehicleNo
          : vehicleNo // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName: null == ownerName
          ? _self.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      pan: freezed == pan
          ? _self.pan
          : pan // ignore: cast_nullable_to_non_nullable
              as String?,
      driverName: null == driverName
          ? _self.driverName
          : driverName // ignore: cast_nullable_to_non_nullable
              as String,
      driverPhone: null == driverPhone
          ? _self.driverPhone
          : driverPhone // ignore: cast_nullable_to_non_nullable
              as String,
      freight: null == freight
          ? _self.freight
          : freight // ignore: cast_nullable_to_non_nullable
              as int,
      advance: null == advance
          ? _self.advance
          : advance // ignore: cast_nullable_to_non_nullable
              as int,
      deductions: null == deductions
          ? _self.deductions
          : deductions // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
mixin _$MarketVehicle {
  String get vehicleNo;
  String get ownerName;
  String? get pan;
  String get driverName;
  String get driverPhone;
  List<String> get kycPhotos;

  /// Create a copy of MarketVehicle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MarketVehicleCopyWith<MarketVehicle> get copyWith =>
      _$MarketVehicleCopyWithImpl<MarketVehicle>(
          this as MarketVehicle, _$identity);

  /// Serializes this MarketVehicle to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as MarketVehicle;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MarketVehicle &&
            (identical(other.vehicleNo, _this.vehicleNo) ||
                other.vehicleNo == _this.vehicleNo) &&
            (identical(other.ownerName, _this.ownerName) ||
                other.ownerName == _this.ownerName) &&
            (identical(other.pan, _this.pan) || other.pan == _this.pan) &&
            (identical(other.driverName, _this.driverName) ||
                other.driverName == _this.driverName) &&
            (identical(other.driverPhone, _this.driverPhone) ||
                other.driverPhone == _this.driverPhone) &&
            const DeepCollectionEquality()
                .equals(other.kycPhotos, _this.kycPhotos));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as MarketVehicle;
    return Object.hash(
        runtimeType,
        _this.vehicleNo,
        _this.ownerName,
        _this.pan,
        _this.driverName,
        _this.driverPhone,
        const DeepCollectionEquality().hash(_this.kycPhotos));
  }

  @override
  String toString() {
    final _this = this as MarketVehicle;
    return 'MarketVehicle(vehicleNo: ${_this.vehicleNo}, ownerName: ${_this.ownerName}, pan: ${_this.pan}, driverName: ${_this.driverName}, driverPhone: ${_this.driverPhone}, kycPhotos: ${_this.kycPhotos})';
  }
}

/// @nodoc
abstract mixin class $MarketVehicleCopyWith<$Res> {
  factory $MarketVehicleCopyWith(
          MarketVehicle value, $Res Function(MarketVehicle) _then) =
      _$MarketVehicleCopyWithImpl;
  @useResult
  $Res call(
      {String vehicleNo,
      String ownerName,
      String? pan,
      String driverName,
      String driverPhone,
      List<String> kycPhotos});
}

/// @nodoc
class _$MarketVehicleCopyWithImpl<$Res>
    implements $MarketVehicleCopyWith<$Res> {
  _$MarketVehicleCopyWithImpl(this._self, this._then);

  final MarketVehicle _self;
  final $Res Function(MarketVehicle) _then;

  /// Create a copy of MarketVehicle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vehicleNo = null,
    Object? ownerName = null,
    Object? pan = freezed,
    Object? driverName = null,
    Object? driverPhone = null,
    Object? kycPhotos = null,
  }) {
    return _then(MarketVehicle(
      vehicleNo: null == vehicleNo
          ? _self.vehicleNo
          : vehicleNo // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName: null == ownerName
          ? _self.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      pan: freezed == pan
          ? _self.pan
          : pan // ignore: cast_nullable_to_non_nullable
              as String?,
      driverName: null == driverName
          ? _self.driverName
          : driverName // ignore: cast_nullable_to_non_nullable
              as String,
      driverPhone: null == driverPhone
          ? _self.driverPhone
          : driverPhone // ignore: cast_nullable_to_non_nullable
              as String,
      kycPhotos: null == kycPhotos
          ? _self.kycPhotos
          : kycPhotos // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [MarketVehicle].
extension MarketVehiclePatterns on MarketVehicle {
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
    TResult Function(_MarketVehicle value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MarketVehicle() when $default != null:
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
    TResult Function(_MarketVehicle value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MarketVehicle():
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
    TResult? Function(_MarketVehicle value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MarketVehicle() when $default != null:
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
    TResult Function(String vehicleNo, String ownerName, String? pan,
            String driverName, String driverPhone, List<String> kycPhotos)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MarketVehicle() when $default != null:
        return $default(_that.vehicleNo, _that.ownerName, _that.pan,
            _that.driverName, _that.driverPhone, _that.kycPhotos);
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
    TResult Function(String vehicleNo, String ownerName, String? pan,
            String driverName, String driverPhone, List<String> kycPhotos)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MarketVehicle():
        return $default(_that.vehicleNo, _that.ownerName, _that.pan,
            _that.driverName, _that.driverPhone, _that.kycPhotos);
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
    TResult? Function(String vehicleNo, String ownerName, String? pan,
            String driverName, String driverPhone, List<String> kycPhotos)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MarketVehicle() when $default != null:
        return $default(_that.vehicleNo, _that.ownerName, _that.pan,
            _that.driverName, _that.driverPhone, _that.kycPhotos);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MarketVehicle implements MarketVehicle {
  const _MarketVehicle(
      {required this.vehicleNo,
      required this.ownerName,
      this.pan,
      required this.driverName,
      required this.driverPhone,
      List<String> kycPhotos = const []})
      : _kycPhotos = kycPhotos;
  factory _MarketVehicle.fromJson(Map<String, dynamic> json) =>
      _$MarketVehicleFromJson(json);

  @override
  final String vehicleNo;
  @override
  final String ownerName;
  @override
  final String? pan;
  @override
  final String driverName;
  @override
  final String driverPhone;
  final List<String> _kycPhotos;
  @override
  @JsonKey()
  List<String> get kycPhotos {
    if (_kycPhotos is EqualUnmodifiableListView) return _kycPhotos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_kycPhotos);
  }

  /// Create a copy of MarketVehicle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MarketVehicleCopyWith<_MarketVehicle> get copyWith =>
      __$MarketVehicleCopyWithImpl<_MarketVehicle>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MarketVehicleToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MarketVehicle &&
            (identical(other.vehicleNo, vehicleNo) ||
                other.vehicleNo == vehicleNo) &&
            (identical(other.ownerName, ownerName) ||
                other.ownerName == ownerName) &&
            (identical(other.pan, pan) || other.pan == pan) &&
            (identical(other.driverName, driverName) ||
                other.driverName == driverName) &&
            (identical(other.driverPhone, driverPhone) ||
                other.driverPhone == driverPhone) &&
            const DeepCollectionEquality().equals(other.kycPhotos, _kycPhotos));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, vehicleNo, ownerName, pan, driverName,
        driverPhone, const DeepCollectionEquality().hash(_kycPhotos));
  }

  @override
  String toString() {
    return 'MarketVehicle(vehicleNo: $vehicleNo, ownerName: $ownerName, pan: $pan, driverName: $driverName, driverPhone: $driverPhone, kycPhotos: $kycPhotos)';
  }
}

/// @nodoc
abstract mixin class _$MarketVehicleCopyWith<$Res>
    implements $MarketVehicleCopyWith<$Res> {
  factory _$MarketVehicleCopyWith(
          _MarketVehicle value, $Res Function(_MarketVehicle) _then) =
      __$MarketVehicleCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String vehicleNo,
      String ownerName,
      String? pan,
      String driverName,
      String driverPhone,
      List<String> kycPhotos});
}

/// @nodoc
class __$MarketVehicleCopyWithImpl<$Res>
    implements _$MarketVehicleCopyWith<$Res> {
  __$MarketVehicleCopyWithImpl(this._self, this._then);

  final _MarketVehicle _self;
  final $Res Function(_MarketVehicle) _then;

  /// Create a copy of MarketVehicle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? vehicleNo = null,
    Object? ownerName = null,
    Object? pan = freezed,
    Object? driverName = null,
    Object? driverPhone = null,
    Object? kycPhotos = null,
  }) {
    return _then(_MarketVehicle(
      vehicleNo: null == vehicleNo
          ? _self.vehicleNo
          : vehicleNo // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName: null == ownerName
          ? _self.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      pan: freezed == pan
          ? _self.pan
          : pan // ignore: cast_nullable_to_non_nullable
              as String?,
      driverName: null == driverName
          ? _self.driverName
          : driverName // ignore: cast_nullable_to_non_nullable
              as String,
      driverPhone: null == driverPhone
          ? _self.driverPhone
          : driverPhone // ignore: cast_nullable_to_non_nullable
              as String,
      kycPhotos: null == kycPhotos
          ? _self._kycPhotos
          : kycPhotos // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
