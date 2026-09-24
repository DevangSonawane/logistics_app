// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Driver {
  String get id;
  String get name;
  String get phone;
  String get licenseNo;
  DateTime get licenseExpiry;
  double get rating;
  int get onTimePct;
  List<String> get languages;
  String? get vehicleReg;

  /// Create a copy of Driver
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DriverCopyWith<Driver> get copyWith =>
      _$DriverCopyWithImpl<Driver>(this as Driver, _$identity);

  /// Serializes this Driver to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as Driver;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Driver &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.name, _this.name) || other.name == _this.name) &&
            (identical(other.phone, _this.phone) ||
                other.phone == _this.phone) &&
            (identical(other.licenseNo, _this.licenseNo) ||
                other.licenseNo == _this.licenseNo) &&
            (identical(other.licenseExpiry, _this.licenseExpiry) ||
                other.licenseExpiry == _this.licenseExpiry) &&
            (identical(other.rating, _this.rating) ||
                other.rating == _this.rating) &&
            (identical(other.onTimePct, _this.onTimePct) ||
                other.onTimePct == _this.onTimePct) &&
            const DeepCollectionEquality()
                .equals(other.languages, _this.languages) &&
            (identical(other.vehicleReg, _this.vehicleReg) ||
                other.vehicleReg == _this.vehicleReg));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as Driver;
    return Object.hash(
        runtimeType,
        _this.id,
        _this.name,
        _this.phone,
        _this.licenseNo,
        _this.licenseExpiry,
        _this.rating,
        _this.onTimePct,
        const DeepCollectionEquality().hash(_this.languages),
        _this.vehicleReg);
  }

  @override
  String toString() {
    final _this = this as Driver;
    return 'Driver(id: ${_this.id}, name: ${_this.name}, phone: ${_this.phone}, licenseNo: ${_this.licenseNo}, licenseExpiry: ${_this.licenseExpiry}, rating: ${_this.rating}, onTimePct: ${_this.onTimePct}, languages: ${_this.languages}, vehicleReg: ${_this.vehicleReg})';
  }
}

/// @nodoc
abstract mixin class $DriverCopyWith<$Res> {
  factory $DriverCopyWith(Driver value, $Res Function(Driver) _then) =
      _$DriverCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String phone,
      String licenseNo,
      DateTime licenseExpiry,
      double rating,
      int onTimePct,
      List<String> languages,
      String? vehicleReg});
}

/// @nodoc
class _$DriverCopyWithImpl<$Res> implements $DriverCopyWith<$Res> {
  _$DriverCopyWithImpl(this._self, this._then);

  final Driver _self;
  final $Res Function(Driver) _then;

  /// Create a copy of Driver
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? licenseNo = null,
    Object? licenseExpiry = null,
    Object? rating = null,
    Object? onTimePct = null,
    Object? languages = null,
    Object? vehicleReg = freezed,
  }) {
    return _then(Driver(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      licenseNo: null == licenseNo
          ? _self.licenseNo
          : licenseNo // ignore: cast_nullable_to_non_nullable
              as String,
      licenseExpiry: null == licenseExpiry
          ? _self.licenseExpiry
          : licenseExpiry // ignore: cast_nullable_to_non_nullable
              as DateTime,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      onTimePct: null == onTimePct
          ? _self.onTimePct
          : onTimePct // ignore: cast_nullable_to_non_nullable
              as int,
      languages: null == languages
          ? _self.languages
          : languages // ignore: cast_nullable_to_non_nullable
              as List<String>,
      vehicleReg: freezed == vehicleReg
          ? _self.vehicleReg
          : vehicleReg // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Driver].
extension DriverPatterns on Driver {
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
    TResult Function(_Driver value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Driver() when $default != null:
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
    TResult Function(_Driver value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Driver():
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
    TResult? Function(_Driver value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Driver() when $default != null:
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
            String name,
            String phone,
            String licenseNo,
            DateTime licenseExpiry,
            double rating,
            int onTimePct,
            List<String> languages,
            String? vehicleReg)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Driver() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.phone,
            _that.licenseNo,
            _that.licenseExpiry,
            _that.rating,
            _that.onTimePct,
            _that.languages,
            _that.vehicleReg);
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
            String name,
            String phone,
            String licenseNo,
            DateTime licenseExpiry,
            double rating,
            int onTimePct,
            List<String> languages,
            String? vehicleReg)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Driver():
        return $default(
            _that.id,
            _that.name,
            _that.phone,
            _that.licenseNo,
            _that.licenseExpiry,
            _that.rating,
            _that.onTimePct,
            _that.languages,
            _that.vehicleReg);
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
            String name,
            String phone,
            String licenseNo,
            DateTime licenseExpiry,
            double rating,
            int onTimePct,
            List<String> languages,
            String? vehicleReg)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Driver() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.phone,
            _that.licenseNo,
            _that.licenseExpiry,
            _that.rating,
            _that.onTimePct,
            _that.languages,
            _that.vehicleReg);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Driver implements Driver {
  const _Driver(
      {required this.id,
      required this.name,
      required this.phone,
      required this.licenseNo,
      required this.licenseExpiry,
      this.rating = 0,
      this.onTimePct = 0,
      List<String> languages = const [],
      this.vehicleReg})
      : _languages = languages;
  factory _Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String phone;
  @override
  final String licenseNo;
  @override
  final DateTime licenseExpiry;
  @override
  @JsonKey()
  final double rating;
  @override
  @JsonKey()
  final int onTimePct;
  final List<String> _languages;
  @override
  @JsonKey()
  List<String> get languages {
    if (_languages is EqualUnmodifiableListView) return _languages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_languages);
  }

  @override
  final String? vehicleReg;

  /// Create a copy of Driver
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DriverCopyWith<_Driver> get copyWith =>
      __$DriverCopyWithImpl<_Driver>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DriverToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Driver &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.licenseNo, licenseNo) ||
                other.licenseNo == licenseNo) &&
            (identical(other.licenseExpiry, licenseExpiry) ||
                other.licenseExpiry == licenseExpiry) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.onTimePct, onTimePct) ||
                other.onTimePct == onTimePct) &&
            const DeepCollectionEquality()
                .equals(other.languages, _languages) &&
            (identical(other.vehicleReg, vehicleReg) ||
                other.vehicleReg == vehicleReg));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        id,
        name,
        phone,
        licenseNo,
        licenseExpiry,
        rating,
        onTimePct,
        const DeepCollectionEquality().hash(_languages),
        vehicleReg);
  }

  @override
  String toString() {
    return 'Driver(id: $id, name: $name, phone: $phone, licenseNo: $licenseNo, licenseExpiry: $licenseExpiry, rating: $rating, onTimePct: $onTimePct, languages: $languages, vehicleReg: $vehicleReg)';
  }
}

/// @nodoc
abstract mixin class _$DriverCopyWith<$Res> implements $DriverCopyWith<$Res> {
  factory _$DriverCopyWith(_Driver value, $Res Function(_Driver) _then) =
      __$DriverCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String phone,
      String licenseNo,
      DateTime licenseExpiry,
      double rating,
      int onTimePct,
      List<String> languages,
      String? vehicleReg});
}

/// @nodoc
class __$DriverCopyWithImpl<$Res> implements _$DriverCopyWith<$Res> {
  __$DriverCopyWithImpl(this._self, this._then);

  final _Driver _self;
  final $Res Function(_Driver) _then;

  /// Create a copy of Driver
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? licenseNo = null,
    Object? licenseExpiry = null,
    Object? rating = null,
    Object? onTimePct = null,
    Object? languages = null,
    Object? vehicleReg = freezed,
  }) {
    return _then(_Driver(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      licenseNo: null == licenseNo
          ? _self.licenseNo
          : licenseNo // ignore: cast_nullable_to_non_nullable
              as String,
      licenseExpiry: null == licenseExpiry
          ? _self.licenseExpiry
          : licenseExpiry // ignore: cast_nullable_to_non_nullable
              as DateTime,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      onTimePct: null == onTimePct
          ? _self.onTimePct
          : onTimePct // ignore: cast_nullable_to_non_nullable
              as int,
      languages: null == languages
          ? _self._languages
          : languages // ignore: cast_nullable_to_non_nullable
              as List<String>,
      vehicleReg: freezed == vehicleReg
          ? _self.vehicleReg
          : vehicleReg // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$AllowanceEntry {
  String get tripNo;
  String get lane;
  int get amount;
  DateTime get date;

  /// Create a copy of AllowanceEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AllowanceEntryCopyWith<AllowanceEntry> get copyWith =>
      _$AllowanceEntryCopyWithImpl<AllowanceEntry>(
          this as AllowanceEntry, _$identity);

  /// Serializes this AllowanceEntry to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as AllowanceEntry;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AllowanceEntry &&
            (identical(other.tripNo, _this.tripNo) ||
                other.tripNo == _this.tripNo) &&
            (identical(other.lane, _this.lane) || other.lane == _this.lane) &&
            (identical(other.amount, _this.amount) ||
                other.amount == _this.amount) &&
            (identical(other.date, _this.date) || other.date == _this.date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as AllowanceEntry;
    return Object.hash(
        runtimeType, _this.tripNo, _this.lane, _this.amount, _this.date);
  }

  @override
  String toString() {
    final _this = this as AllowanceEntry;
    return 'AllowanceEntry(tripNo: ${_this.tripNo}, lane: ${_this.lane}, amount: ${_this.amount}, date: ${_this.date})';
  }
}

/// @nodoc
abstract mixin class $AllowanceEntryCopyWith<$Res> {
  factory $AllowanceEntryCopyWith(
          AllowanceEntry value, $Res Function(AllowanceEntry) _then) =
      _$AllowanceEntryCopyWithImpl;
  @useResult
  $Res call({String tripNo, String lane, int amount, DateTime date});
}

/// @nodoc
class _$AllowanceEntryCopyWithImpl<$Res>
    implements $AllowanceEntryCopyWith<$Res> {
  _$AllowanceEntryCopyWithImpl(this._self, this._then);

  final AllowanceEntry _self;
  final $Res Function(AllowanceEntry) _then;

  /// Create a copy of AllowanceEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripNo = null,
    Object? lane = null,
    Object? amount = null,
    Object? date = null,
  }) {
    return _then(AllowanceEntry(
      tripNo: null == tripNo
          ? _self.tripNo
          : tripNo // ignore: cast_nullable_to_non_nullable
              as String,
      lane: null == lane
          ? _self.lane
          : lane // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [AllowanceEntry].
extension AllowanceEntryPatterns on AllowanceEntry {
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
    TResult Function(_AllowanceEntry value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AllowanceEntry() when $default != null:
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
    TResult Function(_AllowanceEntry value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AllowanceEntry():
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
    TResult? Function(_AllowanceEntry value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AllowanceEntry() when $default != null:
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
    TResult Function(String tripNo, String lane, int amount, DateTime date)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AllowanceEntry() when $default != null:
        return $default(_that.tripNo, _that.lane, _that.amount, _that.date);
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
    TResult Function(String tripNo, String lane, int amount, DateTime date)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AllowanceEntry():
        return $default(_that.tripNo, _that.lane, _that.amount, _that.date);
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
    TResult? Function(String tripNo, String lane, int amount, DateTime date)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AllowanceEntry() when $default != null:
        return $default(_that.tripNo, _that.lane, _that.amount, _that.date);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AllowanceEntry implements AllowanceEntry {
  const _AllowanceEntry(
      {required this.tripNo,
      required this.lane,
      required this.amount,
      required this.date});
  factory _AllowanceEntry.fromJson(Map<String, dynamic> json) =>
      _$AllowanceEntryFromJson(json);

  @override
  final String tripNo;
  @override
  final String lane;
  @override
  final int amount;
  @override
  final DateTime date;

  /// Create a copy of AllowanceEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AllowanceEntryCopyWith<_AllowanceEntry> get copyWith =>
      __$AllowanceEntryCopyWithImpl<_AllowanceEntry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AllowanceEntryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AllowanceEntry &&
            (identical(other.tripNo, tripNo) || other.tripNo == tripNo) &&
            (identical(other.lane, lane) || other.lane == lane) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, tripNo, lane, amount, date);
  }

  @override
  String toString() {
    return 'AllowanceEntry(tripNo: $tripNo, lane: $lane, amount: $amount, date: $date)';
  }
}

/// @nodoc
abstract mixin class _$AllowanceEntryCopyWith<$Res>
    implements $AllowanceEntryCopyWith<$Res> {
  factory _$AllowanceEntryCopyWith(
          _AllowanceEntry value, $Res Function(_AllowanceEntry) _then) =
      __$AllowanceEntryCopyWithImpl;
  @override
  @useResult
  $Res call({String tripNo, String lane, int amount, DateTime date});
}

/// @nodoc
class __$AllowanceEntryCopyWithImpl<$Res>
    implements _$AllowanceEntryCopyWith<$Res> {
  __$AllowanceEntryCopyWithImpl(this._self, this._then);

  final _AllowanceEntry _self;
  final $Res Function(_AllowanceEntry) _then;

  /// Create a copy of AllowanceEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tripNo = null,
    Object? lane = null,
    Object? amount = null,
    Object? date = null,
  }) {
    return _then(_AllowanceEntry(
      tripNo: null == tripNo
          ? _self.tripNo
          : tripNo // ignore: cast_nullable_to_non_nullable
              as String,
      lane: null == lane
          ? _self.lane
          : lane // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
mixin _$SalarySlip {
  String get id;
  String get month;
  int get amount;

  /// Create a copy of SalarySlip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SalarySlipCopyWith<SalarySlip> get copyWith =>
      _$SalarySlipCopyWithImpl<SalarySlip>(this as SalarySlip, _$identity);

  /// Serializes this SalarySlip to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as SalarySlip;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SalarySlip &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.month, _this.month) ||
                other.month == _this.month) &&
            (identical(other.amount, _this.amount) ||
                other.amount == _this.amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as SalarySlip;
    return Object.hash(runtimeType, _this.id, _this.month, _this.amount);
  }

  @override
  String toString() {
    final _this = this as SalarySlip;
    return 'SalarySlip(id: ${_this.id}, month: ${_this.month}, amount: ${_this.amount})';
  }
}

/// @nodoc
abstract mixin class $SalarySlipCopyWith<$Res> {
  factory $SalarySlipCopyWith(
          SalarySlip value, $Res Function(SalarySlip) _then) =
      _$SalarySlipCopyWithImpl;
  @useResult
  $Res call({String id, String month, int amount});
}

/// @nodoc
class _$SalarySlipCopyWithImpl<$Res> implements $SalarySlipCopyWith<$Res> {
  _$SalarySlipCopyWithImpl(this._self, this._then);

  final SalarySlip _self;
  final $Res Function(SalarySlip) _then;

  /// Create a copy of SalarySlip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? month = null,
    Object? amount = null,
  }) {
    return _then(SalarySlip(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _self.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [SalarySlip].
extension SalarySlipPatterns on SalarySlip {
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
    TResult Function(_SalarySlip value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SalarySlip() when $default != null:
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
    TResult Function(_SalarySlip value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SalarySlip():
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
    TResult? Function(_SalarySlip value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SalarySlip() when $default != null:
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
    TResult Function(String id, String month, int amount)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SalarySlip() when $default != null:
        return $default(_that.id, _that.month, _that.amount);
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
    TResult Function(String id, String month, int amount) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SalarySlip():
        return $default(_that.id, _that.month, _that.amount);
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
    TResult? Function(String id, String month, int amount)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SalarySlip() when $default != null:
        return $default(_that.id, _that.month, _that.amount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SalarySlip implements SalarySlip {
  const _SalarySlip(
      {required this.id, required this.month, required this.amount});
  factory _SalarySlip.fromJson(Map<String, dynamic> json) =>
      _$SalarySlipFromJson(json);

  @override
  final String id;
  @override
  final String month;
  @override
  final int amount;

  /// Create a copy of SalarySlip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SalarySlipCopyWith<_SalarySlip> get copyWith =>
      __$SalarySlipCopyWithImpl<_SalarySlip>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SalarySlipToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SalarySlip &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, id, month, amount);
  }

  @override
  String toString() {
    return 'SalarySlip(id: $id, month: $month, amount: $amount)';
  }
}

/// @nodoc
abstract mixin class _$SalarySlipCopyWith<$Res>
    implements $SalarySlipCopyWith<$Res> {
  factory _$SalarySlipCopyWith(
          _SalarySlip value, $Res Function(_SalarySlip) _then) =
      __$SalarySlipCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String month, int amount});
}

/// @nodoc
class __$SalarySlipCopyWithImpl<$Res> implements _$SalarySlipCopyWith<$Res> {
  __$SalarySlipCopyWithImpl(this._self, this._then);

  final _SalarySlip _self;
  final $Res Function(_SalarySlip) _then;

  /// Create a copy of SalarySlip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? month = null,
    Object? amount = null,
  }) {
    return _then(_SalarySlip(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _self.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$EarningsSummary {
  int get monthTotal;
  List<AllowanceEntry> get allowances;
  int get incentives;
  int get advanceTaken;
  int get expensesTotal;
  int get settlementBalance;
  int get tripsDone;
  int get onTimePct;
  List<SalarySlip> get slips;

  /// Create a copy of EarningsSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EarningsSummaryCopyWith<EarningsSummary> get copyWith =>
      _$EarningsSummaryCopyWithImpl<EarningsSummary>(
          this as EarningsSummary, _$identity);

  /// Serializes this EarningsSummary to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as EarningsSummary;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EarningsSummary &&
            (identical(other.monthTotal, _this.monthTotal) ||
                other.monthTotal == _this.monthTotal) &&
            const DeepCollectionEquality()
                .equals(other.allowances, _this.allowances) &&
            (identical(other.incentives, _this.incentives) ||
                other.incentives == _this.incentives) &&
            (identical(other.advanceTaken, _this.advanceTaken) ||
                other.advanceTaken == _this.advanceTaken) &&
            (identical(other.expensesTotal, _this.expensesTotal) ||
                other.expensesTotal == _this.expensesTotal) &&
            (identical(other.settlementBalance, _this.settlementBalance) ||
                other.settlementBalance == _this.settlementBalance) &&
            (identical(other.tripsDone, _this.tripsDone) ||
                other.tripsDone == _this.tripsDone) &&
            (identical(other.onTimePct, _this.onTimePct) ||
                other.onTimePct == _this.onTimePct) &&
            const DeepCollectionEquality().equals(other.slips, _this.slips));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as EarningsSummary;
    return Object.hash(
        runtimeType,
        _this.monthTotal,
        const DeepCollectionEquality().hash(_this.allowances),
        _this.incentives,
        _this.advanceTaken,
        _this.expensesTotal,
        _this.settlementBalance,
        _this.tripsDone,
        _this.onTimePct,
        const DeepCollectionEquality().hash(_this.slips));
  }

  @override
  String toString() {
    final _this = this as EarningsSummary;
    return 'EarningsSummary(monthTotal: ${_this.monthTotal}, allowances: ${_this.allowances}, incentives: ${_this.incentives}, advanceTaken: ${_this.advanceTaken}, expensesTotal: ${_this.expensesTotal}, settlementBalance: ${_this.settlementBalance}, tripsDone: ${_this.tripsDone}, onTimePct: ${_this.onTimePct}, slips: ${_this.slips})';
  }
}

/// @nodoc
abstract mixin class $EarningsSummaryCopyWith<$Res> {
  factory $EarningsSummaryCopyWith(
          EarningsSummary value, $Res Function(EarningsSummary) _then) =
      _$EarningsSummaryCopyWithImpl;
  @useResult
  $Res call(
      {int monthTotal,
      List<AllowanceEntry> allowances,
      int incentives,
      int advanceTaken,
      int expensesTotal,
      int settlementBalance,
      int tripsDone,
      int onTimePct,
      List<SalarySlip> slips});
}

/// @nodoc
class _$EarningsSummaryCopyWithImpl<$Res>
    implements $EarningsSummaryCopyWith<$Res> {
  _$EarningsSummaryCopyWithImpl(this._self, this._then);

  final EarningsSummary _self;
  final $Res Function(EarningsSummary) _then;

  /// Create a copy of EarningsSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthTotal = null,
    Object? allowances = null,
    Object? incentives = null,
    Object? advanceTaken = null,
    Object? expensesTotal = null,
    Object? settlementBalance = null,
    Object? tripsDone = null,
    Object? onTimePct = null,
    Object? slips = null,
  }) {
    return _then(EarningsSummary(
      monthTotal: null == monthTotal
          ? _self.monthTotal
          : monthTotal // ignore: cast_nullable_to_non_nullable
              as int,
      allowances: null == allowances
          ? _self.allowances
          : allowances // ignore: cast_nullable_to_non_nullable
              as List<AllowanceEntry>,
      incentives: null == incentives
          ? _self.incentives
          : incentives // ignore: cast_nullable_to_non_nullable
              as int,
      advanceTaken: null == advanceTaken
          ? _self.advanceTaken
          : advanceTaken // ignore: cast_nullable_to_non_nullable
              as int,
      expensesTotal: null == expensesTotal
          ? _self.expensesTotal
          : expensesTotal // ignore: cast_nullable_to_non_nullable
              as int,
      settlementBalance: null == settlementBalance
          ? _self.settlementBalance
          : settlementBalance // ignore: cast_nullable_to_non_nullable
              as int,
      tripsDone: null == tripsDone
          ? _self.tripsDone
          : tripsDone // ignore: cast_nullable_to_non_nullable
              as int,
      onTimePct: null == onTimePct
          ? _self.onTimePct
          : onTimePct // ignore: cast_nullable_to_non_nullable
              as int,
      slips: null == slips
          ? _self.slips
          : slips // ignore: cast_nullable_to_non_nullable
              as List<SalarySlip>,
    ));
  }
}

/// Adds pattern-matching-related methods to [EarningsSummary].
extension EarningsSummaryPatterns on EarningsSummary {
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
    TResult Function(_EarningsSummary value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EarningsSummary() when $default != null:
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
    TResult Function(_EarningsSummary value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EarningsSummary():
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
    TResult? Function(_EarningsSummary value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EarningsSummary() when $default != null:
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
            int monthTotal,
            List<AllowanceEntry> allowances,
            int incentives,
            int advanceTaken,
            int expensesTotal,
            int settlementBalance,
            int tripsDone,
            int onTimePct,
            List<SalarySlip> slips)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EarningsSummary() when $default != null:
        return $default(
            _that.monthTotal,
            _that.allowances,
            _that.incentives,
            _that.advanceTaken,
            _that.expensesTotal,
            _that.settlementBalance,
            _that.tripsDone,
            _that.onTimePct,
            _that.slips);
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
            int monthTotal,
            List<AllowanceEntry> allowances,
            int incentives,
            int advanceTaken,
            int expensesTotal,
            int settlementBalance,
            int tripsDone,
            int onTimePct,
            List<SalarySlip> slips)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EarningsSummary():
        return $default(
            _that.monthTotal,
            _that.allowances,
            _that.incentives,
            _that.advanceTaken,
            _that.expensesTotal,
            _that.settlementBalance,
            _that.tripsDone,
            _that.onTimePct,
            _that.slips);
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
            int monthTotal,
            List<AllowanceEntry> allowances,
            int incentives,
            int advanceTaken,
            int expensesTotal,
            int settlementBalance,
            int tripsDone,
            int onTimePct,
            List<SalarySlip> slips)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EarningsSummary() when $default != null:
        return $default(
            _that.monthTotal,
            _that.allowances,
            _that.incentives,
            _that.advanceTaken,
            _that.expensesTotal,
            _that.settlementBalance,
            _that.tripsDone,
            _that.onTimePct,
            _that.slips);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EarningsSummary implements EarningsSummary {
  const _EarningsSummary(
      {required this.monthTotal,
      List<AllowanceEntry> allowances = const [],
      this.incentives = 0,
      this.advanceTaken = 0,
      this.expensesTotal = 0,
      this.settlementBalance = 0,
      this.tripsDone = 0,
      this.onTimePct = 0,
      List<SalarySlip> slips = const []})
      : _allowances = allowances,
        _slips = slips;
  factory _EarningsSummary.fromJson(Map<String, dynamic> json) =>
      _$EarningsSummaryFromJson(json);

  @override
  final int monthTotal;
  final List<AllowanceEntry> _allowances;
  @override
  @JsonKey()
  List<AllowanceEntry> get allowances {
    if (_allowances is EqualUnmodifiableListView) return _allowances;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowances);
  }

  @override
  @JsonKey()
  final int incentives;
  @override
  @JsonKey()
  final int advanceTaken;
  @override
  @JsonKey()
  final int expensesTotal;
  @override
  @JsonKey()
  final int settlementBalance;
  @override
  @JsonKey()
  final int tripsDone;
  @override
  @JsonKey()
  final int onTimePct;
  final List<SalarySlip> _slips;
  @override
  @JsonKey()
  List<SalarySlip> get slips {
    if (_slips is EqualUnmodifiableListView) return _slips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_slips);
  }

  /// Create a copy of EarningsSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EarningsSummaryCopyWith<_EarningsSummary> get copyWith =>
      __$EarningsSummaryCopyWithImpl<_EarningsSummary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EarningsSummaryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EarningsSummary &&
            (identical(other.monthTotal, monthTotal) ||
                other.monthTotal == monthTotal) &&
            const DeepCollectionEquality()
                .equals(other.allowances, _allowances) &&
            (identical(other.incentives, incentives) ||
                other.incentives == incentives) &&
            (identical(other.advanceTaken, advanceTaken) ||
                other.advanceTaken == advanceTaken) &&
            (identical(other.expensesTotal, expensesTotal) ||
                other.expensesTotal == expensesTotal) &&
            (identical(other.settlementBalance, settlementBalance) ||
                other.settlementBalance == settlementBalance) &&
            (identical(other.tripsDone, tripsDone) ||
                other.tripsDone == tripsDone) &&
            (identical(other.onTimePct, onTimePct) ||
                other.onTimePct == onTimePct) &&
            const DeepCollectionEquality().equals(other.slips, _slips));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        monthTotal,
        const DeepCollectionEquality().hash(_allowances),
        incentives,
        advanceTaken,
        expensesTotal,
        settlementBalance,
        tripsDone,
        onTimePct,
        const DeepCollectionEquality().hash(_slips));
  }

  @override
  String toString() {
    return 'EarningsSummary(monthTotal: $monthTotal, allowances: $allowances, incentives: $incentives, advanceTaken: $advanceTaken, expensesTotal: $expensesTotal, settlementBalance: $settlementBalance, tripsDone: $tripsDone, onTimePct: $onTimePct, slips: $slips)';
  }
}

/// @nodoc
abstract mixin class _$EarningsSummaryCopyWith<$Res>
    implements $EarningsSummaryCopyWith<$Res> {
  factory _$EarningsSummaryCopyWith(
          _EarningsSummary value, $Res Function(_EarningsSummary) _then) =
      __$EarningsSummaryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int monthTotal,
      List<AllowanceEntry> allowances,
      int incentives,
      int advanceTaken,
      int expensesTotal,
      int settlementBalance,
      int tripsDone,
      int onTimePct,
      List<SalarySlip> slips});
}

/// @nodoc
class __$EarningsSummaryCopyWithImpl<$Res>
    implements _$EarningsSummaryCopyWith<$Res> {
  __$EarningsSummaryCopyWithImpl(this._self, this._then);

  final _EarningsSummary _self;
  final $Res Function(_EarningsSummary) _then;

  /// Create a copy of EarningsSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? monthTotal = null,
    Object? allowances = null,
    Object? incentives = null,
    Object? advanceTaken = null,
    Object? expensesTotal = null,
    Object? settlementBalance = null,
    Object? tripsDone = null,
    Object? onTimePct = null,
    Object? slips = null,
  }) {
    return _then(_EarningsSummary(
      monthTotal: null == monthTotal
          ? _self.monthTotal
          : monthTotal // ignore: cast_nullable_to_non_nullable
              as int,
      allowances: null == allowances
          ? _self._allowances
          : allowances // ignore: cast_nullable_to_non_nullable
              as List<AllowanceEntry>,
      incentives: null == incentives
          ? _self.incentives
          : incentives // ignore: cast_nullable_to_non_nullable
              as int,
      advanceTaken: null == advanceTaken
          ? _self.advanceTaken
          : advanceTaken // ignore: cast_nullable_to_non_nullable
              as int,
      expensesTotal: null == expensesTotal
          ? _self.expensesTotal
          : expensesTotal // ignore: cast_nullable_to_non_nullable
              as int,
      settlementBalance: null == settlementBalance
          ? _self.settlementBalance
          : settlementBalance // ignore: cast_nullable_to_non_nullable
              as int,
      tripsDone: null == tripsDone
          ? _self.tripsDone
          : tripsDone // ignore: cast_nullable_to_non_nullable
              as int,
      onTimePct: null == onTimePct
          ? _self.onTimePct
          : onTimePct // ignore: cast_nullable_to_non_nullable
              as int,
      slips: null == slips
          ? _self._slips
          : slips // ignore: cast_nullable_to_non_nullable
              as List<SalarySlip>,
    ));
  }
}

// dart format on
