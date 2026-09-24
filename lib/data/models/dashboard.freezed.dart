// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DashboardKpis {
  int get tripsToday;
  int get running;
  int get delayed;
  int get delivered;
  int get revenueToday;
  int get revenueMonth;
  int get collectionsMonth;
  int get outstanding;
  int get cashBank;
  int get utilisationPct;

  /// Create a copy of DashboardKpis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DashboardKpisCopyWith<DashboardKpis> get copyWith =>
      _$DashboardKpisCopyWithImpl<DashboardKpis>(
          this as DashboardKpis, _$identity);

  /// Serializes this DashboardKpis to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as DashboardKpis;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DashboardKpis &&
            (identical(other.tripsToday, _this.tripsToday) ||
                other.tripsToday == _this.tripsToday) &&
            (identical(other.running, _this.running) ||
                other.running == _this.running) &&
            (identical(other.delayed, _this.delayed) ||
                other.delayed == _this.delayed) &&
            (identical(other.delivered, _this.delivered) ||
                other.delivered == _this.delivered) &&
            (identical(other.revenueToday, _this.revenueToday) ||
                other.revenueToday == _this.revenueToday) &&
            (identical(other.revenueMonth, _this.revenueMonth) ||
                other.revenueMonth == _this.revenueMonth) &&
            (identical(other.collectionsMonth, _this.collectionsMonth) ||
                other.collectionsMonth == _this.collectionsMonth) &&
            (identical(other.outstanding, _this.outstanding) ||
                other.outstanding == _this.outstanding) &&
            (identical(other.cashBank, _this.cashBank) ||
                other.cashBank == _this.cashBank) &&
            (identical(other.utilisationPct, _this.utilisationPct) ||
                other.utilisationPct == _this.utilisationPct));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as DashboardKpis;
    return Object.hash(
        runtimeType,
        _this.tripsToday,
        _this.running,
        _this.delayed,
        _this.delivered,
        _this.revenueToday,
        _this.revenueMonth,
        _this.collectionsMonth,
        _this.outstanding,
        _this.cashBank,
        _this.utilisationPct);
  }

  @override
  String toString() {
    final _this = this as DashboardKpis;
    return 'DashboardKpis(tripsToday: ${_this.tripsToday}, running: ${_this.running}, delayed: ${_this.delayed}, delivered: ${_this.delivered}, revenueToday: ${_this.revenueToday}, revenueMonth: ${_this.revenueMonth}, collectionsMonth: ${_this.collectionsMonth}, outstanding: ${_this.outstanding}, cashBank: ${_this.cashBank}, utilisationPct: ${_this.utilisationPct})';
  }
}

/// @nodoc
abstract mixin class $DashboardKpisCopyWith<$Res> {
  factory $DashboardKpisCopyWith(
          DashboardKpis value, $Res Function(DashboardKpis) _then) =
      _$DashboardKpisCopyWithImpl;
  @useResult
  $Res call(
      {int tripsToday,
      int running,
      int delayed,
      int delivered,
      int revenueToday,
      int revenueMonth,
      int collectionsMonth,
      int outstanding,
      int cashBank,
      int utilisationPct});
}

/// @nodoc
class _$DashboardKpisCopyWithImpl<$Res>
    implements $DashboardKpisCopyWith<$Res> {
  _$DashboardKpisCopyWithImpl(this._self, this._then);

  final DashboardKpis _self;
  final $Res Function(DashboardKpis) _then;

  /// Create a copy of DashboardKpis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripsToday = null,
    Object? running = null,
    Object? delayed = null,
    Object? delivered = null,
    Object? revenueToday = null,
    Object? revenueMonth = null,
    Object? collectionsMonth = null,
    Object? outstanding = null,
    Object? cashBank = null,
    Object? utilisationPct = null,
  }) {
    return _then(DashboardKpis(
      tripsToday: null == tripsToday
          ? _self.tripsToday
          : tripsToday // ignore: cast_nullable_to_non_nullable
              as int,
      running: null == running
          ? _self.running
          : running // ignore: cast_nullable_to_non_nullable
              as int,
      delayed: null == delayed
          ? _self.delayed
          : delayed // ignore: cast_nullable_to_non_nullable
              as int,
      delivered: null == delivered
          ? _self.delivered
          : delivered // ignore: cast_nullable_to_non_nullable
              as int,
      revenueToday: null == revenueToday
          ? _self.revenueToday
          : revenueToday // ignore: cast_nullable_to_non_nullable
              as int,
      revenueMonth: null == revenueMonth
          ? _self.revenueMonth
          : revenueMonth // ignore: cast_nullable_to_non_nullable
              as int,
      collectionsMonth: null == collectionsMonth
          ? _self.collectionsMonth
          : collectionsMonth // ignore: cast_nullable_to_non_nullable
              as int,
      outstanding: null == outstanding
          ? _self.outstanding
          : outstanding // ignore: cast_nullable_to_non_nullable
              as int,
      cashBank: null == cashBank
          ? _self.cashBank
          : cashBank // ignore: cast_nullable_to_non_nullable
              as int,
      utilisationPct: null == utilisationPct
          ? _self.utilisationPct
          : utilisationPct // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [DashboardKpis].
extension DashboardKpisPatterns on DashboardKpis {
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
    TResult Function(_DashboardKpis value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DashboardKpis() when $default != null:
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
    TResult Function(_DashboardKpis value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardKpis():
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
    TResult? Function(_DashboardKpis value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardKpis() when $default != null:
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
            int tripsToday,
            int running,
            int delayed,
            int delivered,
            int revenueToday,
            int revenueMonth,
            int collectionsMonth,
            int outstanding,
            int cashBank,
            int utilisationPct)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DashboardKpis() when $default != null:
        return $default(
            _that.tripsToday,
            _that.running,
            _that.delayed,
            _that.delivered,
            _that.revenueToday,
            _that.revenueMonth,
            _that.collectionsMonth,
            _that.outstanding,
            _that.cashBank,
            _that.utilisationPct);
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
            int tripsToday,
            int running,
            int delayed,
            int delivered,
            int revenueToday,
            int revenueMonth,
            int collectionsMonth,
            int outstanding,
            int cashBank,
            int utilisationPct)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardKpis():
        return $default(
            _that.tripsToday,
            _that.running,
            _that.delayed,
            _that.delivered,
            _that.revenueToday,
            _that.revenueMonth,
            _that.collectionsMonth,
            _that.outstanding,
            _that.cashBank,
            _that.utilisationPct);
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
            int tripsToday,
            int running,
            int delayed,
            int delivered,
            int revenueToday,
            int revenueMonth,
            int collectionsMonth,
            int outstanding,
            int cashBank,
            int utilisationPct)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardKpis() when $default != null:
        return $default(
            _that.tripsToday,
            _that.running,
            _that.delayed,
            _that.delivered,
            _that.revenueToday,
            _that.revenueMonth,
            _that.collectionsMonth,
            _that.outstanding,
            _that.cashBank,
            _that.utilisationPct);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DashboardKpis implements DashboardKpis {
  const _DashboardKpis(
      {this.tripsToday = 0,
      this.running = 0,
      this.delayed = 0,
      this.delivered = 0,
      this.revenueToday = 0,
      this.revenueMonth = 0,
      this.collectionsMonth = 0,
      this.outstanding = 0,
      this.cashBank = 0,
      this.utilisationPct = 0});
  factory _DashboardKpis.fromJson(Map<String, dynamic> json) =>
      _$DashboardKpisFromJson(json);

  @override
  @JsonKey()
  final int tripsToday;
  @override
  @JsonKey()
  final int running;
  @override
  @JsonKey()
  final int delayed;
  @override
  @JsonKey()
  final int delivered;
  @override
  @JsonKey()
  final int revenueToday;
  @override
  @JsonKey()
  final int revenueMonth;
  @override
  @JsonKey()
  final int collectionsMonth;
  @override
  @JsonKey()
  final int outstanding;
  @override
  @JsonKey()
  final int cashBank;
  @override
  @JsonKey()
  final int utilisationPct;

  /// Create a copy of DashboardKpis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DashboardKpisCopyWith<_DashboardKpis> get copyWith =>
      __$DashboardKpisCopyWithImpl<_DashboardKpis>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DashboardKpisToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DashboardKpis &&
            (identical(other.tripsToday, tripsToday) ||
                other.tripsToday == tripsToday) &&
            (identical(other.running, running) || other.running == running) &&
            (identical(other.delayed, delayed) || other.delayed == delayed) &&
            (identical(other.delivered, delivered) ||
                other.delivered == delivered) &&
            (identical(other.revenueToday, revenueToday) ||
                other.revenueToday == revenueToday) &&
            (identical(other.revenueMonth, revenueMonth) ||
                other.revenueMonth == revenueMonth) &&
            (identical(other.collectionsMonth, collectionsMonth) ||
                other.collectionsMonth == collectionsMonth) &&
            (identical(other.outstanding, outstanding) ||
                other.outstanding == outstanding) &&
            (identical(other.cashBank, cashBank) ||
                other.cashBank == cashBank) &&
            (identical(other.utilisationPct, utilisationPct) ||
                other.utilisationPct == utilisationPct));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        tripsToday,
        running,
        delayed,
        delivered,
        revenueToday,
        revenueMonth,
        collectionsMonth,
        outstanding,
        cashBank,
        utilisationPct);
  }

  @override
  String toString() {
    return 'DashboardKpis(tripsToday: $tripsToday, running: $running, delayed: $delayed, delivered: $delivered, revenueToday: $revenueToday, revenueMonth: $revenueMonth, collectionsMonth: $collectionsMonth, outstanding: $outstanding, cashBank: $cashBank, utilisationPct: $utilisationPct)';
  }
}

/// @nodoc
abstract mixin class _$DashboardKpisCopyWith<$Res>
    implements $DashboardKpisCopyWith<$Res> {
  factory _$DashboardKpisCopyWith(
          _DashboardKpis value, $Res Function(_DashboardKpis) _then) =
      __$DashboardKpisCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int tripsToday,
      int running,
      int delayed,
      int delivered,
      int revenueToday,
      int revenueMonth,
      int collectionsMonth,
      int outstanding,
      int cashBank,
      int utilisationPct});
}

/// @nodoc
class __$DashboardKpisCopyWithImpl<$Res>
    implements _$DashboardKpisCopyWith<$Res> {
  __$DashboardKpisCopyWithImpl(this._self, this._then);

  final _DashboardKpis _self;
  final $Res Function(_DashboardKpis) _then;

  /// Create a copy of DashboardKpis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tripsToday = null,
    Object? running = null,
    Object? delayed = null,
    Object? delivered = null,
    Object? revenueToday = null,
    Object? revenueMonth = null,
    Object? collectionsMonth = null,
    Object? outstanding = null,
    Object? cashBank = null,
    Object? utilisationPct = null,
  }) {
    return _then(_DashboardKpis(
      tripsToday: null == tripsToday
          ? _self.tripsToday
          : tripsToday // ignore: cast_nullable_to_non_nullable
              as int,
      running: null == running
          ? _self.running
          : running // ignore: cast_nullable_to_non_nullable
              as int,
      delayed: null == delayed
          ? _self.delayed
          : delayed // ignore: cast_nullable_to_non_nullable
              as int,
      delivered: null == delivered
          ? _self.delivered
          : delivered // ignore: cast_nullable_to_non_nullable
              as int,
      revenueToday: null == revenueToday
          ? _self.revenueToday
          : revenueToday // ignore: cast_nullable_to_non_nullable
              as int,
      revenueMonth: null == revenueMonth
          ? _self.revenueMonth
          : revenueMonth // ignore: cast_nullable_to_non_nullable
              as int,
      collectionsMonth: null == collectionsMonth
          ? _self.collectionsMonth
          : collectionsMonth // ignore: cast_nullable_to_non_nullable
              as int,
      outstanding: null == outstanding
          ? _self.outstanding
          : outstanding // ignore: cast_nullable_to_non_nullable
              as int,
      cashBank: null == cashBank
          ? _self.cashBank
          : cashBank // ignore: cast_nullable_to_non_nullable
              as int,
      utilisationPct: null == utilisationPct
          ? _self.utilisationPct
          : utilisationPct // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$TrendPoint {
  String get day;
  int get revenue;
  int get collection;

  /// Create a copy of TrendPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TrendPointCopyWith<TrendPoint> get copyWith =>
      _$TrendPointCopyWithImpl<TrendPoint>(this as TrendPoint, _$identity);

  /// Serializes this TrendPoint to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as TrendPoint;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TrendPoint &&
            (identical(other.day, _this.day) || other.day == _this.day) &&
            (identical(other.revenue, _this.revenue) ||
                other.revenue == _this.revenue) &&
            (identical(other.collection, _this.collection) ||
                other.collection == _this.collection));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as TrendPoint;
    return Object.hash(runtimeType, _this.day, _this.revenue, _this.collection);
  }

  @override
  String toString() {
    final _this = this as TrendPoint;
    return 'TrendPoint(day: ${_this.day}, revenue: ${_this.revenue}, collection: ${_this.collection})';
  }
}

/// @nodoc
abstract mixin class $TrendPointCopyWith<$Res> {
  factory $TrendPointCopyWith(
          TrendPoint value, $Res Function(TrendPoint) _then) =
      _$TrendPointCopyWithImpl;
  @useResult
  $Res call({String day, int revenue, int collection});
}

/// @nodoc
class _$TrendPointCopyWithImpl<$Res> implements $TrendPointCopyWith<$Res> {
  _$TrendPointCopyWithImpl(this._self, this._then);

  final TrendPoint _self;
  final $Res Function(TrendPoint) _then;

  /// Create a copy of TrendPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? revenue = null,
    Object? collection = null,
  }) {
    return _then(TrendPoint(
      day: null == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      revenue: null == revenue
          ? _self.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as int,
      collection: null == collection
          ? _self.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [TrendPoint].
extension TrendPointPatterns on TrendPoint {
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
    TResult Function(_TrendPoint value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TrendPoint() when $default != null:
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
    TResult Function(_TrendPoint value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TrendPoint():
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
    TResult? Function(_TrendPoint value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TrendPoint() when $default != null:
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
    TResult Function(String day, int revenue, int collection)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TrendPoint() when $default != null:
        return $default(_that.day, _that.revenue, _that.collection);
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
    TResult Function(String day, int revenue, int collection) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TrendPoint():
        return $default(_that.day, _that.revenue, _that.collection);
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
    TResult? Function(String day, int revenue, int collection)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TrendPoint() when $default != null:
        return $default(_that.day, _that.revenue, _that.collection);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TrendPoint implements TrendPoint {
  const _TrendPoint(
      {required this.day, required this.revenue, required this.collection});
  factory _TrendPoint.fromJson(Map<String, dynamic> json) =>
      _$TrendPointFromJson(json);

  @override
  final String day;
  @override
  final int revenue;
  @override
  final int collection;

  /// Create a copy of TrendPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TrendPointCopyWith<_TrendPoint> get copyWith =>
      __$TrendPointCopyWithImpl<_TrendPoint>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TrendPointToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TrendPoint &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.collection, collection) ||
                other.collection == collection));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, day, revenue, collection);
  }

  @override
  String toString() {
    return 'TrendPoint(day: $day, revenue: $revenue, collection: $collection)';
  }
}

/// @nodoc
abstract mixin class _$TrendPointCopyWith<$Res>
    implements $TrendPointCopyWith<$Res> {
  factory _$TrendPointCopyWith(
          _TrendPoint value, $Res Function(_TrendPoint) _then) =
      __$TrendPointCopyWithImpl;
  @override
  @useResult
  $Res call({String day, int revenue, int collection});
}

/// @nodoc
class __$TrendPointCopyWithImpl<$Res> implements _$TrendPointCopyWith<$Res> {
  __$TrendPointCopyWithImpl(this._self, this._then);

  final _TrendPoint _self;
  final $Res Function(_TrendPoint) _then;

  /// Create a copy of TrendPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? day = null,
    Object? revenue = null,
    Object? collection = null,
  }) {
    return _then(_TrendPoint(
      day: null == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      revenue: null == revenue
          ? _self.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as int,
      collection: null == collection
          ? _self.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$LaneMargin {
  String get lane;
  int get marginPct;

  /// Create a copy of LaneMargin
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LaneMarginCopyWith<LaneMargin> get copyWith =>
      _$LaneMarginCopyWithImpl<LaneMargin>(this as LaneMargin, _$identity);

  /// Serializes this LaneMargin to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as LaneMargin;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LaneMargin &&
            (identical(other.lane, _this.lane) || other.lane == _this.lane) &&
            (identical(other.marginPct, _this.marginPct) ||
                other.marginPct == _this.marginPct));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as LaneMargin;
    return Object.hash(runtimeType, _this.lane, _this.marginPct);
  }

  @override
  String toString() {
    final _this = this as LaneMargin;
    return 'LaneMargin(lane: ${_this.lane}, marginPct: ${_this.marginPct})';
  }
}

/// @nodoc
abstract mixin class $LaneMarginCopyWith<$Res> {
  factory $LaneMarginCopyWith(
          LaneMargin value, $Res Function(LaneMargin) _then) =
      _$LaneMarginCopyWithImpl;
  @useResult
  $Res call({String lane, int marginPct});
}

/// @nodoc
class _$LaneMarginCopyWithImpl<$Res> implements $LaneMarginCopyWith<$Res> {
  _$LaneMarginCopyWithImpl(this._self, this._then);

  final LaneMargin _self;
  final $Res Function(LaneMargin) _then;

  /// Create a copy of LaneMargin
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lane = null,
    Object? marginPct = null,
  }) {
    return _then(LaneMargin(
      lane: null == lane
          ? _self.lane
          : lane // ignore: cast_nullable_to_non_nullable
              as String,
      marginPct: null == marginPct
          ? _self.marginPct
          : marginPct // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [LaneMargin].
extension LaneMarginPatterns on LaneMargin {
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
    TResult Function(_LaneMargin value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LaneMargin() when $default != null:
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
    TResult Function(_LaneMargin value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LaneMargin():
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
    TResult? Function(_LaneMargin value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LaneMargin() when $default != null:
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
    TResult Function(String lane, int marginPct)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LaneMargin() when $default != null:
        return $default(_that.lane, _that.marginPct);
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
    TResult Function(String lane, int marginPct) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LaneMargin():
        return $default(_that.lane, _that.marginPct);
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
    TResult? Function(String lane, int marginPct)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LaneMargin() when $default != null:
        return $default(_that.lane, _that.marginPct);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LaneMargin implements LaneMargin {
  const _LaneMargin({required this.lane, required this.marginPct});
  factory _LaneMargin.fromJson(Map<String, dynamic> json) =>
      _$LaneMarginFromJson(json);

  @override
  final String lane;
  @override
  final int marginPct;

  /// Create a copy of LaneMargin
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LaneMarginCopyWith<_LaneMargin> get copyWith =>
      __$LaneMarginCopyWithImpl<_LaneMargin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LaneMarginToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LaneMargin &&
            (identical(other.lane, lane) || other.lane == lane) &&
            (identical(other.marginPct, marginPct) ||
                other.marginPct == marginPct));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, lane, marginPct);
  }

  @override
  String toString() {
    return 'LaneMargin(lane: $lane, marginPct: $marginPct)';
  }
}

/// @nodoc
abstract mixin class _$LaneMarginCopyWith<$Res>
    implements $LaneMarginCopyWith<$Res> {
  factory _$LaneMarginCopyWith(
          _LaneMargin value, $Res Function(_LaneMargin) _then) =
      __$LaneMarginCopyWithImpl;
  @override
  @useResult
  $Res call({String lane, int marginPct});
}

/// @nodoc
class __$LaneMarginCopyWithImpl<$Res> implements _$LaneMarginCopyWith<$Res> {
  __$LaneMarginCopyWithImpl(this._self, this._then);

  final _LaneMargin _self;
  final $Res Function(_LaneMargin) _then;

  /// Create a copy of LaneMargin
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? lane = null,
    Object? marginPct = null,
  }) {
    return _then(_LaneMargin(
      lane: null == lane
          ? _self.lane
          : lane // ignore: cast_nullable_to_non_nullable
              as String,
      marginPct: null == marginPct
          ? _self.marginPct
          : marginPct // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$CustomerMargin {
  String get name;
  int get marginPct;
  int get outstanding;

  /// Create a copy of CustomerMargin
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomerMarginCopyWith<CustomerMargin> get copyWith =>
      _$CustomerMarginCopyWithImpl<CustomerMargin>(
          this as CustomerMargin, _$identity);

  /// Serializes this CustomerMargin to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as CustomerMargin;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomerMargin &&
            (identical(other.name, _this.name) || other.name == _this.name) &&
            (identical(other.marginPct, _this.marginPct) ||
                other.marginPct == _this.marginPct) &&
            (identical(other.outstanding, _this.outstanding) ||
                other.outstanding == _this.outstanding));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as CustomerMargin;
    return Object.hash(
        runtimeType, _this.name, _this.marginPct, _this.outstanding);
  }

  @override
  String toString() {
    final _this = this as CustomerMargin;
    return 'CustomerMargin(name: ${_this.name}, marginPct: ${_this.marginPct}, outstanding: ${_this.outstanding})';
  }
}

/// @nodoc
abstract mixin class $CustomerMarginCopyWith<$Res> {
  factory $CustomerMarginCopyWith(
          CustomerMargin value, $Res Function(CustomerMargin) _then) =
      _$CustomerMarginCopyWithImpl;
  @useResult
  $Res call({String name, int marginPct, int outstanding});
}

/// @nodoc
class _$CustomerMarginCopyWithImpl<$Res>
    implements $CustomerMarginCopyWith<$Res> {
  _$CustomerMarginCopyWithImpl(this._self, this._then);

  final CustomerMargin _self;
  final $Res Function(CustomerMargin) _then;

  /// Create a copy of CustomerMargin
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? marginPct = null,
    Object? outstanding = null,
  }) {
    return _then(CustomerMargin(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      marginPct: null == marginPct
          ? _self.marginPct
          : marginPct // ignore: cast_nullable_to_non_nullable
              as int,
      outstanding: null == outstanding
          ? _self.outstanding
          : outstanding // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [CustomerMargin].
extension CustomerMarginPatterns on CustomerMargin {
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
    TResult Function(_CustomerMargin value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomerMargin() when $default != null:
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
    TResult Function(_CustomerMargin value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomerMargin():
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
    TResult? Function(_CustomerMargin value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomerMargin() when $default != null:
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
    TResult Function(String name, int marginPct, int outstanding)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomerMargin() when $default != null:
        return $default(_that.name, _that.marginPct, _that.outstanding);
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
    TResult Function(String name, int marginPct, int outstanding) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomerMargin():
        return $default(_that.name, _that.marginPct, _that.outstanding);
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
    TResult? Function(String name, int marginPct, int outstanding)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomerMargin() when $default != null:
        return $default(_that.name, _that.marginPct, _that.outstanding);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CustomerMargin implements CustomerMargin {
  const _CustomerMargin(
      {required this.name, required this.marginPct, required this.outstanding});
  factory _CustomerMargin.fromJson(Map<String, dynamic> json) =>
      _$CustomerMarginFromJson(json);

  @override
  final String name;
  @override
  final int marginPct;
  @override
  final int outstanding;

  /// Create a copy of CustomerMargin
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CustomerMarginCopyWith<_CustomerMargin> get copyWith =>
      __$CustomerMarginCopyWithImpl<_CustomerMargin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CustomerMarginToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CustomerMargin &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.marginPct, marginPct) ||
                other.marginPct == marginPct) &&
            (identical(other.outstanding, outstanding) ||
                other.outstanding == outstanding));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, name, marginPct, outstanding);
  }

  @override
  String toString() {
    return 'CustomerMargin(name: $name, marginPct: $marginPct, outstanding: $outstanding)';
  }
}

/// @nodoc
abstract mixin class _$CustomerMarginCopyWith<$Res>
    implements $CustomerMarginCopyWith<$Res> {
  factory _$CustomerMarginCopyWith(
          _CustomerMargin value, $Res Function(_CustomerMargin) _then) =
      __$CustomerMarginCopyWithImpl;
  @override
  @useResult
  $Res call({String name, int marginPct, int outstanding});
}

/// @nodoc
class __$CustomerMarginCopyWithImpl<$Res>
    implements _$CustomerMarginCopyWith<$Res> {
  __$CustomerMarginCopyWithImpl(this._self, this._then);

  final _CustomerMargin _self;
  final $Res Function(_CustomerMargin) _then;

  /// Create a copy of CustomerMargin
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? marginPct = null,
    Object? outstanding = null,
  }) {
    return _then(_CustomerMargin(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      marginPct: null == marginPct
          ? _self.marginPct
          : marginPct // ignore: cast_nullable_to_non_nullable
              as int,
      outstanding: null == outstanding
          ? _self.outstanding
          : outstanding // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$AttentionItem {
  String get title;
  int get count;
  String get kind;

  /// Create a copy of AttentionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AttentionItemCopyWith<AttentionItem> get copyWith =>
      _$AttentionItemCopyWithImpl<AttentionItem>(
          this as AttentionItem, _$identity);

  /// Serializes this AttentionItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as AttentionItem;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AttentionItem &&
            (identical(other.title, _this.title) ||
                other.title == _this.title) &&
            (identical(other.count, _this.count) ||
                other.count == _this.count) &&
            (identical(other.kind, _this.kind) || other.kind == _this.kind));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as AttentionItem;
    return Object.hash(runtimeType, _this.title, _this.count, _this.kind);
  }

  @override
  String toString() {
    final _this = this as AttentionItem;
    return 'AttentionItem(title: ${_this.title}, count: ${_this.count}, kind: ${_this.kind})';
  }
}

/// @nodoc
abstract mixin class $AttentionItemCopyWith<$Res> {
  factory $AttentionItemCopyWith(
          AttentionItem value, $Res Function(AttentionItem) _then) =
      _$AttentionItemCopyWithImpl;
  @useResult
  $Res call({String title, int count, String kind});
}

/// @nodoc
class _$AttentionItemCopyWithImpl<$Res>
    implements $AttentionItemCopyWith<$Res> {
  _$AttentionItemCopyWithImpl(this._self, this._then);

  final AttentionItem _self;
  final $Res Function(AttentionItem) _then;

  /// Create a copy of AttentionItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? count = null,
    Object? kind = null,
  }) {
    return _then(AttentionItem(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      kind: null == kind
          ? _self.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [AttentionItem].
extension AttentionItemPatterns on AttentionItem {
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
    TResult Function(_AttentionItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AttentionItem() when $default != null:
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
    TResult Function(_AttentionItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttentionItem():
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
    TResult? Function(_AttentionItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttentionItem() when $default != null:
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
    TResult Function(String title, int count, String kind)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AttentionItem() when $default != null:
        return $default(_that.title, _that.count, _that.kind);
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
    TResult Function(String title, int count, String kind) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttentionItem():
        return $default(_that.title, _that.count, _that.kind);
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
    TResult? Function(String title, int count, String kind)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttentionItem() when $default != null:
        return $default(_that.title, _that.count, _that.kind);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AttentionItem implements AttentionItem {
  const _AttentionItem(
      {required this.title, required this.count, required this.kind});
  factory _AttentionItem.fromJson(Map<String, dynamic> json) =>
      _$AttentionItemFromJson(json);

  @override
  final String title;
  @override
  final int count;
  @override
  final String kind;

  /// Create a copy of AttentionItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AttentionItemCopyWith<_AttentionItem> get copyWith =>
      __$AttentionItemCopyWithImpl<_AttentionItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AttentionItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AttentionItem &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.kind, kind) || other.kind == kind));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, title, count, kind);
  }

  @override
  String toString() {
    return 'AttentionItem(title: $title, count: $count, kind: $kind)';
  }
}

/// @nodoc
abstract mixin class _$AttentionItemCopyWith<$Res>
    implements $AttentionItemCopyWith<$Res> {
  factory _$AttentionItemCopyWith(
          _AttentionItem value, $Res Function(_AttentionItem) _then) =
      __$AttentionItemCopyWithImpl;
  @override
  @useResult
  $Res call({String title, int count, String kind});
}

/// @nodoc
class __$AttentionItemCopyWithImpl<$Res>
    implements _$AttentionItemCopyWith<$Res> {
  __$AttentionItemCopyWithImpl(this._self, this._then);

  final _AttentionItem _self;
  final $Res Function(_AttentionItem) _then;

  /// Create a copy of AttentionItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = null,
    Object? count = null,
    Object? kind = null,
  }) {
    return _then(_AttentionItem(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      kind: null == kind
          ? _self.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$DataAnswer {
  String get text;
  List<int> get series;

  /// Create a copy of DataAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DataAnswerCopyWith<DataAnswer> get copyWith =>
      _$DataAnswerCopyWithImpl<DataAnswer>(this as DataAnswer, _$identity);

  /// Serializes this DataAnswer to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as DataAnswer;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DataAnswer &&
            (identical(other.text, _this.text) || other.text == _this.text) &&
            const DeepCollectionEquality().equals(other.series, _this.series));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as DataAnswer;
    return Object.hash(runtimeType, _this.text,
        const DeepCollectionEquality().hash(_this.series));
  }

  @override
  String toString() {
    final _this = this as DataAnswer;
    return 'DataAnswer(text: ${_this.text}, series: ${_this.series})';
  }
}

/// @nodoc
abstract mixin class $DataAnswerCopyWith<$Res> {
  factory $DataAnswerCopyWith(
          DataAnswer value, $Res Function(DataAnswer) _then) =
      _$DataAnswerCopyWithImpl;
  @useResult
  $Res call({String text, List<int> series});
}

/// @nodoc
class _$DataAnswerCopyWithImpl<$Res> implements $DataAnswerCopyWith<$Res> {
  _$DataAnswerCopyWithImpl(this._self, this._then);

  final DataAnswer _self;
  final $Res Function(DataAnswer) _then;

  /// Create a copy of DataAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? series = null,
  }) {
    return _then(DataAnswer(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      series: null == series
          ? _self.series
          : series // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [DataAnswer].
extension DataAnswerPatterns on DataAnswer {
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
    TResult Function(_DataAnswer value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DataAnswer() when $default != null:
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
    TResult Function(_DataAnswer value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DataAnswer():
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
    TResult? Function(_DataAnswer value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DataAnswer() when $default != null:
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
    TResult Function(String text, List<int> series)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DataAnswer() when $default != null:
        return $default(_that.text, _that.series);
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
    TResult Function(String text, List<int> series) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DataAnswer():
        return $default(_that.text, _that.series);
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
    TResult? Function(String text, List<int> series)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DataAnswer() when $default != null:
        return $default(_that.text, _that.series);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DataAnswer implements DataAnswer {
  const _DataAnswer({required this.text, List<int> series = const []})
      : _series = series;
  factory _DataAnswer.fromJson(Map<String, dynamic> json) =>
      _$DataAnswerFromJson(json);

  @override
  final String text;
  final List<int> _series;
  @override
  @JsonKey()
  List<int> get series {
    if (_series is EqualUnmodifiableListView) return _series;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_series);
  }

  /// Create a copy of DataAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DataAnswerCopyWith<_DataAnswer> get copyWith =>
      __$DataAnswerCopyWithImpl<_DataAnswer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DataAnswerToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DataAnswer &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality().equals(other.series, _series));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
        runtimeType, text, const DeepCollectionEquality().hash(_series));
  }

  @override
  String toString() {
    return 'DataAnswer(text: $text, series: $series)';
  }
}

/// @nodoc
abstract mixin class _$DataAnswerCopyWith<$Res>
    implements $DataAnswerCopyWith<$Res> {
  factory _$DataAnswerCopyWith(
          _DataAnswer value, $Res Function(_DataAnswer) _then) =
      __$DataAnswerCopyWithImpl;
  @override
  @useResult
  $Res call({String text, List<int> series});
}

/// @nodoc
class __$DataAnswerCopyWithImpl<$Res> implements _$DataAnswerCopyWith<$Res> {
  __$DataAnswerCopyWithImpl(this._self, this._then);

  final _DataAnswer _self;
  final $Res Function(_DataAnswer) _then;

  /// Create a copy of DataAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? text = null,
    Object? series = null,
  }) {
    return _then(_DataAnswer(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      series: null == series
          ? _self._series
          : series // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

// dart format on
