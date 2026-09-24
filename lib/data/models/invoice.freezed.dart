// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Invoice {
  String get id;
  String get no;
  String get customerId;
  String get customerName;
  int get amount;
  int get gst;
  InvoiceStatus get status;
  DateTime get dueDate;
  String? get irn;
  int get paidAmount;

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InvoiceCopyWith<Invoice> get copyWith =>
      _$InvoiceCopyWithImpl<Invoice>(this as Invoice, _$identity);

  /// Serializes this Invoice to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as Invoice;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Invoice &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.no, _this.no) || other.no == _this.no) &&
            (identical(other.customerId, _this.customerId) ||
                other.customerId == _this.customerId) &&
            (identical(other.customerName, _this.customerName) ||
                other.customerName == _this.customerName) &&
            (identical(other.amount, _this.amount) ||
                other.amount == _this.amount) &&
            (identical(other.gst, _this.gst) || other.gst == _this.gst) &&
            (identical(other.status, _this.status) ||
                other.status == _this.status) &&
            (identical(other.dueDate, _this.dueDate) ||
                other.dueDate == _this.dueDate) &&
            (identical(other.irn, _this.irn) || other.irn == _this.irn) &&
            (identical(other.paidAmount, _this.paidAmount) ||
                other.paidAmount == _this.paidAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as Invoice;
    return Object.hash(
        runtimeType,
        _this.id,
        _this.no,
        _this.customerId,
        _this.customerName,
        _this.amount,
        _this.gst,
        _this.status,
        _this.dueDate,
        _this.irn,
        _this.paidAmount);
  }

  @override
  String toString() {
    final _this = this as Invoice;
    return 'Invoice(id: ${_this.id}, no: ${_this.no}, customerId: ${_this.customerId}, customerName: ${_this.customerName}, amount: ${_this.amount}, gst: ${_this.gst}, status: ${_this.status}, dueDate: ${_this.dueDate}, irn: ${_this.irn}, paidAmount: ${_this.paidAmount})';
  }
}

/// @nodoc
abstract mixin class $InvoiceCopyWith<$Res> {
  factory $InvoiceCopyWith(Invoice value, $Res Function(Invoice) _then) =
      _$InvoiceCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String no,
      String customerId,
      String customerName,
      int amount,
      int gst,
      InvoiceStatus status,
      DateTime dueDate,
      String? irn,
      int paidAmount});
}

/// @nodoc
class _$InvoiceCopyWithImpl<$Res> implements $InvoiceCopyWith<$Res> {
  _$InvoiceCopyWithImpl(this._self, this._then);

  final Invoice _self;
  final $Res Function(Invoice) _then;

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? no = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? amount = null,
    Object? gst = null,
    Object? status = null,
    Object? dueDate = null,
    Object? irn = freezed,
    Object? paidAmount = null,
  }) {
    return _then(Invoice(
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
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      gst: null == gst
          ? _self.gst
          : gst // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as InvoiceStatus,
      dueDate: null == dueDate
          ? _self.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      irn: freezed == irn
          ? _self.irn
          : irn // ignore: cast_nullable_to_non_nullable
              as String?,
      paidAmount: null == paidAmount
          ? _self.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [Invoice].
extension InvoicePatterns on Invoice {
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
    TResult Function(_Invoice value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Invoice() when $default != null:
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
    TResult Function(_Invoice value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Invoice():
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
    TResult? Function(_Invoice value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Invoice() when $default != null:
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
            int amount,
            int gst,
            InvoiceStatus status,
            DateTime dueDate,
            String? irn,
            int paidAmount)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Invoice() when $default != null:
        return $default(
            _that.id,
            _that.no,
            _that.customerId,
            _that.customerName,
            _that.amount,
            _that.gst,
            _that.status,
            _that.dueDate,
            _that.irn,
            _that.paidAmount);
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
            int amount,
            int gst,
            InvoiceStatus status,
            DateTime dueDate,
            String? irn,
            int paidAmount)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Invoice():
        return $default(
            _that.id,
            _that.no,
            _that.customerId,
            _that.customerName,
            _that.amount,
            _that.gst,
            _that.status,
            _that.dueDate,
            _that.irn,
            _that.paidAmount);
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
            int amount,
            int gst,
            InvoiceStatus status,
            DateTime dueDate,
            String? irn,
            int paidAmount)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Invoice() when $default != null:
        return $default(
            _that.id,
            _that.no,
            _that.customerId,
            _that.customerName,
            _that.amount,
            _that.gst,
            _that.status,
            _that.dueDate,
            _that.irn,
            _that.paidAmount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Invoice implements Invoice {
  const _Invoice(
      {required this.id,
      required this.no,
      required this.customerId,
      required this.customerName,
      required this.amount,
      required this.gst,
      this.status = InvoiceStatus.sent,
      required this.dueDate,
      this.irn,
      this.paidAmount = 0});
  factory _Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);

  @override
  final String id;
  @override
  final String no;
  @override
  final String customerId;
  @override
  final String customerName;
  @override
  final int amount;
  @override
  final int gst;
  @override
  @JsonKey()
  final InvoiceStatus status;
  @override
  final DateTime dueDate;
  @override
  final String? irn;
  @override
  @JsonKey()
  final int paidAmount;

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InvoiceCopyWith<_Invoice> get copyWith =>
      __$InvoiceCopyWithImpl<_Invoice>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$InvoiceToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Invoice &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.no, no) || other.no == no) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.gst, gst) || other.gst == gst) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.irn, irn) || other.irn == irn) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, id, no, customerId, customerName, amount,
        gst, status, dueDate, irn, paidAmount);
  }

  @override
  String toString() {
    return 'Invoice(id: $id, no: $no, customerId: $customerId, customerName: $customerName, amount: $amount, gst: $gst, status: $status, dueDate: $dueDate, irn: $irn, paidAmount: $paidAmount)';
  }
}

/// @nodoc
abstract mixin class _$InvoiceCopyWith<$Res> implements $InvoiceCopyWith<$Res> {
  factory _$InvoiceCopyWith(_Invoice value, $Res Function(_Invoice) _then) =
      __$InvoiceCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String no,
      String customerId,
      String customerName,
      int amount,
      int gst,
      InvoiceStatus status,
      DateTime dueDate,
      String? irn,
      int paidAmount});
}

/// @nodoc
class __$InvoiceCopyWithImpl<$Res> implements _$InvoiceCopyWith<$Res> {
  __$InvoiceCopyWithImpl(this._self, this._then);

  final _Invoice _self;
  final $Res Function(_Invoice) _then;

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? no = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? amount = null,
    Object? gst = null,
    Object? status = null,
    Object? dueDate = null,
    Object? irn = freezed,
    Object? paidAmount = null,
  }) {
    return _then(_Invoice(
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
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      gst: null == gst
          ? _self.gst
          : gst // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as InvoiceStatus,
      dueDate: null == dueDate
          ? _self.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      irn: freezed == irn
          ? _self.irn
          : irn // ignore: cast_nullable_to_non_nullable
              as String?,
      paidAmount: null == paidAmount
          ? _self.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$Receipt {
  String get id;
  String get customerId;
  List<String> get invoiceIds;
  int get amount;
  String get mode;
  String? get utr;
  int get tds;
  String? get shortPayReason;
  DateTime get at;

  /// Create a copy of Receipt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReceiptCopyWith<Receipt> get copyWith =>
      _$ReceiptCopyWithImpl<Receipt>(this as Receipt, _$identity);

  /// Serializes this Receipt to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as Receipt;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Receipt &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.customerId, _this.customerId) ||
                other.customerId == _this.customerId) &&
            const DeepCollectionEquality()
                .equals(other.invoiceIds, _this.invoiceIds) &&
            (identical(other.amount, _this.amount) ||
                other.amount == _this.amount) &&
            (identical(other.mode, _this.mode) || other.mode == _this.mode) &&
            (identical(other.utr, _this.utr) || other.utr == _this.utr) &&
            (identical(other.tds, _this.tds) || other.tds == _this.tds) &&
            (identical(other.shortPayReason, _this.shortPayReason) ||
                other.shortPayReason == _this.shortPayReason) &&
            (identical(other.at, _this.at) || other.at == _this.at));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as Receipt;
    return Object.hash(
        runtimeType,
        _this.id,
        _this.customerId,
        const DeepCollectionEquality().hash(_this.invoiceIds),
        _this.amount,
        _this.mode,
        _this.utr,
        _this.tds,
        _this.shortPayReason,
        _this.at);
  }

  @override
  String toString() {
    final _this = this as Receipt;
    return 'Receipt(id: ${_this.id}, customerId: ${_this.customerId}, invoiceIds: ${_this.invoiceIds}, amount: ${_this.amount}, mode: ${_this.mode}, utr: ${_this.utr}, tds: ${_this.tds}, shortPayReason: ${_this.shortPayReason}, at: ${_this.at})';
  }
}

/// @nodoc
abstract mixin class $ReceiptCopyWith<$Res> {
  factory $ReceiptCopyWith(Receipt value, $Res Function(Receipt) _then) =
      _$ReceiptCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String customerId,
      List<String> invoiceIds,
      int amount,
      String mode,
      String? utr,
      int tds,
      String? shortPayReason,
      DateTime at});
}

/// @nodoc
class _$ReceiptCopyWithImpl<$Res> implements $ReceiptCopyWith<$Res> {
  _$ReceiptCopyWithImpl(this._self, this._then);

  final Receipt _self;
  final $Res Function(Receipt) _then;

  /// Create a copy of Receipt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? invoiceIds = null,
    Object? amount = null,
    Object? mode = null,
    Object? utr = freezed,
    Object? tds = null,
    Object? shortPayReason = freezed,
    Object? at = null,
  }) {
    return _then(Receipt(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _self.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceIds: null == invoiceIds
          ? _self.invoiceIds
          : invoiceIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      mode: null == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as String,
      utr: freezed == utr
          ? _self.utr
          : utr // ignore: cast_nullable_to_non_nullable
              as String?,
      tds: null == tds
          ? _self.tds
          : tds // ignore: cast_nullable_to_non_nullable
              as int,
      shortPayReason: freezed == shortPayReason
          ? _self.shortPayReason
          : shortPayReason // ignore: cast_nullable_to_non_nullable
              as String?,
      at: null == at
          ? _self.at
          : at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [Receipt].
extension ReceiptPatterns on Receipt {
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
    TResult Function(_Receipt value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Receipt() when $default != null:
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
    TResult Function(_Receipt value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Receipt():
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
    TResult? Function(_Receipt value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Receipt() when $default != null:
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
            String customerId,
            List<String> invoiceIds,
            int amount,
            String mode,
            String? utr,
            int tds,
            String? shortPayReason,
            DateTime at)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Receipt() when $default != null:
        return $default(
            _that.id,
            _that.customerId,
            _that.invoiceIds,
            _that.amount,
            _that.mode,
            _that.utr,
            _that.tds,
            _that.shortPayReason,
            _that.at);
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
            String customerId,
            List<String> invoiceIds,
            int amount,
            String mode,
            String? utr,
            int tds,
            String? shortPayReason,
            DateTime at)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Receipt():
        return $default(
            _that.id,
            _that.customerId,
            _that.invoiceIds,
            _that.amount,
            _that.mode,
            _that.utr,
            _that.tds,
            _that.shortPayReason,
            _that.at);
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
            String customerId,
            List<String> invoiceIds,
            int amount,
            String mode,
            String? utr,
            int tds,
            String? shortPayReason,
            DateTime at)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Receipt() when $default != null:
        return $default(
            _that.id,
            _that.customerId,
            _that.invoiceIds,
            _that.amount,
            _that.mode,
            _that.utr,
            _that.tds,
            _that.shortPayReason,
            _that.at);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Receipt implements Receipt {
  const _Receipt(
      {required this.id,
      required this.customerId,
      List<String> invoiceIds = const [],
      required this.amount,
      required this.mode,
      this.utr,
      this.tds = 0,
      this.shortPayReason,
      required this.at})
      : _invoiceIds = invoiceIds;
  factory _Receipt.fromJson(Map<String, dynamic> json) =>
      _$ReceiptFromJson(json);

  @override
  final String id;
  @override
  final String customerId;
  final List<String> _invoiceIds;
  @override
  @JsonKey()
  List<String> get invoiceIds {
    if (_invoiceIds is EqualUnmodifiableListView) return _invoiceIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_invoiceIds);
  }

  @override
  final int amount;
  @override
  final String mode;
  @override
  final String? utr;
  @override
  @JsonKey()
  final int tds;
  @override
  final String? shortPayReason;
  @override
  final DateTime at;

  /// Create a copy of Receipt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReceiptCopyWith<_Receipt> get copyWith =>
      __$ReceiptCopyWithImpl<_Receipt>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReceiptToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Receipt &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            const DeepCollectionEquality()
                .equals(other.invoiceIds, _invoiceIds) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.utr, utr) || other.utr == utr) &&
            (identical(other.tds, tds) || other.tds == tds) &&
            (identical(other.shortPayReason, shortPayReason) ||
                other.shortPayReason == shortPayReason) &&
            (identical(other.at, at) || other.at == at));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        id,
        customerId,
        const DeepCollectionEquality().hash(_invoiceIds),
        amount,
        mode,
        utr,
        tds,
        shortPayReason,
        at);
  }

  @override
  String toString() {
    return 'Receipt(id: $id, customerId: $customerId, invoiceIds: $invoiceIds, amount: $amount, mode: $mode, utr: $utr, tds: $tds, shortPayReason: $shortPayReason, at: $at)';
  }
}

/// @nodoc
abstract mixin class _$ReceiptCopyWith<$Res> implements $ReceiptCopyWith<$Res> {
  factory _$ReceiptCopyWith(_Receipt value, $Res Function(_Receipt) _then) =
      __$ReceiptCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String customerId,
      List<String> invoiceIds,
      int amount,
      String mode,
      String? utr,
      int tds,
      String? shortPayReason,
      DateTime at});
}

/// @nodoc
class __$ReceiptCopyWithImpl<$Res> implements _$ReceiptCopyWith<$Res> {
  __$ReceiptCopyWithImpl(this._self, this._then);

  final _Receipt _self;
  final $Res Function(_Receipt) _then;

  /// Create a copy of Receipt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? invoiceIds = null,
    Object? amount = null,
    Object? mode = null,
    Object? utr = freezed,
    Object? tds = null,
    Object? shortPayReason = freezed,
    Object? at = null,
  }) {
    return _then(_Receipt(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _self.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceIds: null == invoiceIds
          ? _self._invoiceIds
          : invoiceIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      mode: null == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as String,
      utr: freezed == utr
          ? _self.utr
          : utr // ignore: cast_nullable_to_non_nullable
              as String?,
      tds: null == tds
          ? _self.tds
          : tds // ignore: cast_nullable_to_non_nullable
              as int,
      shortPayReason: freezed == shortPayReason
          ? _self.shortPayReason
          : shortPayReason // ignore: cast_nullable_to_non_nullable
              as String?,
      at: null == at
          ? _self.at
          : at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
