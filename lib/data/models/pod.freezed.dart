// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pod.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PodSubmission {
  String get tripId;
  String get lrPhotoPath;
  PodMethod get method;
  String? get consigneeName;
  bool get hasDamageOrShortage;
  String? get damageRemark;
  int? get damageQty;
  List<String> get damagePhotos;
  DateTime get submittedAt;

  /// Create a copy of PodSubmission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PodSubmissionCopyWith<PodSubmission> get copyWith =>
      _$PodSubmissionCopyWithImpl<PodSubmission>(
          this as PodSubmission, _$identity);

  /// Serializes this PodSubmission to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as PodSubmission;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PodSubmission &&
            (identical(other.tripId, _this.tripId) ||
                other.tripId == _this.tripId) &&
            (identical(other.lrPhotoPath, _this.lrPhotoPath) ||
                other.lrPhotoPath == _this.lrPhotoPath) &&
            (identical(other.method, _this.method) ||
                other.method == _this.method) &&
            (identical(other.consigneeName, _this.consigneeName) ||
                other.consigneeName == _this.consigneeName) &&
            (identical(other.hasDamageOrShortage, _this.hasDamageOrShortage) ||
                other.hasDamageOrShortage == _this.hasDamageOrShortage) &&
            (identical(other.damageRemark, _this.damageRemark) ||
                other.damageRemark == _this.damageRemark) &&
            (identical(other.damageQty, _this.damageQty) ||
                other.damageQty == _this.damageQty) &&
            const DeepCollectionEquality()
                .equals(other.damagePhotos, _this.damagePhotos) &&
            (identical(other.submittedAt, _this.submittedAt) ||
                other.submittedAt == _this.submittedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as PodSubmission;
    return Object.hash(
        runtimeType,
        _this.tripId,
        _this.lrPhotoPath,
        _this.method,
        _this.consigneeName,
        _this.hasDamageOrShortage,
        _this.damageRemark,
        _this.damageQty,
        const DeepCollectionEquality().hash(_this.damagePhotos),
        _this.submittedAt);
  }

  @override
  String toString() {
    final _this = this as PodSubmission;
    return 'PodSubmission(tripId: ${_this.tripId}, lrPhotoPath: ${_this.lrPhotoPath}, method: ${_this.method}, consigneeName: ${_this.consigneeName}, hasDamageOrShortage: ${_this.hasDamageOrShortage}, damageRemark: ${_this.damageRemark}, damageQty: ${_this.damageQty}, damagePhotos: ${_this.damagePhotos}, submittedAt: ${_this.submittedAt})';
  }
}

/// @nodoc
abstract mixin class $PodSubmissionCopyWith<$Res> {
  factory $PodSubmissionCopyWith(
          PodSubmission value, $Res Function(PodSubmission) _then) =
      _$PodSubmissionCopyWithImpl;
  @useResult
  $Res call(
      {String tripId,
      String lrPhotoPath,
      PodMethod method,
      String? consigneeName,
      bool hasDamageOrShortage,
      String? damageRemark,
      int? damageQty,
      List<String> damagePhotos,
      DateTime submittedAt});
}

/// @nodoc
class _$PodSubmissionCopyWithImpl<$Res>
    implements $PodSubmissionCopyWith<$Res> {
  _$PodSubmissionCopyWithImpl(this._self, this._then);

  final PodSubmission _self;
  final $Res Function(PodSubmission) _then;

  /// Create a copy of PodSubmission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = null,
    Object? lrPhotoPath = null,
    Object? method = null,
    Object? consigneeName = freezed,
    Object? hasDamageOrShortage = null,
    Object? damageRemark = freezed,
    Object? damageQty = freezed,
    Object? damagePhotos = null,
    Object? submittedAt = null,
  }) {
    return _then(PodSubmission(
      tripId: null == tripId
          ? _self.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as String,
      lrPhotoPath: null == lrPhotoPath
          ? _self.lrPhotoPath
          : lrPhotoPath // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _self.method
          : method // ignore: cast_nullable_to_non_nullable
              as PodMethod,
      consigneeName: freezed == consigneeName
          ? _self.consigneeName
          : consigneeName // ignore: cast_nullable_to_non_nullable
              as String?,
      hasDamageOrShortage: null == hasDamageOrShortage
          ? _self.hasDamageOrShortage
          : hasDamageOrShortage // ignore: cast_nullable_to_non_nullable
              as bool,
      damageRemark: freezed == damageRemark
          ? _self.damageRemark
          : damageRemark // ignore: cast_nullable_to_non_nullable
              as String?,
      damageQty: freezed == damageQty
          ? _self.damageQty
          : damageQty // ignore: cast_nullable_to_non_nullable
              as int?,
      damagePhotos: null == damagePhotos
          ? _self.damagePhotos
          : damagePhotos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      submittedAt: null == submittedAt
          ? _self.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [PodSubmission].
extension PodSubmissionPatterns on PodSubmission {
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
    TResult Function(_PodSubmission value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PodSubmission() when $default != null:
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
    TResult Function(_PodSubmission value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PodSubmission():
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
    TResult? Function(_PodSubmission value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PodSubmission() when $default != null:
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
            String tripId,
            String lrPhotoPath,
            PodMethod method,
            String? consigneeName,
            bool hasDamageOrShortage,
            String? damageRemark,
            int? damageQty,
            List<String> damagePhotos,
            DateTime submittedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PodSubmission() when $default != null:
        return $default(
            _that.tripId,
            _that.lrPhotoPath,
            _that.method,
            _that.consigneeName,
            _that.hasDamageOrShortage,
            _that.damageRemark,
            _that.damageQty,
            _that.damagePhotos,
            _that.submittedAt);
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
            String tripId,
            String lrPhotoPath,
            PodMethod method,
            String? consigneeName,
            bool hasDamageOrShortage,
            String? damageRemark,
            int? damageQty,
            List<String> damagePhotos,
            DateTime submittedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PodSubmission():
        return $default(
            _that.tripId,
            _that.lrPhotoPath,
            _that.method,
            _that.consigneeName,
            _that.hasDamageOrShortage,
            _that.damageRemark,
            _that.damageQty,
            _that.damagePhotos,
            _that.submittedAt);
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
            String tripId,
            String lrPhotoPath,
            PodMethod method,
            String? consigneeName,
            bool hasDamageOrShortage,
            String? damageRemark,
            int? damageQty,
            List<String> damagePhotos,
            DateTime submittedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PodSubmission() when $default != null:
        return $default(
            _that.tripId,
            _that.lrPhotoPath,
            _that.method,
            _that.consigneeName,
            _that.hasDamageOrShortage,
            _that.damageRemark,
            _that.damageQty,
            _that.damagePhotos,
            _that.submittedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PodSubmission implements PodSubmission {
  const _PodSubmission(
      {required this.tripId,
      required this.lrPhotoPath,
      required this.method,
      this.consigneeName,
      this.hasDamageOrShortage = false,
      this.damageRemark,
      this.damageQty,
      List<String> damagePhotos = const [],
      required this.submittedAt})
      : _damagePhotos = damagePhotos;
  factory _PodSubmission.fromJson(Map<String, dynamic> json) =>
      _$PodSubmissionFromJson(json);

  @override
  final String tripId;
  @override
  final String lrPhotoPath;
  @override
  final PodMethod method;
  @override
  final String? consigneeName;
  @override
  @JsonKey()
  final bool hasDamageOrShortage;
  @override
  final String? damageRemark;
  @override
  final int? damageQty;
  final List<String> _damagePhotos;
  @override
  @JsonKey()
  List<String> get damagePhotos {
    if (_damagePhotos is EqualUnmodifiableListView) return _damagePhotos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_damagePhotos);
  }

  @override
  final DateTime submittedAt;

  /// Create a copy of PodSubmission
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PodSubmissionCopyWith<_PodSubmission> get copyWith =>
      __$PodSubmissionCopyWithImpl<_PodSubmission>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PodSubmissionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PodSubmission &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.lrPhotoPath, lrPhotoPath) ||
                other.lrPhotoPath == lrPhotoPath) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.consigneeName, consigneeName) ||
                other.consigneeName == consigneeName) &&
            (identical(other.hasDamageOrShortage, hasDamageOrShortage) ||
                other.hasDamageOrShortage == hasDamageOrShortage) &&
            (identical(other.damageRemark, damageRemark) ||
                other.damageRemark == damageRemark) &&
            (identical(other.damageQty, damageQty) ||
                other.damageQty == damageQty) &&
            const DeepCollectionEquality()
                .equals(other.damagePhotos, _damagePhotos) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        tripId,
        lrPhotoPath,
        method,
        consigneeName,
        hasDamageOrShortage,
        damageRemark,
        damageQty,
        const DeepCollectionEquality().hash(_damagePhotos),
        submittedAt);
  }

  @override
  String toString() {
    return 'PodSubmission(tripId: $tripId, lrPhotoPath: $lrPhotoPath, method: $method, consigneeName: $consigneeName, hasDamageOrShortage: $hasDamageOrShortage, damageRemark: $damageRemark, damageQty: $damageQty, damagePhotos: $damagePhotos, submittedAt: $submittedAt)';
  }
}

/// @nodoc
abstract mixin class _$PodSubmissionCopyWith<$Res>
    implements $PodSubmissionCopyWith<$Res> {
  factory _$PodSubmissionCopyWith(
          _PodSubmission value, $Res Function(_PodSubmission) _then) =
      __$PodSubmissionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String tripId,
      String lrPhotoPath,
      PodMethod method,
      String? consigneeName,
      bool hasDamageOrShortage,
      String? damageRemark,
      int? damageQty,
      List<String> damagePhotos,
      DateTime submittedAt});
}

/// @nodoc
class __$PodSubmissionCopyWithImpl<$Res>
    implements _$PodSubmissionCopyWith<$Res> {
  __$PodSubmissionCopyWithImpl(this._self, this._then);

  final _PodSubmission _self;
  final $Res Function(_PodSubmission) _then;

  /// Create a copy of PodSubmission
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tripId = null,
    Object? lrPhotoPath = null,
    Object? method = null,
    Object? consigneeName = freezed,
    Object? hasDamageOrShortage = null,
    Object? damageRemark = freezed,
    Object? damageQty = freezed,
    Object? damagePhotos = null,
    Object? submittedAt = null,
  }) {
    return _then(_PodSubmission(
      tripId: null == tripId
          ? _self.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as String,
      lrPhotoPath: null == lrPhotoPath
          ? _self.lrPhotoPath
          : lrPhotoPath // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _self.method
          : method // ignore: cast_nullable_to_non_nullable
              as PodMethod,
      consigneeName: freezed == consigneeName
          ? _self.consigneeName
          : consigneeName // ignore: cast_nullable_to_non_nullable
              as String?,
      hasDamageOrShortage: null == hasDamageOrShortage
          ? _self.hasDamageOrShortage
          : hasDamageOrShortage // ignore: cast_nullable_to_non_nullable
              as bool,
      damageRemark: freezed == damageRemark
          ? _self.damageRemark
          : damageRemark // ignore: cast_nullable_to_non_nullable
              as String?,
      damageQty: freezed == damageQty
          ? _self.damageQty
          : damageQty // ignore: cast_nullable_to_non_nullable
              as int?,
      damagePhotos: null == damagePhotos
          ? _self._damagePhotos
          : damagePhotos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      submittedAt: null == submittedAt
          ? _self.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
