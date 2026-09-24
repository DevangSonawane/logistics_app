// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomerContact {
  String get name;
  String get phone;
  String? get role;

  /// Create a copy of CustomerContact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomerContactCopyWith<CustomerContact> get copyWith =>
      _$CustomerContactCopyWithImpl<CustomerContact>(
          this as CustomerContact, _$identity);

  /// Serializes this CustomerContact to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as CustomerContact;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomerContact &&
            (identical(other.name, _this.name) || other.name == _this.name) &&
            (identical(other.phone, _this.phone) ||
                other.phone == _this.phone) &&
            (identical(other.role, _this.role) || other.role == _this.role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as CustomerContact;
    return Object.hash(runtimeType, _this.name, _this.phone, _this.role);
  }

  @override
  String toString() {
    final _this = this as CustomerContact;
    return 'CustomerContact(name: ${_this.name}, phone: ${_this.phone}, role: ${_this.role})';
  }
}

/// @nodoc
abstract mixin class $CustomerContactCopyWith<$Res> {
  factory $CustomerContactCopyWith(
          CustomerContact value, $Res Function(CustomerContact) _then) =
      _$CustomerContactCopyWithImpl;
  @useResult
  $Res call({String name, String phone, String? role});
}

/// @nodoc
class _$CustomerContactCopyWithImpl<$Res>
    implements $CustomerContactCopyWith<$Res> {
  _$CustomerContactCopyWithImpl(this._self, this._then);

  final CustomerContact _self;
  final $Res Function(CustomerContact) _then;

  /// Create a copy of CustomerContact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? phone = null,
    Object? role = freezed,
  }) {
    return _then(CustomerContact(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      role: freezed == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CustomerContact].
extension CustomerContactPatterns on CustomerContact {
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
    TResult Function(_CustomerContact value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomerContact() when $default != null:
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
    TResult Function(_CustomerContact value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomerContact():
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
    TResult? Function(_CustomerContact value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomerContact() when $default != null:
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
    TResult Function(String name, String phone, String? role)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomerContact() when $default != null:
        return $default(_that.name, _that.phone, _that.role);
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
    TResult Function(String name, String phone, String? role) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomerContact():
        return $default(_that.name, _that.phone, _that.role);
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
    TResult? Function(String name, String phone, String? role)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomerContact() when $default != null:
        return $default(_that.name, _that.phone, _that.role);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CustomerContact implements CustomerContact {
  const _CustomerContact({required this.name, required this.phone, this.role});
  factory _CustomerContact.fromJson(Map<String, dynamic> json) =>
      _$CustomerContactFromJson(json);

  @override
  final String name;
  @override
  final String phone;
  @override
  final String? role;

  /// Create a copy of CustomerContact
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CustomerContactCopyWith<_CustomerContact> get copyWith =>
      __$CustomerContactCopyWithImpl<_CustomerContact>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CustomerContactToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CustomerContact &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, name, phone, role);
  }

  @override
  String toString() {
    return 'CustomerContact(name: $name, phone: $phone, role: $role)';
  }
}

/// @nodoc
abstract mixin class _$CustomerContactCopyWith<$Res>
    implements $CustomerContactCopyWith<$Res> {
  factory _$CustomerContactCopyWith(
          _CustomerContact value, $Res Function(_CustomerContact) _then) =
      __$CustomerContactCopyWithImpl;
  @override
  @useResult
  $Res call({String name, String phone, String? role});
}

/// @nodoc
class __$CustomerContactCopyWithImpl<$Res>
    implements _$CustomerContactCopyWith<$Res> {
  __$CustomerContactCopyWithImpl(this._self, this._then);

  final _CustomerContact _self;
  final $Res Function(_CustomerContact) _then;

  /// Create a copy of CustomerContact
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? phone = null,
    Object? role = freezed,
  }) {
    return _then(_CustomerContact(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      role: freezed == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$Customer {
  String get id;
  String get name;
  String get gstin;
  String? get pan;
  int get creditDays;
  int get creditLimit;
  int get outstanding;
  List<CustomerContact> get contacts;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomerCopyWith<Customer> get copyWith =>
      _$CustomerCopyWithImpl<Customer>(this as Customer, _$identity);

  /// Serializes this Customer to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as Customer;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Customer &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.name, _this.name) || other.name == _this.name) &&
            (identical(other.gstin, _this.gstin) ||
                other.gstin == _this.gstin) &&
            (identical(other.pan, _this.pan) || other.pan == _this.pan) &&
            (identical(other.creditDays, _this.creditDays) ||
                other.creditDays == _this.creditDays) &&
            (identical(other.creditLimit, _this.creditLimit) ||
                other.creditLimit == _this.creditLimit) &&
            (identical(other.outstanding, _this.outstanding) ||
                other.outstanding == _this.outstanding) &&
            const DeepCollectionEquality()
                .equals(other.contacts, _this.contacts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as Customer;
    return Object.hash(
        runtimeType,
        _this.id,
        _this.name,
        _this.gstin,
        _this.pan,
        _this.creditDays,
        _this.creditLimit,
        _this.outstanding,
        const DeepCollectionEquality().hash(_this.contacts));
  }

  @override
  String toString() {
    final _this = this as Customer;
    return 'Customer(id: ${_this.id}, name: ${_this.name}, gstin: ${_this.gstin}, pan: ${_this.pan}, creditDays: ${_this.creditDays}, creditLimit: ${_this.creditLimit}, outstanding: ${_this.outstanding}, contacts: ${_this.contacts})';
  }
}

/// @nodoc
abstract mixin class $CustomerCopyWith<$Res> {
  factory $CustomerCopyWith(Customer value, $Res Function(Customer) _then) =
      _$CustomerCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String gstin,
      String? pan,
      int creditDays,
      int creditLimit,
      int outstanding,
      List<CustomerContact> contacts});
}

/// @nodoc
class _$CustomerCopyWithImpl<$Res> implements $CustomerCopyWith<$Res> {
  _$CustomerCopyWithImpl(this._self, this._then);

  final Customer _self;
  final $Res Function(Customer) _then;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? gstin = null,
    Object? pan = freezed,
    Object? creditDays = null,
    Object? creditLimit = null,
    Object? outstanding = null,
    Object? contacts = null,
  }) {
    return _then(Customer(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      gstin: null == gstin
          ? _self.gstin
          : gstin // ignore: cast_nullable_to_non_nullable
              as String,
      pan: freezed == pan
          ? _self.pan
          : pan // ignore: cast_nullable_to_non_nullable
              as String?,
      creditDays: null == creditDays
          ? _self.creditDays
          : creditDays // ignore: cast_nullable_to_non_nullable
              as int,
      creditLimit: null == creditLimit
          ? _self.creditLimit
          : creditLimit // ignore: cast_nullable_to_non_nullable
              as int,
      outstanding: null == outstanding
          ? _self.outstanding
          : outstanding // ignore: cast_nullable_to_non_nullable
              as int,
      contacts: null == contacts
          ? _self.contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<CustomerContact>,
    ));
  }
}

/// Adds pattern-matching-related methods to [Customer].
extension CustomerPatterns on Customer {
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
    TResult Function(_Customer value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Customer() when $default != null:
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
    TResult Function(_Customer value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Customer():
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
    TResult? Function(_Customer value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Customer() when $default != null:
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
            String gstin,
            String? pan,
            int creditDays,
            int creditLimit,
            int outstanding,
            List<CustomerContact> contacts)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Customer() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.gstin,
            _that.pan,
            _that.creditDays,
            _that.creditLimit,
            _that.outstanding,
            _that.contacts);
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
            String gstin,
            String? pan,
            int creditDays,
            int creditLimit,
            int outstanding,
            List<CustomerContact> contacts)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Customer():
        return $default(
            _that.id,
            _that.name,
            _that.gstin,
            _that.pan,
            _that.creditDays,
            _that.creditLimit,
            _that.outstanding,
            _that.contacts);
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
            String gstin,
            String? pan,
            int creditDays,
            int creditLimit,
            int outstanding,
            List<CustomerContact> contacts)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Customer() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.gstin,
            _that.pan,
            _that.creditDays,
            _that.creditLimit,
            _that.outstanding,
            _that.contacts);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Customer implements Customer {
  const _Customer(
      {required this.id,
      required this.name,
      required this.gstin,
      this.pan,
      this.creditDays = 30,
      this.creditLimit = 0,
      this.outstanding = 0,
      List<CustomerContact> contacts = const []})
      : _contacts = contacts;
  factory _Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String gstin;
  @override
  final String? pan;
  @override
  @JsonKey()
  final int creditDays;
  @override
  @JsonKey()
  final int creditLimit;
  @override
  @JsonKey()
  final int outstanding;
  final List<CustomerContact> _contacts;
  @override
  @JsonKey()
  List<CustomerContact> get contacts {
    if (_contacts is EqualUnmodifiableListView) return _contacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contacts);
  }

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CustomerCopyWith<_Customer> get copyWith =>
      __$CustomerCopyWithImpl<_Customer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CustomerToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Customer &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.gstin, gstin) || other.gstin == gstin) &&
            (identical(other.pan, pan) || other.pan == pan) &&
            (identical(other.creditDays, creditDays) ||
                other.creditDays == creditDays) &&
            (identical(other.creditLimit, creditLimit) ||
                other.creditLimit == creditLimit) &&
            (identical(other.outstanding, outstanding) ||
                other.outstanding == outstanding) &&
            const DeepCollectionEquality().equals(other.contacts, _contacts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        id,
        name,
        gstin,
        pan,
        creditDays,
        creditLimit,
        outstanding,
        const DeepCollectionEquality().hash(_contacts));
  }

  @override
  String toString() {
    return 'Customer(id: $id, name: $name, gstin: $gstin, pan: $pan, creditDays: $creditDays, creditLimit: $creditLimit, outstanding: $outstanding, contacts: $contacts)';
  }
}

/// @nodoc
abstract mixin class _$CustomerCopyWith<$Res>
    implements $CustomerCopyWith<$Res> {
  factory _$CustomerCopyWith(_Customer value, $Res Function(_Customer) _then) =
      __$CustomerCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String gstin,
      String? pan,
      int creditDays,
      int creditLimit,
      int outstanding,
      List<CustomerContact> contacts});
}

/// @nodoc
class __$CustomerCopyWithImpl<$Res> implements _$CustomerCopyWith<$Res> {
  __$CustomerCopyWithImpl(this._self, this._then);

  final _Customer _self;
  final $Res Function(_Customer) _then;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? gstin = null,
    Object? pan = freezed,
    Object? creditDays = null,
    Object? creditLimit = null,
    Object? outstanding = null,
    Object? contacts = null,
  }) {
    return _then(_Customer(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      gstin: null == gstin
          ? _self.gstin
          : gstin // ignore: cast_nullable_to_non_nullable
              as String,
      pan: freezed == pan
          ? _self.pan
          : pan // ignore: cast_nullable_to_non_nullable
              as String?,
      creditDays: null == creditDays
          ? _self.creditDays
          : creditDays // ignore: cast_nullable_to_non_nullable
              as int,
      creditLimit: null == creditLimit
          ? _self.creditLimit
          : creditLimit // ignore: cast_nullable_to_non_nullable
              as int,
      outstanding: null == outstanding
          ? _self.outstanding
          : outstanding // ignore: cast_nullable_to_non_nullable
              as int,
      contacts: null == contacts
          ? _self._contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<CustomerContact>,
    ));
  }
}

// dart format on
