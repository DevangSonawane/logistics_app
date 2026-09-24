// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppUser {
  String get id;
  String get name;
  String get phone;
  List<AppRole> get roles;
  List<String> get branchIds;
  String? get avatarUrl;
  String get language;
  bool get canRecordReceipt;
  bool get isActive;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<AppUser> get copyWith =>
      _$AppUserCopyWithImpl<AppUser>(this as AppUser, _$identity);

  /// Serializes this AppUser to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as AppUser;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppUser &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.name, _this.name) || other.name == _this.name) &&
            (identical(other.phone, _this.phone) ||
                other.phone == _this.phone) &&
            const DeepCollectionEquality().equals(other.roles, _this.roles) &&
            const DeepCollectionEquality()
                .equals(other.branchIds, _this.branchIds) &&
            (identical(other.avatarUrl, _this.avatarUrl) ||
                other.avatarUrl == _this.avatarUrl) &&
            (identical(other.language, _this.language) ||
                other.language == _this.language) &&
            (identical(other.canRecordReceipt, _this.canRecordReceipt) ||
                other.canRecordReceipt == _this.canRecordReceipt) &&
            (identical(other.isActive, _this.isActive) ||
                other.isActive == _this.isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as AppUser;
    return Object.hash(
        runtimeType,
        _this.id,
        _this.name,
        _this.phone,
        const DeepCollectionEquality().hash(_this.roles),
        const DeepCollectionEquality().hash(_this.branchIds),
        _this.avatarUrl,
        _this.language,
        _this.canRecordReceipt,
        _this.isActive);
  }

  @override
  String toString() {
    final _this = this as AppUser;
    return 'AppUser(id: ${_this.id}, name: ${_this.name}, phone: ${_this.phone}, roles: ${_this.roles}, branchIds: ${_this.branchIds}, avatarUrl: ${_this.avatarUrl}, language: ${_this.language}, canRecordReceipt: ${_this.canRecordReceipt}, isActive: ${_this.isActive})';
  }
}

/// @nodoc
abstract mixin class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) _then) =
      _$AppUserCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String phone,
      List<AppRole> roles,
      List<String> branchIds,
      String? avatarUrl,
      String language,
      bool canRecordReceipt,
      bool isActive});
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res> implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._self, this._then);

  final AppUser _self;
  final $Res Function(AppUser) _then;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? roles = null,
    Object? branchIds = null,
    Object? avatarUrl = freezed,
    Object? language = null,
    Object? canRecordReceipt = null,
    Object? isActive = null,
  }) {
    return _then(AppUser(
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
      roles: null == roles
          ? _self.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<AppRole>,
      branchIds: null == branchIds
          ? _self.branchIds
          : branchIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      canRecordReceipt: null == canRecordReceipt
          ? _self.canRecordReceipt
          : canRecordReceipt // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [AppUser].
extension AppUserPatterns on AppUser {
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
    TResult Function(_AppUser value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppUser() when $default != null:
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
    TResult Function(_AppUser value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppUser():
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
    TResult? Function(_AppUser value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppUser() when $default != null:
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
            List<AppRole> roles,
            List<String> branchIds,
            String? avatarUrl,
            String language,
            bool canRecordReceipt,
            bool isActive)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppUser() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.phone,
            _that.roles,
            _that.branchIds,
            _that.avatarUrl,
            _that.language,
            _that.canRecordReceipt,
            _that.isActive);
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
            List<AppRole> roles,
            List<String> branchIds,
            String? avatarUrl,
            String language,
            bool canRecordReceipt,
            bool isActive)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppUser():
        return $default(
            _that.id,
            _that.name,
            _that.phone,
            _that.roles,
            _that.branchIds,
            _that.avatarUrl,
            _that.language,
            _that.canRecordReceipt,
            _that.isActive);
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
            List<AppRole> roles,
            List<String> branchIds,
            String? avatarUrl,
            String language,
            bool canRecordReceipt,
            bool isActive)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppUser() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.phone,
            _that.roles,
            _that.branchIds,
            _that.avatarUrl,
            _that.language,
            _that.canRecordReceipt,
            _that.isActive);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AppUser implements AppUser {
  const _AppUser(
      {required this.id,
      required this.name,
      required this.phone,
      required List<AppRole> roles,
      required List<String> branchIds,
      this.avatarUrl,
      required this.language,
      this.canRecordReceipt = false,
      this.isActive = true})
      : _roles = roles,
        _branchIds = branchIds;
  factory _AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String phone;
  final List<AppRole> _roles;
  @override
  List<AppRole> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  final List<String> _branchIds;
  @override
  List<String> get branchIds {
    if (_branchIds is EqualUnmodifiableListView) return _branchIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_branchIds);
  }

  @override
  final String? avatarUrl;
  @override
  final String language;
  @override
  @JsonKey()
  final bool canRecordReceipt;
  @override
  @JsonKey()
  final bool isActive;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppUserCopyWith<_AppUser> get copyWith =>
      __$AppUserCopyWithImpl<_AppUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AppUserToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            const DeepCollectionEquality().equals(other.roles, _roles) &&
            const DeepCollectionEquality()
                .equals(other.branchIds, _branchIds) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.canRecordReceipt, canRecordReceipt) ||
                other.canRecordReceipt == canRecordReceipt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        id,
        name,
        phone,
        const DeepCollectionEquality().hash(_roles),
        const DeepCollectionEquality().hash(_branchIds),
        avatarUrl,
        language,
        canRecordReceipt,
        isActive);
  }

  @override
  String toString() {
    return 'AppUser(id: $id, name: $name, phone: $phone, roles: $roles, branchIds: $branchIds, avatarUrl: $avatarUrl, language: $language, canRecordReceipt: $canRecordReceipt, isActive: $isActive)';
  }
}

/// @nodoc
abstract mixin class _$AppUserCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$AppUserCopyWith(_AppUser value, $Res Function(_AppUser) _then) =
      __$AppUserCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String phone,
      List<AppRole> roles,
      List<String> branchIds,
      String? avatarUrl,
      String language,
      bool canRecordReceipt,
      bool isActive});
}

/// @nodoc
class __$AppUserCopyWithImpl<$Res> implements _$AppUserCopyWith<$Res> {
  __$AppUserCopyWithImpl(this._self, this._then);

  final _AppUser _self;
  final $Res Function(_AppUser) _then;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? roles = null,
    Object? branchIds = null,
    Object? avatarUrl = freezed,
    Object? language = null,
    Object? canRecordReceipt = null,
    Object? isActive = null,
  }) {
    return _then(_AppUser(
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
      roles: null == roles
          ? _self._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<AppRole>,
      branchIds: null == branchIds
          ? _self._branchIds
          : branchIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      canRecordReceipt: null == canRecordReceipt
          ? _self.canRecordReceipt
          : canRecordReceipt // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
