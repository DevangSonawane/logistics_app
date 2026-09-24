// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'advance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Advance {
  String get id;
  String get tripId;
  int get amount;
  AdvancePurpose get purpose;
  String? get note;
  AdvanceStatus get status;
  DateTime get requestedAt;

  /// Create a copy of Advance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AdvanceCopyWith<Advance> get copyWith =>
      _$AdvanceCopyWithImpl<Advance>(this as Advance, _$identity);

  /// Serializes this Advance to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as Advance;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Advance &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.tripId, _this.tripId) ||
                other.tripId == _this.tripId) &&
            (identical(other.amount, _this.amount) ||
                other.amount == _this.amount) &&
            (identical(other.purpose, _this.purpose) ||
                other.purpose == _this.purpose) &&
            (identical(other.note, _this.note) || other.note == _this.note) &&
            (identical(other.status, _this.status) ||
                other.status == _this.status) &&
            (identical(other.requestedAt, _this.requestedAt) ||
                other.requestedAt == _this.requestedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as Advance;
    return Object.hash(runtimeType, _this.id, _this.tripId, _this.amount,
        _this.purpose, _this.note, _this.status, _this.requestedAt);
  }

  @override
  String toString() {
    final _this = this as Advance;
    return 'Advance(id: ${_this.id}, tripId: ${_this.tripId}, amount: ${_this.amount}, purpose: ${_this.purpose}, note: ${_this.note}, status: ${_this.status}, requestedAt: ${_this.requestedAt})';
  }
}

/// @nodoc
abstract mixin class $AdvanceCopyWith<$Res> {
  factory $AdvanceCopyWith(Advance value, $Res Function(Advance) _then) =
      _$AdvanceCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String tripId,
      int amount,
      AdvancePurpose purpose,
      String? note,
      AdvanceStatus status,
      DateTime requestedAt});
}

/// @nodoc
class _$AdvanceCopyWithImpl<$Res> implements $AdvanceCopyWith<$Res> {
  _$AdvanceCopyWithImpl(this._self, this._then);

  final Advance _self;
  final $Res Function(Advance) _then;

  /// Create a copy of Advance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tripId = null,
    Object? amount = null,
    Object? purpose = null,
    Object? note = freezed,
    Object? status = null,
    Object? requestedAt = null,
  }) {
    return _then(Advance(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tripId: null == tripId
          ? _self.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      purpose: null == purpose
          ? _self.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as AdvancePurpose,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as AdvanceStatus,
      requestedAt: null == requestedAt
          ? _self.requestedAt
          : requestedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [Advance].
extension AdvancePatterns on Advance {
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
    TResult Function(_Advance value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Advance() when $default != null:
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
    TResult Function(_Advance value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Advance():
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
    TResult? Function(_Advance value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Advance() when $default != null:
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
            String tripId,
            int amount,
            AdvancePurpose purpose,
            String? note,
            AdvanceStatus status,
            DateTime requestedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Advance() when $default != null:
        return $default(_that.id, _that.tripId, _that.amount, _that.purpose,
            _that.note, _that.status, _that.requestedAt);
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
            String tripId,
            int amount,
            AdvancePurpose purpose,
            String? note,
            AdvanceStatus status,
            DateTime requestedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Advance():
        return $default(_that.id, _that.tripId, _that.amount, _that.purpose,
            _that.note, _that.status, _that.requestedAt);
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
            String tripId,
            int amount,
            AdvancePurpose purpose,
            String? note,
            AdvanceStatus status,
            DateTime requestedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Advance() when $default != null:
        return $default(_that.id, _that.tripId, _that.amount, _that.purpose,
            _that.note, _that.status, _that.requestedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Advance implements Advance {
  const _Advance(
      {required this.id,
      required this.tripId,
      required this.amount,
      required this.purpose,
      this.note,
      this.status = AdvanceStatus.requested,
      required this.requestedAt});
  factory _Advance.fromJson(Map<String, dynamic> json) =>
      _$AdvanceFromJson(json);

  @override
  final String id;
  @override
  final String tripId;
  @override
  final int amount;
  @override
  final AdvancePurpose purpose;
  @override
  final String? note;
  @override
  @JsonKey()
  final AdvanceStatus status;
  @override
  final DateTime requestedAt;

  /// Create a copy of Advance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AdvanceCopyWith<_Advance> get copyWith =>
      __$AdvanceCopyWithImpl<_Advance>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AdvanceToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Advance &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.requestedAt, requestedAt) ||
                other.requestedAt == requestedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
        runtimeType, id, tripId, amount, purpose, note, status, requestedAt);
  }

  @override
  String toString() {
    return 'Advance(id: $id, tripId: $tripId, amount: $amount, purpose: $purpose, note: $note, status: $status, requestedAt: $requestedAt)';
  }
}

/// @nodoc
abstract mixin class _$AdvanceCopyWith<$Res> implements $AdvanceCopyWith<$Res> {
  factory _$AdvanceCopyWith(_Advance value, $Res Function(_Advance) _then) =
      __$AdvanceCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String tripId,
      int amount,
      AdvancePurpose purpose,
      String? note,
      AdvanceStatus status,
      DateTime requestedAt});
}

/// @nodoc
class __$AdvanceCopyWithImpl<$Res> implements _$AdvanceCopyWith<$Res> {
  __$AdvanceCopyWithImpl(this._self, this._then);

  final _Advance _self;
  final $Res Function(_Advance) _then;

  /// Create a copy of Advance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? tripId = null,
    Object? amount = null,
    Object? purpose = null,
    Object? note = freezed,
    Object? status = null,
    Object? requestedAt = null,
  }) {
    return _then(_Advance(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tripId: null == tripId
          ? _self.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      purpose: null == purpose
          ? _self.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as AdvancePurpose,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as AdvanceStatus,
      requestedAt: null == requestedAt
          ? _self.requestedAt
          : requestedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
