// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lane.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Lane {
  String get id;
  String get from;
  String get to;
  double get distanceKm;
  int get transitHrs;

  /// Create a copy of Lane
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LaneCopyWith<Lane> get copyWith =>
      _$LaneCopyWithImpl<Lane>(this as Lane, _$identity);

  /// Serializes this Lane to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as Lane;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Lane &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.from, _this.from) || other.from == _this.from) &&
            (identical(other.to, _this.to) || other.to == _this.to) &&
            (identical(other.distanceKm, _this.distanceKm) ||
                other.distanceKm == _this.distanceKm) &&
            (identical(other.transitHrs, _this.transitHrs) ||
                other.transitHrs == _this.transitHrs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as Lane;
    return Object.hash(runtimeType, _this.id, _this.from, _this.to,
        _this.distanceKm, _this.transitHrs);
  }

  @override
  String toString() {
    final _this = this as Lane;
    return 'Lane(id: ${_this.id}, from: ${_this.from}, to: ${_this.to}, distanceKm: ${_this.distanceKm}, transitHrs: ${_this.transitHrs})';
  }
}

/// @nodoc
abstract mixin class $LaneCopyWith<$Res> {
  factory $LaneCopyWith(Lane value, $Res Function(Lane) _then) =
      _$LaneCopyWithImpl;
  @useResult
  $Res call(
      {String id, String from, String to, double distanceKm, int transitHrs});
}

/// @nodoc
class _$LaneCopyWithImpl<$Res> implements $LaneCopyWith<$Res> {
  _$LaneCopyWithImpl(this._self, this._then);

  final Lane _self;
  final $Res Function(Lane) _then;

  /// Create a copy of Lane
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? from = null,
    Object? to = null,
    Object? distanceKm = null,
    Object? transitHrs = null,
  }) {
    return _then(Lane(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      from: null == from
          ? _self.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _self.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      distanceKm: null == distanceKm
          ? _self.distanceKm
          : distanceKm // ignore: cast_nullable_to_non_nullable
              as double,
      transitHrs: null == transitHrs
          ? _self.transitHrs
          : transitHrs // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [Lane].
extension LanePatterns on Lane {
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
    TResult Function(_Lane value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Lane() when $default != null:
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
    TResult Function(_Lane value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Lane():
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
    TResult? Function(_Lane value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Lane() when $default != null:
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
    TResult Function(String id, String from, String to, double distanceKm,
            int transitHrs)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Lane() when $default != null:
        return $default(
            _that.id, _that.from, _that.to, _that.distanceKm, _that.transitHrs);
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
    TResult Function(String id, String from, String to, double distanceKm,
            int transitHrs)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Lane():
        return $default(
            _that.id, _that.from, _that.to, _that.distanceKm, _that.transitHrs);
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
    TResult? Function(String id, String from, String to, double distanceKm,
            int transitHrs)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Lane() when $default != null:
        return $default(
            _that.id, _that.from, _that.to, _that.distanceKm, _that.transitHrs);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Lane implements Lane {
  const _Lane(
      {required this.id,
      required this.from,
      required this.to,
      required this.distanceKm,
      required this.transitHrs});
  factory _Lane.fromJson(Map<String, dynamic> json) => _$LaneFromJson(json);

  @override
  final String id;
  @override
  final String from;
  @override
  final String to;
  @override
  final double distanceKm;
  @override
  final int transitHrs;

  /// Create a copy of Lane
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LaneCopyWith<_Lane> get copyWith =>
      __$LaneCopyWithImpl<_Lane>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LaneToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Lane &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.distanceKm, distanceKm) ||
                other.distanceKm == distanceKm) &&
            (identical(other.transitHrs, transitHrs) ||
                other.transitHrs == transitHrs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, id, from, to, distanceKm, transitHrs);
  }

  @override
  String toString() {
    return 'Lane(id: $id, from: $from, to: $to, distanceKm: $distanceKm, transitHrs: $transitHrs)';
  }
}

/// @nodoc
abstract mixin class _$LaneCopyWith<$Res> implements $LaneCopyWith<$Res> {
  factory _$LaneCopyWith(_Lane value, $Res Function(_Lane) _then) =
      __$LaneCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id, String from, String to, double distanceKm, int transitHrs});
}

/// @nodoc
class __$LaneCopyWithImpl<$Res> implements _$LaneCopyWith<$Res> {
  __$LaneCopyWithImpl(this._self, this._then);

  final _Lane _self;
  final $Res Function(_Lane) _then;

  /// Create a copy of Lane
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? from = null,
    Object? to = null,
    Object? distanceKm = null,
    Object? transitHrs = null,
  }) {
    return _then(_Lane(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      from: null == from
          ? _self.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _self.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      distanceKm: null == distanceKm
          ? _self.distanceKm
          : distanceKm // ignore: cast_nullable_to_non_nullable
              as double,
      transitHrs: null == transitHrs
          ? _self.transitHrs
          : transitHrs // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
