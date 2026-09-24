// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExceptionItem {
  String get id;
  ExceptionType get type;
  String get tripId;
  String get vehicleReg;
  String get driverName;
  String get driverPhone;
  ExceptionSeverity get severity;
  String get message;
  DateTime get at;
  bool get resolved;
  String? get resolutionNote;

  /// Create a copy of ExceptionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExceptionItemCopyWith<ExceptionItem> get copyWith =>
      _$ExceptionItemCopyWithImpl<ExceptionItem>(
          this as ExceptionItem, _$identity);

  /// Serializes this ExceptionItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as ExceptionItem;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExceptionItem &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.type, _this.type) || other.type == _this.type) &&
            (identical(other.tripId, _this.tripId) ||
                other.tripId == _this.tripId) &&
            (identical(other.vehicleReg, _this.vehicleReg) ||
                other.vehicleReg == _this.vehicleReg) &&
            (identical(other.driverName, _this.driverName) ||
                other.driverName == _this.driverName) &&
            (identical(other.driverPhone, _this.driverPhone) ||
                other.driverPhone == _this.driverPhone) &&
            (identical(other.severity, _this.severity) ||
                other.severity == _this.severity) &&
            (identical(other.message, _this.message) ||
                other.message == _this.message) &&
            (identical(other.at, _this.at) || other.at == _this.at) &&
            (identical(other.resolved, _this.resolved) ||
                other.resolved == _this.resolved) &&
            (identical(other.resolutionNote, _this.resolutionNote) ||
                other.resolutionNote == _this.resolutionNote));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as ExceptionItem;
    return Object.hash(
        runtimeType,
        _this.id,
        _this.type,
        _this.tripId,
        _this.vehicleReg,
        _this.driverName,
        _this.driverPhone,
        _this.severity,
        _this.message,
        _this.at,
        _this.resolved,
        _this.resolutionNote);
  }

  @override
  String toString() {
    final _this = this as ExceptionItem;
    return 'ExceptionItem(id: ${_this.id}, type: ${_this.type}, tripId: ${_this.tripId}, vehicleReg: ${_this.vehicleReg}, driverName: ${_this.driverName}, driverPhone: ${_this.driverPhone}, severity: ${_this.severity}, message: ${_this.message}, at: ${_this.at}, resolved: ${_this.resolved}, resolutionNote: ${_this.resolutionNote})';
  }
}

/// @nodoc
abstract mixin class $ExceptionItemCopyWith<$Res> {
  factory $ExceptionItemCopyWith(
          ExceptionItem value, $Res Function(ExceptionItem) _then) =
      _$ExceptionItemCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      ExceptionType type,
      String tripId,
      String vehicleReg,
      String driverName,
      String driverPhone,
      ExceptionSeverity severity,
      String message,
      DateTime at,
      bool resolved,
      String? resolutionNote});
}

/// @nodoc
class _$ExceptionItemCopyWithImpl<$Res>
    implements $ExceptionItemCopyWith<$Res> {
  _$ExceptionItemCopyWithImpl(this._self, this._then);

  final ExceptionItem _self;
  final $Res Function(ExceptionItem) _then;

  /// Create a copy of ExceptionItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? tripId = null,
    Object? vehicleReg = null,
    Object? driverName = null,
    Object? driverPhone = null,
    Object? severity = null,
    Object? message = null,
    Object? at = null,
    Object? resolved = null,
    Object? resolutionNote = freezed,
  }) {
    return _then(ExceptionItem(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExceptionType,
      tripId: null == tripId
          ? _self.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleReg: null == vehicleReg
          ? _self.vehicleReg
          : vehicleReg // ignore: cast_nullable_to_non_nullable
              as String,
      driverName: null == driverName
          ? _self.driverName
          : driverName // ignore: cast_nullable_to_non_nullable
              as String,
      driverPhone: null == driverPhone
          ? _self.driverPhone
          : driverPhone // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as ExceptionSeverity,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      at: null == at
          ? _self.at
          : at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      resolved: null == resolved
          ? _self.resolved
          : resolved // ignore: cast_nullable_to_non_nullable
              as bool,
      resolutionNote: freezed == resolutionNote
          ? _self.resolutionNote
          : resolutionNote // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExceptionItem].
extension ExceptionItemPatterns on ExceptionItem {
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
    TResult Function(_ExceptionItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExceptionItem() when $default != null:
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
    TResult Function(_ExceptionItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExceptionItem():
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
    TResult? Function(_ExceptionItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExceptionItem() when $default != null:
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
            ExceptionType type,
            String tripId,
            String vehicleReg,
            String driverName,
            String driverPhone,
            ExceptionSeverity severity,
            String message,
            DateTime at,
            bool resolved,
            String? resolutionNote)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExceptionItem() when $default != null:
        return $default(
            _that.id,
            _that.type,
            _that.tripId,
            _that.vehicleReg,
            _that.driverName,
            _that.driverPhone,
            _that.severity,
            _that.message,
            _that.at,
            _that.resolved,
            _that.resolutionNote);
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
            ExceptionType type,
            String tripId,
            String vehicleReg,
            String driverName,
            String driverPhone,
            ExceptionSeverity severity,
            String message,
            DateTime at,
            bool resolved,
            String? resolutionNote)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExceptionItem():
        return $default(
            _that.id,
            _that.type,
            _that.tripId,
            _that.vehicleReg,
            _that.driverName,
            _that.driverPhone,
            _that.severity,
            _that.message,
            _that.at,
            _that.resolved,
            _that.resolutionNote);
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
            ExceptionType type,
            String tripId,
            String vehicleReg,
            String driverName,
            String driverPhone,
            ExceptionSeverity severity,
            String message,
            DateTime at,
            bool resolved,
            String? resolutionNote)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExceptionItem() when $default != null:
        return $default(
            _that.id,
            _that.type,
            _that.tripId,
            _that.vehicleReg,
            _that.driverName,
            _that.driverPhone,
            _that.severity,
            _that.message,
            _that.at,
            _that.resolved,
            _that.resolutionNote);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExceptionItem implements ExceptionItem {
  const _ExceptionItem(
      {required this.id,
      required this.type,
      required this.tripId,
      required this.vehicleReg,
      required this.driverName,
      required this.driverPhone,
      this.severity = ExceptionSeverity.medium,
      required this.message,
      required this.at,
      this.resolved = false,
      this.resolutionNote});
  factory _ExceptionItem.fromJson(Map<String, dynamic> json) =>
      _$ExceptionItemFromJson(json);

  @override
  final String id;
  @override
  final ExceptionType type;
  @override
  final String tripId;
  @override
  final String vehicleReg;
  @override
  final String driverName;
  @override
  final String driverPhone;
  @override
  @JsonKey()
  final ExceptionSeverity severity;
  @override
  final String message;
  @override
  final DateTime at;
  @override
  @JsonKey()
  final bool resolved;
  @override
  final String? resolutionNote;

  /// Create a copy of ExceptionItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExceptionItemCopyWith<_ExceptionItem> get copyWith =>
      __$ExceptionItemCopyWithImpl<_ExceptionItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExceptionItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExceptionItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.vehicleReg, vehicleReg) ||
                other.vehicleReg == vehicleReg) &&
            (identical(other.driverName, driverName) ||
                other.driverName == driverName) &&
            (identical(other.driverPhone, driverPhone) ||
                other.driverPhone == driverPhone) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.at, at) || other.at == at) &&
            (identical(other.resolved, resolved) ||
                other.resolved == resolved) &&
            (identical(other.resolutionNote, resolutionNote) ||
                other.resolutionNote == resolutionNote));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, id, type, tripId, vehicleReg, driverName,
        driverPhone, severity, message, at, resolved, resolutionNote);
  }

  @override
  String toString() {
    return 'ExceptionItem(id: $id, type: $type, tripId: $tripId, vehicleReg: $vehicleReg, driverName: $driverName, driverPhone: $driverPhone, severity: $severity, message: $message, at: $at, resolved: $resolved, resolutionNote: $resolutionNote)';
  }
}

/// @nodoc
abstract mixin class _$ExceptionItemCopyWith<$Res>
    implements $ExceptionItemCopyWith<$Res> {
  factory _$ExceptionItemCopyWith(
          _ExceptionItem value, $Res Function(_ExceptionItem) _then) =
      __$ExceptionItemCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      ExceptionType type,
      String tripId,
      String vehicleReg,
      String driverName,
      String driverPhone,
      ExceptionSeverity severity,
      String message,
      DateTime at,
      bool resolved,
      String? resolutionNote});
}

/// @nodoc
class __$ExceptionItemCopyWithImpl<$Res>
    implements _$ExceptionItemCopyWith<$Res> {
  __$ExceptionItemCopyWithImpl(this._self, this._then);

  final _ExceptionItem _self;
  final $Res Function(_ExceptionItem) _then;

  /// Create a copy of ExceptionItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? tripId = null,
    Object? vehicleReg = null,
    Object? driverName = null,
    Object? driverPhone = null,
    Object? severity = null,
    Object? message = null,
    Object? at = null,
    Object? resolved = null,
    Object? resolutionNote = freezed,
  }) {
    return _then(_ExceptionItem(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExceptionType,
      tripId: null == tripId
          ? _self.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleReg: null == vehicleReg
          ? _self.vehicleReg
          : vehicleReg // ignore: cast_nullable_to_non_nullable
              as String,
      driverName: null == driverName
          ? _self.driverName
          : driverName // ignore: cast_nullable_to_non_nullable
              as String,
      driverPhone: null == driverPhone
          ? _self.driverPhone
          : driverPhone // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as ExceptionSeverity,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      at: null == at
          ? _self.at
          : at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      resolved: null == resolved
          ? _self.resolved
          : resolved // ignore: cast_nullable_to_non_nullable
              as bool,
      resolutionNote: freezed == resolutionNote
          ? _self.resolutionNote
          : resolutionNote // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
