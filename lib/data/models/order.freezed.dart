// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderStop {
  String get address;
  double get lat;
  double get lng;
  DateTime? get windowStart;
  DateTime? get windowEnd;

  /// Create a copy of OrderStop
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrderStopCopyWith<OrderStop> get copyWith =>
      _$OrderStopCopyWithImpl<OrderStop>(this as OrderStop, _$identity);

  /// Serializes this OrderStop to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as OrderStop;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OrderStop &&
            (identical(other.address, _this.address) ||
                other.address == _this.address) &&
            (identical(other.lat, _this.lat) || other.lat == _this.lat) &&
            (identical(other.lng, _this.lng) || other.lng == _this.lng) &&
            (identical(other.windowStart, _this.windowStart) ||
                other.windowStart == _this.windowStart) &&
            (identical(other.windowEnd, _this.windowEnd) ||
                other.windowEnd == _this.windowEnd));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as OrderStop;
    return Object.hash(runtimeType, _this.address, _this.lat, _this.lng,
        _this.windowStart, _this.windowEnd);
  }

  @override
  String toString() {
    final _this = this as OrderStop;
    return 'OrderStop(address: ${_this.address}, lat: ${_this.lat}, lng: ${_this.lng}, windowStart: ${_this.windowStart}, windowEnd: ${_this.windowEnd})';
  }
}

/// @nodoc
abstract mixin class $OrderStopCopyWith<$Res> {
  factory $OrderStopCopyWith(OrderStop value, $Res Function(OrderStop) _then) =
      _$OrderStopCopyWithImpl;
  @useResult
  $Res call(
      {String address,
      double lat,
      double lng,
      DateTime? windowStart,
      DateTime? windowEnd});
}

/// @nodoc
class _$OrderStopCopyWithImpl<$Res> implements $OrderStopCopyWith<$Res> {
  _$OrderStopCopyWithImpl(this._self, this._then);

  final OrderStop _self;
  final $Res Function(OrderStop) _then;

  /// Create a copy of OrderStop
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? lat = null,
    Object? lng = null,
    Object? windowStart = freezed,
    Object? windowEnd = freezed,
  }) {
    return _then(OrderStop(
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _self.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _self.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      windowStart: freezed == windowStart
          ? _self.windowStart
          : windowStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      windowEnd: freezed == windowEnd
          ? _self.windowEnd
          : windowEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [OrderStop].
extension OrderStopPatterns on OrderStop {
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
    TResult Function(_OrderStop value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OrderStop() when $default != null:
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
    TResult Function(_OrderStop value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrderStop():
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
    TResult? Function(_OrderStop value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrderStop() when $default != null:
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
    TResult Function(String address, double lat, double lng,
            DateTime? windowStart, DateTime? windowEnd)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OrderStop() when $default != null:
        return $default(_that.address, _that.lat, _that.lng, _that.windowStart,
            _that.windowEnd);
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
    TResult Function(String address, double lat, double lng,
            DateTime? windowStart, DateTime? windowEnd)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrderStop():
        return $default(_that.address, _that.lat, _that.lng, _that.windowStart,
            _that.windowEnd);
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
    TResult? Function(String address, double lat, double lng,
            DateTime? windowStart, DateTime? windowEnd)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrderStop() when $default != null:
        return $default(_that.address, _that.lat, _that.lng, _that.windowStart,
            _that.windowEnd);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OrderStop implements OrderStop {
  const _OrderStop(
      {required this.address,
      required this.lat,
      required this.lng,
      this.windowStart,
      this.windowEnd});
  factory _OrderStop.fromJson(Map<String, dynamic> json) =>
      _$OrderStopFromJson(json);

  @override
  final String address;
  @override
  final double lat;
  @override
  final double lng;
  @override
  final DateTime? windowStart;
  @override
  final DateTime? windowEnd;

  /// Create a copy of OrderStop
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrderStopCopyWith<_OrderStop> get copyWith =>
      __$OrderStopCopyWithImpl<_OrderStop>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OrderStopToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OrderStop &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.windowStart, windowStart) ||
                other.windowStart == windowStart) &&
            (identical(other.windowEnd, windowEnd) ||
                other.windowEnd == windowEnd));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, address, lat, lng, windowStart, windowEnd);
  }

  @override
  String toString() {
    return 'OrderStop(address: $address, lat: $lat, lng: $lng, windowStart: $windowStart, windowEnd: $windowEnd)';
  }
}

/// @nodoc
abstract mixin class _$OrderStopCopyWith<$Res>
    implements $OrderStopCopyWith<$Res> {
  factory _$OrderStopCopyWith(
          _OrderStop value, $Res Function(_OrderStop) _then) =
      __$OrderStopCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String address,
      double lat,
      double lng,
      DateTime? windowStart,
      DateTime? windowEnd});
}

/// @nodoc
class __$OrderStopCopyWithImpl<$Res> implements _$OrderStopCopyWith<$Res> {
  __$OrderStopCopyWithImpl(this._self, this._then);

  final _OrderStop _self;
  final $Res Function(_OrderStop) _then;

  /// Create a copy of OrderStop
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? address = null,
    Object? lat = null,
    Object? lng = null,
    Object? windowStart = freezed,
    Object? windowEnd = freezed,
  }) {
    return _then(_OrderStop(
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _self.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _self.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      windowStart: freezed == windowStart
          ? _self.windowStart
          : windowStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      windowEnd: freezed == windowEnd
          ? _self.windowEnd
          : windowEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$Order {
  String get id;
  String get no;
  String get customerId;
  String get customerName;
  OrderType get type;
  List<OrderStop> get stops;
  String get vehicleType;
  String get commodity;
  double get weightKg;
  double? get declaredValue;
  int get rate;
  OrderStatus get status;
  DateTime? get neededBy;
  String? get tripId;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrderCopyWith<Order> get copyWith =>
      _$OrderCopyWithImpl<Order>(this as Order, _$identity);

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as Order;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Order &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.no, _this.no) || other.no == _this.no) &&
            (identical(other.customerId, _this.customerId) ||
                other.customerId == _this.customerId) &&
            (identical(other.customerName, _this.customerName) ||
                other.customerName == _this.customerName) &&
            (identical(other.type, _this.type) || other.type == _this.type) &&
            const DeepCollectionEquality().equals(other.stops, _this.stops) &&
            (identical(other.vehicleType, _this.vehicleType) ||
                other.vehicleType == _this.vehicleType) &&
            (identical(other.commodity, _this.commodity) ||
                other.commodity == _this.commodity) &&
            (identical(other.weightKg, _this.weightKg) ||
                other.weightKg == _this.weightKg) &&
            (identical(other.declaredValue, _this.declaredValue) ||
                other.declaredValue == _this.declaredValue) &&
            (identical(other.rate, _this.rate) || other.rate == _this.rate) &&
            (identical(other.status, _this.status) ||
                other.status == _this.status) &&
            (identical(other.neededBy, _this.neededBy) ||
                other.neededBy == _this.neededBy) &&
            (identical(other.tripId, _this.tripId) ||
                other.tripId == _this.tripId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as Order;
    return Object.hash(
        runtimeType,
        _this.id,
        _this.no,
        _this.customerId,
        _this.customerName,
        _this.type,
        const DeepCollectionEquality().hash(_this.stops),
        _this.vehicleType,
        _this.commodity,
        _this.weightKg,
        _this.declaredValue,
        _this.rate,
        _this.status,
        _this.neededBy,
        _this.tripId);
  }

  @override
  String toString() {
    final _this = this as Order;
    return 'Order(id: ${_this.id}, no: ${_this.no}, customerId: ${_this.customerId}, customerName: ${_this.customerName}, type: ${_this.type}, stops: ${_this.stops}, vehicleType: ${_this.vehicleType}, commodity: ${_this.commodity}, weightKg: ${_this.weightKg}, declaredValue: ${_this.declaredValue}, rate: ${_this.rate}, status: ${_this.status}, neededBy: ${_this.neededBy}, tripId: ${_this.tripId})';
  }
}

/// @nodoc
abstract mixin class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) _then) =
      _$OrderCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String no,
      String customerId,
      String customerName,
      OrderType type,
      List<OrderStop> stops,
      String vehicleType,
      String commodity,
      double weightKg,
      double? declaredValue,
      int rate,
      OrderStatus status,
      DateTime? neededBy,
      String? tripId});
}

/// @nodoc
class _$OrderCopyWithImpl<$Res> implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._self, this._then);

  final Order _self;
  final $Res Function(Order) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? no = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? type = null,
    Object? stops = null,
    Object? vehicleType = null,
    Object? commodity = null,
    Object? weightKg = null,
    Object? declaredValue = freezed,
    Object? rate = null,
    Object? status = null,
    Object? neededBy = freezed,
    Object? tripId = freezed,
  }) {
    return _then(Order(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      no: null == no
          ? _self.no
          : no // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _self.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      customerName: null == customerName
          ? _self.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as OrderType,
      stops: null == stops
          ? _self.stops
          : stops // ignore: cast_nullable_to_non_nullable
              as List<OrderStop>,
      vehicleType: null == vehicleType
          ? _self.vehicleType
          : vehicleType // ignore: cast_nullable_to_non_nullable
              as String,
      commodity: null == commodity
          ? _self.commodity
          : commodity // ignore: cast_nullable_to_non_nullable
              as String,
      weightKg: null == weightKg
          ? _self.weightKg
          : weightKg // ignore: cast_nullable_to_non_nullable
              as double,
      declaredValue: freezed == declaredValue
          ? _self.declaredValue
          : declaredValue // ignore: cast_nullable_to_non_nullable
              as double?,
      rate: null == rate
          ? _self.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      neededBy: freezed == neededBy
          ? _self.neededBy
          : neededBy // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tripId: freezed == tripId
          ? _self.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Order].
extension OrderPatterns on Order {
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
    TResult Function(_Order value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Order() when $default != null:
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
    TResult Function(_Order value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Order():
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
    TResult? Function(_Order value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Order() when $default != null:
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
            String no,
            String customerId,
            String customerName,
            OrderType type,
            List<OrderStop> stops,
            String vehicleType,
            String commodity,
            double weightKg,
            double? declaredValue,
            int rate,
            OrderStatus status,
            DateTime? neededBy,
            String? tripId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Order() when $default != null:
        return $default(
            _that.id,
            _that.no,
            _that.customerId,
            _that.customerName,
            _that.type,
            _that.stops,
            _that.vehicleType,
            _that.commodity,
            _that.weightKg,
            _that.declaredValue,
            _that.rate,
            _that.status,
            _that.neededBy,
            _that.tripId);
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
            String no,
            String customerId,
            String customerName,
            OrderType type,
            List<OrderStop> stops,
            String vehicleType,
            String commodity,
            double weightKg,
            double? declaredValue,
            int rate,
            OrderStatus status,
            DateTime? neededBy,
            String? tripId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Order():
        return $default(
            _that.id,
            _that.no,
            _that.customerId,
            _that.customerName,
            _that.type,
            _that.stops,
            _that.vehicleType,
            _that.commodity,
            _that.weightKg,
            _that.declaredValue,
            _that.rate,
            _that.status,
            _that.neededBy,
            _that.tripId);
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
            String no,
            String customerId,
            String customerName,
            OrderType type,
            List<OrderStop> stops,
            String vehicleType,
            String commodity,
            double weightKg,
            double? declaredValue,
            int rate,
            OrderStatus status,
            DateTime? neededBy,
            String? tripId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Order() when $default != null:
        return $default(
            _that.id,
            _that.no,
            _that.customerId,
            _that.customerName,
            _that.type,
            _that.stops,
            _that.vehicleType,
            _that.commodity,
            _that.weightKg,
            _that.declaredValue,
            _that.rate,
            _that.status,
            _that.neededBy,
            _that.tripId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Order implements Order {
  const _Order(
      {required this.id,
      required this.no,
      required this.customerId,
      required this.customerName,
      required this.type,
      List<OrderStop> stops = const [],
      required this.vehicleType,
      required this.commodity,
      required this.weightKg,
      this.declaredValue,
      required this.rate,
      this.status = OrderStatus.pending,
      this.neededBy,
      this.tripId})
      : _stops = stops;
  factory _Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  @override
  final String id;
  @override
  final String no;
  @override
  final String customerId;
  @override
  final String customerName;
  @override
  final OrderType type;
  final List<OrderStop> _stops;
  @override
  @JsonKey()
  List<OrderStop> get stops {
    if (_stops is EqualUnmodifiableListView) return _stops;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stops);
  }

  @override
  final String vehicleType;
  @override
  final String commodity;
  @override
  final double weightKg;
  @override
  final double? declaredValue;
  @override
  final int rate;
  @override
  @JsonKey()
  final OrderStatus status;
  @override
  final DateTime? neededBy;
  @override
  final String? tripId;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrderCopyWith<_Order> get copyWith =>
      __$OrderCopyWithImpl<_Order>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OrderToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Order &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.no, no) || other.no == no) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.stops, _stops) &&
            (identical(other.vehicleType, vehicleType) ||
                other.vehicleType == vehicleType) &&
            (identical(other.commodity, commodity) ||
                other.commodity == commodity) &&
            (identical(other.weightKg, weightKg) ||
                other.weightKg == weightKg) &&
            (identical(other.declaredValue, declaredValue) ||
                other.declaredValue == declaredValue) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.neededBy, neededBy) ||
                other.neededBy == neededBy) &&
            (identical(other.tripId, tripId) || other.tripId == tripId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        id,
        no,
        customerId,
        customerName,
        type,
        const DeepCollectionEquality().hash(_stops),
        vehicleType,
        commodity,
        weightKg,
        declaredValue,
        rate,
        status,
        neededBy,
        tripId);
  }

  @override
  String toString() {
    return 'Order(id: $id, no: $no, customerId: $customerId, customerName: $customerName, type: $type, stops: $stops, vehicleType: $vehicleType, commodity: $commodity, weightKg: $weightKg, declaredValue: $declaredValue, rate: $rate, status: $status, neededBy: $neededBy, tripId: $tripId)';
  }
}

/// @nodoc
abstract mixin class _$OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$OrderCopyWith(_Order value, $Res Function(_Order) _then) =
      __$OrderCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String no,
      String customerId,
      String customerName,
      OrderType type,
      List<OrderStop> stops,
      String vehicleType,
      String commodity,
      double weightKg,
      double? declaredValue,
      int rate,
      OrderStatus status,
      DateTime? neededBy,
      String? tripId});
}

/// @nodoc
class __$OrderCopyWithImpl<$Res> implements _$OrderCopyWith<$Res> {
  __$OrderCopyWithImpl(this._self, this._then);

  final _Order _self;
  final $Res Function(_Order) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? no = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? type = null,
    Object? stops = null,
    Object? vehicleType = null,
    Object? commodity = null,
    Object? weightKg = null,
    Object? declaredValue = freezed,
    Object? rate = null,
    Object? status = null,
    Object? neededBy = freezed,
    Object? tripId = freezed,
  }) {
    return _then(_Order(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      no: null == no
          ? _self.no
          : no // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _self.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      customerName: null == customerName
          ? _self.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as OrderType,
      stops: null == stops
          ? _self._stops
          : stops // ignore: cast_nullable_to_non_nullable
              as List<OrderStop>,
      vehicleType: null == vehicleType
          ? _self.vehicleType
          : vehicleType // ignore: cast_nullable_to_non_nullable
              as String,
      commodity: null == commodity
          ? _self.commodity
          : commodity // ignore: cast_nullable_to_non_nullable
              as String,
      weightKg: null == weightKg
          ? _self.weightKg
          : weightKg // ignore: cast_nullable_to_non_nullable
              as double,
      declaredValue: freezed == declaredValue
          ? _self.declaredValue
          : declaredValue // ignore: cast_nullable_to_non_nullable
              as double?,
      rate: null == rate
          ? _self.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      neededBy: freezed == neededBy
          ? _self.neededBy
          : neededBy // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tripId: freezed == tripId
          ? _self.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
