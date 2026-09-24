// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'finance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LedgerEntry {
  String get id;
  String get accountName;
  DateTime get date;
  String get particulars;
  int get debit;
  int get credit;
  int get balance;

  /// Create a copy of LedgerEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LedgerEntryCopyWith<LedgerEntry> get copyWith =>
      _$LedgerEntryCopyWithImpl<LedgerEntry>(this as LedgerEntry, _$identity);

  /// Serializes this LedgerEntry to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as LedgerEntry;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LedgerEntry &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.accountName, _this.accountName) ||
                other.accountName == _this.accountName) &&
            (identical(other.date, _this.date) || other.date == _this.date) &&
            (identical(other.particulars, _this.particulars) ||
                other.particulars == _this.particulars) &&
            (identical(other.debit, _this.debit) ||
                other.debit == _this.debit) &&
            (identical(other.credit, _this.credit) ||
                other.credit == _this.credit) &&
            (identical(other.balance, _this.balance) ||
                other.balance == _this.balance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as LedgerEntry;
    return Object.hash(runtimeType, _this.id, _this.accountName, _this.date,
        _this.particulars, _this.debit, _this.credit, _this.balance);
  }

  @override
  String toString() {
    final _this = this as LedgerEntry;
    return 'LedgerEntry(id: ${_this.id}, accountName: ${_this.accountName}, date: ${_this.date}, particulars: ${_this.particulars}, debit: ${_this.debit}, credit: ${_this.credit}, balance: ${_this.balance})';
  }
}

/// @nodoc
abstract mixin class $LedgerEntryCopyWith<$Res> {
  factory $LedgerEntryCopyWith(
          LedgerEntry value, $Res Function(LedgerEntry) _then) =
      _$LedgerEntryCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String accountName,
      DateTime date,
      String particulars,
      int debit,
      int credit,
      int balance});
}

/// @nodoc
class _$LedgerEntryCopyWithImpl<$Res> implements $LedgerEntryCopyWith<$Res> {
  _$LedgerEntryCopyWithImpl(this._self, this._then);

  final LedgerEntry _self;
  final $Res Function(LedgerEntry) _then;

  /// Create a copy of LedgerEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountName = null,
    Object? date = null,
    Object? particulars = null,
    Object? debit = null,
    Object? credit = null,
    Object? balance = null,
  }) {
    return _then(LedgerEntry(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      accountName: null == accountName
          ? _self.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      particulars: null == particulars
          ? _self.particulars
          : particulars // ignore: cast_nullable_to_non_nullable
              as String,
      debit: null == debit
          ? _self.debit
          : debit // ignore: cast_nullable_to_non_nullable
              as int,
      credit: null == credit
          ? _self.credit
          : credit // ignore: cast_nullable_to_non_nullable
              as int,
      balance: null == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [LedgerEntry].
extension LedgerEntryPatterns on LedgerEntry {
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
    TResult Function(_LedgerEntry value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LedgerEntry() when $default != null:
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
    TResult Function(_LedgerEntry value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LedgerEntry():
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
    TResult? Function(_LedgerEntry value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LedgerEntry() when $default != null:
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
    TResult Function(String id, String accountName, DateTime date,
            String particulars, int debit, int credit, int balance)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LedgerEntry() when $default != null:
        return $default(_that.id, _that.accountName, _that.date,
            _that.particulars, _that.debit, _that.credit, _that.balance);
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
    TResult Function(String id, String accountName, DateTime date,
            String particulars, int debit, int credit, int balance)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LedgerEntry():
        return $default(_that.id, _that.accountName, _that.date,
            _that.particulars, _that.debit, _that.credit, _that.balance);
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
    TResult? Function(String id, String accountName, DateTime date,
            String particulars, int debit, int credit, int balance)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LedgerEntry() when $default != null:
        return $default(_that.id, _that.accountName, _that.date,
            _that.particulars, _that.debit, _that.credit, _that.balance);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LedgerEntry implements LedgerEntry {
  const _LedgerEntry(
      {required this.id,
      required this.accountName,
      required this.date,
      required this.particulars,
      this.debit = 0,
      this.credit = 0,
      this.balance = 0});
  factory _LedgerEntry.fromJson(Map<String, dynamic> json) =>
      _$LedgerEntryFromJson(json);

  @override
  final String id;
  @override
  final String accountName;
  @override
  final DateTime date;
  @override
  final String particulars;
  @override
  @JsonKey()
  final int debit;
  @override
  @JsonKey()
  final int credit;
  @override
  @JsonKey()
  final int balance;

  /// Create a copy of LedgerEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LedgerEntryCopyWith<_LedgerEntry> get copyWith =>
      __$LedgerEntryCopyWithImpl<_LedgerEntry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LedgerEntryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LedgerEntry &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.accountName, accountName) ||
                other.accountName == accountName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.particulars, particulars) ||
                other.particulars == particulars) &&
            (identical(other.debit, debit) || other.debit == debit) &&
            (identical(other.credit, credit) || other.credit == credit) &&
            (identical(other.balance, balance) || other.balance == balance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, id, accountName, date, particulars, debit,
        credit, balance);
  }

  @override
  String toString() {
    return 'LedgerEntry(id: $id, accountName: $accountName, date: $date, particulars: $particulars, debit: $debit, credit: $credit, balance: $balance)';
  }
}

/// @nodoc
abstract mixin class _$LedgerEntryCopyWith<$Res>
    implements $LedgerEntryCopyWith<$Res> {
  factory _$LedgerEntryCopyWith(
          _LedgerEntry value, $Res Function(_LedgerEntry) _then) =
      __$LedgerEntryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String accountName,
      DateTime date,
      String particulars,
      int debit,
      int credit,
      int balance});
}

/// @nodoc
class __$LedgerEntryCopyWithImpl<$Res> implements _$LedgerEntryCopyWith<$Res> {
  __$LedgerEntryCopyWithImpl(this._self, this._then);

  final _LedgerEntry _self;
  final $Res Function(_LedgerEntry) _then;

  /// Create a copy of LedgerEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? accountName = null,
    Object? date = null,
    Object? particulars = null,
    Object? debit = null,
    Object? credit = null,
    Object? balance = null,
  }) {
    return _then(_LedgerEntry(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      accountName: null == accountName
          ? _self.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      particulars: null == particulars
          ? _self.particulars
          : particulars // ignore: cast_nullable_to_non_nullable
              as String,
      debit: null == debit
          ? _self.debit
          : debit // ignore: cast_nullable_to_non_nullable
              as int,
      credit: null == credit
          ? _self.credit
          : credit // ignore: cast_nullable_to_non_nullable
              as int,
      balance: null == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$AgeingBucket {
  String get label;
  int get amount;

  /// Create a copy of AgeingBucket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AgeingBucketCopyWith<AgeingBucket> get copyWith =>
      _$AgeingBucketCopyWithImpl<AgeingBucket>(
          this as AgeingBucket, _$identity);

  /// Serializes this AgeingBucket to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as AgeingBucket;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AgeingBucket &&
            (identical(other.label, _this.label) ||
                other.label == _this.label) &&
            (identical(other.amount, _this.amount) ||
                other.amount == _this.amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as AgeingBucket;
    return Object.hash(runtimeType, _this.label, _this.amount);
  }

  @override
  String toString() {
    final _this = this as AgeingBucket;
    return 'AgeingBucket(label: ${_this.label}, amount: ${_this.amount})';
  }
}

/// @nodoc
abstract mixin class $AgeingBucketCopyWith<$Res> {
  factory $AgeingBucketCopyWith(
          AgeingBucket value, $Res Function(AgeingBucket) _then) =
      _$AgeingBucketCopyWithImpl;
  @useResult
  $Res call({String label, int amount});
}

/// @nodoc
class _$AgeingBucketCopyWithImpl<$Res> implements $AgeingBucketCopyWith<$Res> {
  _$AgeingBucketCopyWithImpl(this._self, this._then);

  final AgeingBucket _self;
  final $Res Function(AgeingBucket) _then;

  /// Create a copy of AgeingBucket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? amount = null,
  }) {
    return _then(AgeingBucket(
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [AgeingBucket].
extension AgeingBucketPatterns on AgeingBucket {
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
    TResult Function(_AgeingBucket value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AgeingBucket() when $default != null:
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
    TResult Function(_AgeingBucket value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AgeingBucket():
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
    TResult? Function(_AgeingBucket value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AgeingBucket() when $default != null:
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
    TResult Function(String label, int amount)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AgeingBucket() when $default != null:
        return $default(_that.label, _that.amount);
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
    TResult Function(String label, int amount) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AgeingBucket():
        return $default(_that.label, _that.amount);
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
    TResult? Function(String label, int amount)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AgeingBucket() when $default != null:
        return $default(_that.label, _that.amount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AgeingBucket implements AgeingBucket {
  const _AgeingBucket({required this.label, required this.amount});
  factory _AgeingBucket.fromJson(Map<String, dynamic> json) =>
      _$AgeingBucketFromJson(json);

  @override
  final String label;
  @override
  final int amount;

  /// Create a copy of AgeingBucket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AgeingBucketCopyWith<_AgeingBucket> get copyWith =>
      __$AgeingBucketCopyWithImpl<_AgeingBucket>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AgeingBucketToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AgeingBucket &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, label, amount);
  }

  @override
  String toString() {
    return 'AgeingBucket(label: $label, amount: $amount)';
  }
}

/// @nodoc
abstract mixin class _$AgeingBucketCopyWith<$Res>
    implements $AgeingBucketCopyWith<$Res> {
  factory _$AgeingBucketCopyWith(
          _AgeingBucket value, $Res Function(_AgeingBucket) _then) =
      __$AgeingBucketCopyWithImpl;
  @override
  @useResult
  $Res call({String label, int amount});
}

/// @nodoc
class __$AgeingBucketCopyWithImpl<$Res>
    implements _$AgeingBucketCopyWith<$Res> {
  __$AgeingBucketCopyWithImpl(this._self, this._then);

  final _AgeingBucket _self;
  final $Res Function(_AgeingBucket) _then;

  /// Create a copy of AgeingBucket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? label = null,
    Object? amount = null,
  }) {
    return _then(_AgeingBucket(
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$BankAccount {
  String get name;
  int get balance;

  /// Create a copy of BankAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BankAccountCopyWith<BankAccount> get copyWith =>
      _$BankAccountCopyWithImpl<BankAccount>(this as BankAccount, _$identity);

  /// Serializes this BankAccount to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as BankAccount;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BankAccount &&
            (identical(other.name, _this.name) || other.name == _this.name) &&
            (identical(other.balance, _this.balance) ||
                other.balance == _this.balance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as BankAccount;
    return Object.hash(runtimeType, _this.name, _this.balance);
  }

  @override
  String toString() {
    final _this = this as BankAccount;
    return 'BankAccount(name: ${_this.name}, balance: ${_this.balance})';
  }
}

/// @nodoc
abstract mixin class $BankAccountCopyWith<$Res> {
  factory $BankAccountCopyWith(
          BankAccount value, $Res Function(BankAccount) _then) =
      _$BankAccountCopyWithImpl;
  @useResult
  $Res call({String name, int balance});
}

/// @nodoc
class _$BankAccountCopyWithImpl<$Res> implements $BankAccountCopyWith<$Res> {
  _$BankAccountCopyWithImpl(this._self, this._then);

  final BankAccount _self;
  final $Res Function(BankAccount) _then;

  /// Create a copy of BankAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? balance = null,
  }) {
    return _then(BankAccount(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [BankAccount].
extension BankAccountPatterns on BankAccount {
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
    TResult Function(_BankAccount value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BankAccount() when $default != null:
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
    TResult Function(_BankAccount value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BankAccount():
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
    TResult? Function(_BankAccount value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BankAccount() when $default != null:
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
    TResult Function(String name, int balance)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BankAccount() when $default != null:
        return $default(_that.name, _that.balance);
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
    TResult Function(String name, int balance) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BankAccount():
        return $default(_that.name, _that.balance);
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
    TResult? Function(String name, int balance)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BankAccount() when $default != null:
        return $default(_that.name, _that.balance);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BankAccount implements BankAccount {
  const _BankAccount({required this.name, required this.balance});
  factory _BankAccount.fromJson(Map<String, dynamic> json) =>
      _$BankAccountFromJson(json);

  @override
  final String name;
  @override
  final int balance;

  /// Create a copy of BankAccount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BankAccountCopyWith<_BankAccount> get copyWith =>
      __$BankAccountCopyWithImpl<_BankAccount>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BankAccountToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BankAccount &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.balance, balance) || other.balance == balance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, name, balance);
  }

  @override
  String toString() {
    return 'BankAccount(name: $name, balance: $balance)';
  }
}

/// @nodoc
abstract mixin class _$BankAccountCopyWith<$Res>
    implements $BankAccountCopyWith<$Res> {
  factory _$BankAccountCopyWith(
          _BankAccount value, $Res Function(_BankAccount) _then) =
      __$BankAccountCopyWithImpl;
  @override
  @useResult
  $Res call({String name, int balance});
}

/// @nodoc
class __$BankAccountCopyWithImpl<$Res> implements _$BankAccountCopyWith<$Res> {
  __$BankAccountCopyWithImpl(this._self, this._then);

  final _BankAccount _self;
  final $Res Function(_BankAccount) _then;

  /// Create a copy of BankAccount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? balance = null,
  }) {
    return _then(_BankAccount(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$GstSummary {
  String get month;
  int get cgst;
  int get sgst;
  int get igst;

  /// Create a copy of GstSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GstSummaryCopyWith<GstSummary> get copyWith =>
      _$GstSummaryCopyWithImpl<GstSummary>(this as GstSummary, _$identity);

  /// Serializes this GstSummary to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as GstSummary;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GstSummary &&
            (identical(other.month, _this.month) ||
                other.month == _this.month) &&
            (identical(other.cgst, _this.cgst) || other.cgst == _this.cgst) &&
            (identical(other.sgst, _this.sgst) || other.sgst == _this.sgst) &&
            (identical(other.igst, _this.igst) || other.igst == _this.igst));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as GstSummary;
    return Object.hash(
        runtimeType, _this.month, _this.cgst, _this.sgst, _this.igst);
  }

  @override
  String toString() {
    final _this = this as GstSummary;
    return 'GstSummary(month: ${_this.month}, cgst: ${_this.cgst}, sgst: ${_this.sgst}, igst: ${_this.igst})';
  }
}

/// @nodoc
abstract mixin class $GstSummaryCopyWith<$Res> {
  factory $GstSummaryCopyWith(
          GstSummary value, $Res Function(GstSummary) _then) =
      _$GstSummaryCopyWithImpl;
  @useResult
  $Res call({String month, int cgst, int sgst, int igst});
}

/// @nodoc
class _$GstSummaryCopyWithImpl<$Res> implements $GstSummaryCopyWith<$Res> {
  _$GstSummaryCopyWithImpl(this._self, this._then);

  final GstSummary _self;
  final $Res Function(GstSummary) _then;

  /// Create a copy of GstSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? cgst = null,
    Object? sgst = null,
    Object? igst = null,
  }) {
    return _then(GstSummary(
      month: null == month
          ? _self.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      cgst: null == cgst
          ? _self.cgst
          : cgst // ignore: cast_nullable_to_non_nullable
              as int,
      sgst: null == sgst
          ? _self.sgst
          : sgst // ignore: cast_nullable_to_non_nullable
              as int,
      igst: null == igst
          ? _self.igst
          : igst // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [GstSummary].
extension GstSummaryPatterns on GstSummary {
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
    TResult Function(_GstSummary value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GstSummary() when $default != null:
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
    TResult Function(_GstSummary value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GstSummary():
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
    TResult? Function(_GstSummary value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GstSummary() when $default != null:
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
    TResult Function(String month, int cgst, int sgst, int igst)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GstSummary() when $default != null:
        return $default(_that.month, _that.cgst, _that.sgst, _that.igst);
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
    TResult Function(String month, int cgst, int sgst, int igst) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GstSummary():
        return $default(_that.month, _that.cgst, _that.sgst, _that.igst);
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
    TResult? Function(String month, int cgst, int sgst, int igst)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GstSummary() when $default != null:
        return $default(_that.month, _that.cgst, _that.sgst, _that.igst);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GstSummary implements GstSummary {
  const _GstSummary(
      {required this.month,
      required this.cgst,
      required this.sgst,
      required this.igst});
  factory _GstSummary.fromJson(Map<String, dynamic> json) =>
      _$GstSummaryFromJson(json);

  @override
  final String month;
  @override
  final int cgst;
  @override
  final int sgst;
  @override
  final int igst;

  /// Create a copy of GstSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GstSummaryCopyWith<_GstSummary> get copyWith =>
      __$GstSummaryCopyWithImpl<_GstSummary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GstSummaryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GstSummary &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.cgst, cgst) || other.cgst == cgst) &&
            (identical(other.sgst, sgst) || other.sgst == sgst) &&
            (identical(other.igst, igst) || other.igst == igst));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, month, cgst, sgst, igst);
  }

  @override
  String toString() {
    return 'GstSummary(month: $month, cgst: $cgst, sgst: $sgst, igst: $igst)';
  }
}

/// @nodoc
abstract mixin class _$GstSummaryCopyWith<$Res>
    implements $GstSummaryCopyWith<$Res> {
  factory _$GstSummaryCopyWith(
          _GstSummary value, $Res Function(_GstSummary) _then) =
      __$GstSummaryCopyWithImpl;
  @override
  @useResult
  $Res call({String month, int cgst, int sgst, int igst});
}

/// @nodoc
class __$GstSummaryCopyWithImpl<$Res> implements _$GstSummaryCopyWith<$Res> {
  __$GstSummaryCopyWithImpl(this._self, this._then);

  final _GstSummary _self;
  final $Res Function(_GstSummary) _then;

  /// Create a copy of GstSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? month = null,
    Object? cgst = null,
    Object? sgst = null,
    Object? igst = null,
  }) {
    return _then(_GstSummary(
      month: null == month
          ? _self.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      cgst: null == cgst
          ? _self.cgst
          : cgst // ignore: cast_nullable_to_non_nullable
              as int,
      sgst: null == sgst
          ? _self.sgst
          : sgst // ignore: cast_nullable_to_non_nullable
              as int,
      igst: null == igst
          ? _self.igst
          : igst // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$TripPnl {
  String get tripNo;
  String get lane;
  int get revenue;
  int get cost;
  int get margin;

  /// Create a copy of TripPnl
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TripPnlCopyWith<TripPnl> get copyWith =>
      _$TripPnlCopyWithImpl<TripPnl>(this as TripPnl, _$identity);

  /// Serializes this TripPnl to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as TripPnl;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TripPnl &&
            (identical(other.tripNo, _this.tripNo) ||
                other.tripNo == _this.tripNo) &&
            (identical(other.lane, _this.lane) || other.lane == _this.lane) &&
            (identical(other.revenue, _this.revenue) ||
                other.revenue == _this.revenue) &&
            (identical(other.cost, _this.cost) || other.cost == _this.cost) &&
            (identical(other.margin, _this.margin) ||
                other.margin == _this.margin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as TripPnl;
    return Object.hash(runtimeType, _this.tripNo, _this.lane, _this.revenue,
        _this.cost, _this.margin);
  }

  @override
  String toString() {
    final _this = this as TripPnl;
    return 'TripPnl(tripNo: ${_this.tripNo}, lane: ${_this.lane}, revenue: ${_this.revenue}, cost: ${_this.cost}, margin: ${_this.margin})';
  }
}

/// @nodoc
abstract mixin class $TripPnlCopyWith<$Res> {
  factory $TripPnlCopyWith(TripPnl value, $Res Function(TripPnl) _then) =
      _$TripPnlCopyWithImpl;
  @useResult
  $Res call({String tripNo, String lane, int revenue, int cost, int margin});
}

/// @nodoc
class _$TripPnlCopyWithImpl<$Res> implements $TripPnlCopyWith<$Res> {
  _$TripPnlCopyWithImpl(this._self, this._then);

  final TripPnl _self;
  final $Res Function(TripPnl) _then;

  /// Create a copy of TripPnl
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripNo = null,
    Object? lane = null,
    Object? revenue = null,
    Object? cost = null,
    Object? margin = null,
  }) {
    return _then(TripPnl(
      tripNo: null == tripNo
          ? _self.tripNo
          : tripNo // ignore: cast_nullable_to_non_nullable
              as String,
      lane: null == lane
          ? _self.lane
          : lane // ignore: cast_nullable_to_non_nullable
              as String,
      revenue: null == revenue
          ? _self.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as int,
      cost: null == cost
          ? _self.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as int,
      margin: null == margin
          ? _self.margin
          : margin // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [TripPnl].
extension TripPnlPatterns on TripPnl {
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
    TResult Function(_TripPnl value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TripPnl() when $default != null:
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
    TResult Function(_TripPnl value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TripPnl():
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
    TResult? Function(_TripPnl value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TripPnl() when $default != null:
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
            String tripNo, String lane, int revenue, int cost, int margin)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TripPnl() when $default != null:
        return $default(
            _that.tripNo, _that.lane, _that.revenue, _that.cost, _that.margin);
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
            String tripNo, String lane, int revenue, int cost, int margin)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TripPnl():
        return $default(
            _that.tripNo, _that.lane, _that.revenue, _that.cost, _that.margin);
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
            String tripNo, String lane, int revenue, int cost, int margin)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TripPnl() when $default != null:
        return $default(
            _that.tripNo, _that.lane, _that.revenue, _that.cost, _that.margin);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TripPnl implements TripPnl {
  const _TripPnl(
      {required this.tripNo,
      required this.lane,
      required this.revenue,
      required this.cost,
      required this.margin});
  factory _TripPnl.fromJson(Map<String, dynamic> json) =>
      _$TripPnlFromJson(json);

  @override
  final String tripNo;
  @override
  final String lane;
  @override
  final int revenue;
  @override
  final int cost;
  @override
  final int margin;

  /// Create a copy of TripPnl
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TripPnlCopyWith<_TripPnl> get copyWith =>
      __$TripPnlCopyWithImpl<_TripPnl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TripPnlToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TripPnl &&
            (identical(other.tripNo, tripNo) || other.tripNo == tripNo) &&
            (identical(other.lane, lane) || other.lane == lane) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.margin, margin) || other.margin == margin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, tripNo, lane, revenue, cost, margin);
  }

  @override
  String toString() {
    return 'TripPnl(tripNo: $tripNo, lane: $lane, revenue: $revenue, cost: $cost, margin: $margin)';
  }
}

/// @nodoc
abstract mixin class _$TripPnlCopyWith<$Res> implements $TripPnlCopyWith<$Res> {
  factory _$TripPnlCopyWith(_TripPnl value, $Res Function(_TripPnl) _then) =
      __$TripPnlCopyWithImpl;
  @override
  @useResult
  $Res call({String tripNo, String lane, int revenue, int cost, int margin});
}

/// @nodoc
class __$TripPnlCopyWithImpl<$Res> implements _$TripPnlCopyWith<$Res> {
  __$TripPnlCopyWithImpl(this._self, this._then);

  final _TripPnl _self;
  final $Res Function(_TripPnl) _then;

  /// Create a copy of TripPnl
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tripNo = null,
    Object? lane = null,
    Object? revenue = null,
    Object? cost = null,
    Object? margin = null,
  }) {
    return _then(_TripPnl(
      tripNo: null == tripNo
          ? _self.tripNo
          : tripNo // ignore: cast_nullable_to_non_nullable
              as String,
      lane: null == lane
          ? _self.lane
          : lane // ignore: cast_nullable_to_non_nullable
              as String,
      revenue: null == revenue
          ? _self.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as int,
      cost: null == cost
          ? _self.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as int,
      margin: null == margin
          ? _self.margin
          : margin // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$PnlLine {
  String get label;
  int get amount;

  /// Create a copy of PnlLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PnlLineCopyWith<PnlLine> get copyWith =>
      _$PnlLineCopyWithImpl<PnlLine>(this as PnlLine, _$identity);

  /// Serializes this PnlLine to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as PnlLine;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PnlLine &&
            (identical(other.label, _this.label) ||
                other.label == _this.label) &&
            (identical(other.amount, _this.amount) ||
                other.amount == _this.amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as PnlLine;
    return Object.hash(runtimeType, _this.label, _this.amount);
  }

  @override
  String toString() {
    final _this = this as PnlLine;
    return 'PnlLine(label: ${_this.label}, amount: ${_this.amount})';
  }
}

/// @nodoc
abstract mixin class $PnlLineCopyWith<$Res> {
  factory $PnlLineCopyWith(PnlLine value, $Res Function(PnlLine) _then) =
      _$PnlLineCopyWithImpl;
  @useResult
  $Res call({String label, int amount});
}

/// @nodoc
class _$PnlLineCopyWithImpl<$Res> implements $PnlLineCopyWith<$Res> {
  _$PnlLineCopyWithImpl(this._self, this._then);

  final PnlLine _self;
  final $Res Function(PnlLine) _then;

  /// Create a copy of PnlLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? amount = null,
  }) {
    return _then(PnlLine(
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [PnlLine].
extension PnlLinePatterns on PnlLine {
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
    TResult Function(_PnlLine value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PnlLine() when $default != null:
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
    TResult Function(_PnlLine value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PnlLine():
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
    TResult? Function(_PnlLine value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PnlLine() when $default != null:
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
    TResult Function(String label, int amount)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PnlLine() when $default != null:
        return $default(_that.label, _that.amount);
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
    TResult Function(String label, int amount) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PnlLine():
        return $default(_that.label, _that.amount);
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
    TResult? Function(String label, int amount)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PnlLine() when $default != null:
        return $default(_that.label, _that.amount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PnlLine implements PnlLine {
  const _PnlLine({required this.label, required this.amount});
  factory _PnlLine.fromJson(Map<String, dynamic> json) =>
      _$PnlLineFromJson(json);

  @override
  final String label;
  @override
  final int amount;

  /// Create a copy of PnlLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PnlLineCopyWith<_PnlLine> get copyWith =>
      __$PnlLineCopyWithImpl<_PnlLine>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PnlLineToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PnlLine &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, label, amount);
  }

  @override
  String toString() {
    return 'PnlLine(label: $label, amount: $amount)';
  }
}

/// @nodoc
abstract mixin class _$PnlLineCopyWith<$Res> implements $PnlLineCopyWith<$Res> {
  factory _$PnlLineCopyWith(_PnlLine value, $Res Function(_PnlLine) _then) =
      __$PnlLineCopyWithImpl;
  @override
  @useResult
  $Res call({String label, int amount});
}

/// @nodoc
class __$PnlLineCopyWithImpl<$Res> implements _$PnlLineCopyWith<$Res> {
  __$PnlLineCopyWithImpl(this._self, this._then);

  final _PnlLine _self;
  final $Res Function(_PnlLine) _then;

  /// Create a copy of PnlLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? label = null,
    Object? amount = null,
  }) {
    return _then(_PnlLine(
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
