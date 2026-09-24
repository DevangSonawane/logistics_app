// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lead.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Lead {
  String get id;
  String get company;
  String get contact;
  String get phone;
  LeadSource get source;
  String get from;
  String get to;
  String? get commodity;
  double? get weightKg;
  String? get vehicleType;
  String? get frequency;
  int get expectedTrips;
  int get targetRate;
  LeadStage get stage;
  DateTime? get slaDue;
  String? get notes;

  /// Create a copy of Lead
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LeadCopyWith<Lead> get copyWith =>
      _$LeadCopyWithImpl<Lead>(this as Lead, _$identity);

  /// Serializes this Lead to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as Lead;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Lead &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.company, _this.company) ||
                other.company == _this.company) &&
            (identical(other.contact, _this.contact) ||
                other.contact == _this.contact) &&
            (identical(other.phone, _this.phone) ||
                other.phone == _this.phone) &&
            (identical(other.source, _this.source) ||
                other.source == _this.source) &&
            (identical(other.from, _this.from) || other.from == _this.from) &&
            (identical(other.to, _this.to) || other.to == _this.to) &&
            (identical(other.commodity, _this.commodity) ||
                other.commodity == _this.commodity) &&
            (identical(other.weightKg, _this.weightKg) ||
                other.weightKg == _this.weightKg) &&
            (identical(other.vehicleType, _this.vehicleType) ||
                other.vehicleType == _this.vehicleType) &&
            (identical(other.frequency, _this.frequency) ||
                other.frequency == _this.frequency) &&
            (identical(other.expectedTrips, _this.expectedTrips) ||
                other.expectedTrips == _this.expectedTrips) &&
            (identical(other.targetRate, _this.targetRate) ||
                other.targetRate == _this.targetRate) &&
            (identical(other.stage, _this.stage) ||
                other.stage == _this.stage) &&
            (identical(other.slaDue, _this.slaDue) ||
                other.slaDue == _this.slaDue) &&
            (identical(other.notes, _this.notes) ||
                other.notes == _this.notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as Lead;
    return Object.hash(
        runtimeType,
        _this.id,
        _this.company,
        _this.contact,
        _this.phone,
        _this.source,
        _this.from,
        _this.to,
        _this.commodity,
        _this.weightKg,
        _this.vehicleType,
        _this.frequency,
        _this.expectedTrips,
        _this.targetRate,
        _this.stage,
        _this.slaDue,
        _this.notes);
  }

  @override
  String toString() {
    final _this = this as Lead;
    return 'Lead(id: ${_this.id}, company: ${_this.company}, contact: ${_this.contact}, phone: ${_this.phone}, source: ${_this.source}, from: ${_this.from}, to: ${_this.to}, commodity: ${_this.commodity}, weightKg: ${_this.weightKg}, vehicleType: ${_this.vehicleType}, frequency: ${_this.frequency}, expectedTrips: ${_this.expectedTrips}, targetRate: ${_this.targetRate}, stage: ${_this.stage}, slaDue: ${_this.slaDue}, notes: ${_this.notes})';
  }
}

/// @nodoc
abstract mixin class $LeadCopyWith<$Res> {
  factory $LeadCopyWith(Lead value, $Res Function(Lead) _then) =
      _$LeadCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String company,
      String contact,
      String phone,
      LeadSource source,
      String from,
      String to,
      String? commodity,
      double? weightKg,
      String? vehicleType,
      String? frequency,
      int expectedTrips,
      int targetRate,
      LeadStage stage,
      DateTime? slaDue,
      String? notes});
}

/// @nodoc
class _$LeadCopyWithImpl<$Res> implements $LeadCopyWith<$Res> {
  _$LeadCopyWithImpl(this._self, this._then);

  final Lead _self;
  final $Res Function(Lead) _then;

  /// Create a copy of Lead
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? company = null,
    Object? contact = null,
    Object? phone = null,
    Object? source = null,
    Object? from = null,
    Object? to = null,
    Object? commodity = freezed,
    Object? weightKg = freezed,
    Object? vehicleType = freezed,
    Object? frequency = freezed,
    Object? expectedTrips = null,
    Object? targetRate = null,
    Object? stage = null,
    Object? slaDue = freezed,
    Object? notes = freezed,
  }) {
    return _then(Lead(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      company: null == company
          ? _self.company
          : company // ignore: cast_nullable_to_non_nullable
              as String,
      contact: null == contact
          ? _self.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as LeadSource,
      from: null == from
          ? _self.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _self.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      commodity: freezed == commodity
          ? _self.commodity
          : commodity // ignore: cast_nullable_to_non_nullable
              as String?,
      weightKg: freezed == weightKg
          ? _self.weightKg
          : weightKg // ignore: cast_nullable_to_non_nullable
              as double?,
      vehicleType: freezed == vehicleType
          ? _self.vehicleType
          : vehicleType // ignore: cast_nullable_to_non_nullable
              as String?,
      frequency: freezed == frequency
          ? _self.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String?,
      expectedTrips: null == expectedTrips
          ? _self.expectedTrips
          : expectedTrips // ignore: cast_nullable_to_non_nullable
              as int,
      targetRate: null == targetRate
          ? _self.targetRate
          : targetRate // ignore: cast_nullable_to_non_nullable
              as int,
      stage: null == stage
          ? _self.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as LeadStage,
      slaDue: freezed == slaDue
          ? _self.slaDue
          : slaDue // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Lead].
extension LeadPatterns on Lead {
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
    TResult Function(_Lead value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Lead() when $default != null:
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
    TResult Function(_Lead value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Lead():
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
    TResult? Function(_Lead value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Lead() when $default != null:
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
            String company,
            String contact,
            String phone,
            LeadSource source,
            String from,
            String to,
            String? commodity,
            double? weightKg,
            String? vehicleType,
            String? frequency,
            int expectedTrips,
            int targetRate,
            LeadStage stage,
            DateTime? slaDue,
            String? notes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Lead() when $default != null:
        return $default(
            _that.id,
            _that.company,
            _that.contact,
            _that.phone,
            _that.source,
            _that.from,
            _that.to,
            _that.commodity,
            _that.weightKg,
            _that.vehicleType,
            _that.frequency,
            _that.expectedTrips,
            _that.targetRate,
            _that.stage,
            _that.slaDue,
            _that.notes);
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
            String company,
            String contact,
            String phone,
            LeadSource source,
            String from,
            String to,
            String? commodity,
            double? weightKg,
            String? vehicleType,
            String? frequency,
            int expectedTrips,
            int targetRate,
            LeadStage stage,
            DateTime? slaDue,
            String? notes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Lead():
        return $default(
            _that.id,
            _that.company,
            _that.contact,
            _that.phone,
            _that.source,
            _that.from,
            _that.to,
            _that.commodity,
            _that.weightKg,
            _that.vehicleType,
            _that.frequency,
            _that.expectedTrips,
            _that.targetRate,
            _that.stage,
            _that.slaDue,
            _that.notes);
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
            String company,
            String contact,
            String phone,
            LeadSource source,
            String from,
            String to,
            String? commodity,
            double? weightKg,
            String? vehicleType,
            String? frequency,
            int expectedTrips,
            int targetRate,
            LeadStage stage,
            DateTime? slaDue,
            String? notes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Lead() when $default != null:
        return $default(
            _that.id,
            _that.company,
            _that.contact,
            _that.phone,
            _that.source,
            _that.from,
            _that.to,
            _that.commodity,
            _that.weightKg,
            _that.vehicleType,
            _that.frequency,
            _that.expectedTrips,
            _that.targetRate,
            _that.stage,
            _that.slaDue,
            _that.notes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Lead implements Lead {
  const _Lead(
      {required this.id,
      required this.company,
      required this.contact,
      required this.phone,
      this.source = LeadSource.website,
      required this.from,
      required this.to,
      this.commodity,
      this.weightKg,
      this.vehicleType,
      this.frequency,
      this.expectedTrips = 0,
      this.targetRate = 0,
      this.stage = LeadStage.fresh,
      this.slaDue,
      this.notes});
  factory _Lead.fromJson(Map<String, dynamic> json) => _$LeadFromJson(json);

  @override
  final String id;
  @override
  final String company;
  @override
  final String contact;
  @override
  final String phone;
  @override
  @JsonKey()
  final LeadSource source;
  @override
  final String from;
  @override
  final String to;
  @override
  final String? commodity;
  @override
  final double? weightKg;
  @override
  final String? vehicleType;
  @override
  final String? frequency;
  @override
  @JsonKey()
  final int expectedTrips;
  @override
  @JsonKey()
  final int targetRate;
  @override
  @JsonKey()
  final LeadStage stage;
  @override
  final DateTime? slaDue;
  @override
  final String? notes;

  /// Create a copy of Lead
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LeadCopyWith<_Lead> get copyWith =>
      __$LeadCopyWithImpl<_Lead>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LeadToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Lead &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.commodity, commodity) ||
                other.commodity == commodity) &&
            (identical(other.weightKg, weightKg) ||
                other.weightKg == weightKg) &&
            (identical(other.vehicleType, vehicleType) ||
                other.vehicleType == vehicleType) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.expectedTrips, expectedTrips) ||
                other.expectedTrips == expectedTrips) &&
            (identical(other.targetRate, targetRate) ||
                other.targetRate == targetRate) &&
            (identical(other.stage, stage) || other.stage == stage) &&
            (identical(other.slaDue, slaDue) || other.slaDue == slaDue) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        id,
        company,
        contact,
        phone,
        source,
        from,
        to,
        commodity,
        weightKg,
        vehicleType,
        frequency,
        expectedTrips,
        targetRate,
        stage,
        slaDue,
        notes);
  }

  @override
  String toString() {
    return 'Lead(id: $id, company: $company, contact: $contact, phone: $phone, source: $source, from: $from, to: $to, commodity: $commodity, weightKg: $weightKg, vehicleType: $vehicleType, frequency: $frequency, expectedTrips: $expectedTrips, targetRate: $targetRate, stage: $stage, slaDue: $slaDue, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class _$LeadCopyWith<$Res> implements $LeadCopyWith<$Res> {
  factory _$LeadCopyWith(_Lead value, $Res Function(_Lead) _then) =
      __$LeadCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String company,
      String contact,
      String phone,
      LeadSource source,
      String from,
      String to,
      String? commodity,
      double? weightKg,
      String? vehicleType,
      String? frequency,
      int expectedTrips,
      int targetRate,
      LeadStage stage,
      DateTime? slaDue,
      String? notes});
}

/// @nodoc
class __$LeadCopyWithImpl<$Res> implements _$LeadCopyWith<$Res> {
  __$LeadCopyWithImpl(this._self, this._then);

  final _Lead _self;
  final $Res Function(_Lead) _then;

  /// Create a copy of Lead
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? company = null,
    Object? contact = null,
    Object? phone = null,
    Object? source = null,
    Object? from = null,
    Object? to = null,
    Object? commodity = freezed,
    Object? weightKg = freezed,
    Object? vehicleType = freezed,
    Object? frequency = freezed,
    Object? expectedTrips = null,
    Object? targetRate = null,
    Object? stage = null,
    Object? slaDue = freezed,
    Object? notes = freezed,
  }) {
    return _then(_Lead(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      company: null == company
          ? _self.company
          : company // ignore: cast_nullable_to_non_nullable
              as String,
      contact: null == contact
          ? _self.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as LeadSource,
      from: null == from
          ? _self.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _self.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      commodity: freezed == commodity
          ? _self.commodity
          : commodity // ignore: cast_nullable_to_non_nullable
              as String?,
      weightKg: freezed == weightKg
          ? _self.weightKg
          : weightKg // ignore: cast_nullable_to_non_nullable
              as double?,
      vehicleType: freezed == vehicleType
          ? _self.vehicleType
          : vehicleType // ignore: cast_nullable_to_non_nullable
              as String?,
      frequency: freezed == frequency
          ? _self.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String?,
      expectedTrips: null == expectedTrips
          ? _self.expectedTrips
          : expectedTrips // ignore: cast_nullable_to_non_nullable
              as int,
      targetRate: null == targetRate
          ? _self.targetRate
          : targetRate // ignore: cast_nullable_to_non_nullable
              as int,
      stage: null == stage
          ? _self.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as LeadStage,
      slaDue: freezed == slaDue
          ? _self.slaDue
          : slaDue // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$Quote {
  String get id;
  String? get leadId;
  String get laneFrom;
  String get laneTo;
  String get vehicleType;
  int get rate;
  Map<String, int> get charges;
  DateTime get validTill;
  String get status;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuoteCopyWith<Quote> get copyWith =>
      _$QuoteCopyWithImpl<Quote>(this as Quote, _$identity);

  /// Serializes this Quote to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as Quote;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Quote &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.leadId, _this.leadId) ||
                other.leadId == _this.leadId) &&
            (identical(other.laneFrom, _this.laneFrom) ||
                other.laneFrom == _this.laneFrom) &&
            (identical(other.laneTo, _this.laneTo) ||
                other.laneTo == _this.laneTo) &&
            (identical(other.vehicleType, _this.vehicleType) ||
                other.vehicleType == _this.vehicleType) &&
            (identical(other.rate, _this.rate) || other.rate == _this.rate) &&
            const DeepCollectionEquality()
                .equals(other.charges, _this.charges) &&
            (identical(other.validTill, _this.validTill) ||
                other.validTill == _this.validTill) &&
            (identical(other.status, _this.status) ||
                other.status == _this.status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as Quote;
    return Object.hash(
        runtimeType,
        _this.id,
        _this.leadId,
        _this.laneFrom,
        _this.laneTo,
        _this.vehicleType,
        _this.rate,
        const DeepCollectionEquality().hash(_this.charges),
        _this.validTill,
        _this.status);
  }

  @override
  String toString() {
    final _this = this as Quote;
    return 'Quote(id: ${_this.id}, leadId: ${_this.leadId}, laneFrom: ${_this.laneFrom}, laneTo: ${_this.laneTo}, vehicleType: ${_this.vehicleType}, rate: ${_this.rate}, charges: ${_this.charges}, validTill: ${_this.validTill}, status: ${_this.status})';
  }
}

/// @nodoc
abstract mixin class $QuoteCopyWith<$Res> {
  factory $QuoteCopyWith(Quote value, $Res Function(Quote) _then) =
      _$QuoteCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String? leadId,
      String laneFrom,
      String laneTo,
      String vehicleType,
      int rate,
      Map<String, int> charges,
      DateTime validTill,
      String status});
}

/// @nodoc
class _$QuoteCopyWithImpl<$Res> implements $QuoteCopyWith<$Res> {
  _$QuoteCopyWithImpl(this._self, this._then);

  final Quote _self;
  final $Res Function(Quote) _then;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? leadId = freezed,
    Object? laneFrom = null,
    Object? laneTo = null,
    Object? vehicleType = null,
    Object? rate = null,
    Object? charges = null,
    Object? validTill = null,
    Object? status = null,
  }) {
    return _then(Quote(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      leadId: freezed == leadId
          ? _self.leadId
          : leadId // ignore: cast_nullable_to_non_nullable
              as String?,
      laneFrom: null == laneFrom
          ? _self.laneFrom
          : laneFrom // ignore: cast_nullable_to_non_nullable
              as String,
      laneTo: null == laneTo
          ? _self.laneTo
          : laneTo // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleType: null == vehicleType
          ? _self.vehicleType
          : vehicleType // ignore: cast_nullable_to_non_nullable
              as String,
      rate: null == rate
          ? _self.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as int,
      charges: null == charges
          ? _self.charges
          : charges // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      validTill: null == validTill
          ? _self.validTill
          : validTill // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Quote].
extension QuotePatterns on Quote {
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
    TResult Function(_Quote value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Quote() when $default != null:
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
    TResult Function(_Quote value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Quote():
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
    TResult? Function(_Quote value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Quote() when $default != null:
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
            String? leadId,
            String laneFrom,
            String laneTo,
            String vehicleType,
            int rate,
            Map<String, int> charges,
            DateTime validTill,
            String status)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Quote() when $default != null:
        return $default(
            _that.id,
            _that.leadId,
            _that.laneFrom,
            _that.laneTo,
            _that.vehicleType,
            _that.rate,
            _that.charges,
            _that.validTill,
            _that.status);
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
            String? leadId,
            String laneFrom,
            String laneTo,
            String vehicleType,
            int rate,
            Map<String, int> charges,
            DateTime validTill,
            String status)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Quote():
        return $default(
            _that.id,
            _that.leadId,
            _that.laneFrom,
            _that.laneTo,
            _that.vehicleType,
            _that.rate,
            _that.charges,
            _that.validTill,
            _that.status);
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
            String? leadId,
            String laneFrom,
            String laneTo,
            String vehicleType,
            int rate,
            Map<String, int> charges,
            DateTime validTill,
            String status)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Quote() when $default != null:
        return $default(
            _that.id,
            _that.leadId,
            _that.laneFrom,
            _that.laneTo,
            _that.vehicleType,
            _that.rate,
            _that.charges,
            _that.validTill,
            _that.status);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Quote implements Quote {
  const _Quote(
      {required this.id,
      this.leadId,
      required this.laneFrom,
      required this.laneTo,
      required this.vehicleType,
      required this.rate,
      Map<String, int> charges = const {},
      required this.validTill,
      this.status = 'draft'})
      : _charges = charges;
  factory _Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

  @override
  final String id;
  @override
  final String? leadId;
  @override
  final String laneFrom;
  @override
  final String laneTo;
  @override
  final String vehicleType;
  @override
  final int rate;
  final Map<String, int> _charges;
  @override
  @JsonKey()
  Map<String, int> get charges {
    if (_charges is EqualUnmodifiableMapView) return _charges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_charges);
  }

  @override
  final DateTime validTill;
  @override
  @JsonKey()
  final String status;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuoteCopyWith<_Quote> get copyWith =>
      __$QuoteCopyWithImpl<_Quote>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QuoteToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Quote &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.leadId, leadId) || other.leadId == leadId) &&
            (identical(other.laneFrom, laneFrom) ||
                other.laneFrom == laneFrom) &&
            (identical(other.laneTo, laneTo) || other.laneTo == laneTo) &&
            (identical(other.vehicleType, vehicleType) ||
                other.vehicleType == vehicleType) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            const DeepCollectionEquality().equals(other.charges, _charges) &&
            (identical(other.validTill, validTill) ||
                other.validTill == validTill) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, id, leadId, laneFrom, laneTo, vehicleType,
        rate, const DeepCollectionEquality().hash(_charges), validTill, status);
  }

  @override
  String toString() {
    return 'Quote(id: $id, leadId: $leadId, laneFrom: $laneFrom, laneTo: $laneTo, vehicleType: $vehicleType, rate: $rate, charges: $charges, validTill: $validTill, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$QuoteCopyWith<$Res> implements $QuoteCopyWith<$Res> {
  factory _$QuoteCopyWith(_Quote value, $Res Function(_Quote) _then) =
      __$QuoteCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String? leadId,
      String laneFrom,
      String laneTo,
      String vehicleType,
      int rate,
      Map<String, int> charges,
      DateTime validTill,
      String status});
}

/// @nodoc
class __$QuoteCopyWithImpl<$Res> implements _$QuoteCopyWith<$Res> {
  __$QuoteCopyWithImpl(this._self, this._then);

  final _Quote _self;
  final $Res Function(_Quote) _then;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? leadId = freezed,
    Object? laneFrom = null,
    Object? laneTo = null,
    Object? vehicleType = null,
    Object? rate = null,
    Object? charges = null,
    Object? validTill = null,
    Object? status = null,
  }) {
    return _then(_Quote(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      leadId: freezed == leadId
          ? _self.leadId
          : leadId // ignore: cast_nullable_to_non_nullable
              as String?,
      laneFrom: null == laneFrom
          ? _self.laneFrom
          : laneFrom // ignore: cast_nullable_to_non_nullable
              as String,
      laneTo: null == laneTo
          ? _self.laneTo
          : laneTo // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleType: null == vehicleType
          ? _self.vehicleType
          : vehicleType // ignore: cast_nullable_to_non_nullable
              as String,
      rate: null == rate
          ? _self.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as int,
      charges: null == charges
          ? _self._charges
          : charges // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      validTill: null == validTill
          ? _self.validTill
          : validTill // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$Visit {
  String get id;
  String get title;
  DateTime? get plannedAt;
  DateTime? get checkedInAt;
  DateTime? get checkedOutAt;
  double? get lat;
  double? get lng;
  String? get photoPath;
  String? get note;
  String? get outcome;

  /// Create a copy of Visit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VisitCopyWith<Visit> get copyWith =>
      _$VisitCopyWithImpl<Visit>(this as Visit, _$identity);

  /// Serializes this Visit to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as Visit;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Visit &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.title, _this.title) ||
                other.title == _this.title) &&
            (identical(other.plannedAt, _this.plannedAt) ||
                other.plannedAt == _this.plannedAt) &&
            (identical(other.checkedInAt, _this.checkedInAt) ||
                other.checkedInAt == _this.checkedInAt) &&
            (identical(other.checkedOutAt, _this.checkedOutAt) ||
                other.checkedOutAt == _this.checkedOutAt) &&
            (identical(other.lat, _this.lat) || other.lat == _this.lat) &&
            (identical(other.lng, _this.lng) || other.lng == _this.lng) &&
            (identical(other.photoPath, _this.photoPath) ||
                other.photoPath == _this.photoPath) &&
            (identical(other.note, _this.note) || other.note == _this.note) &&
            (identical(other.outcome, _this.outcome) ||
                other.outcome == _this.outcome));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as Visit;
    return Object.hash(
        runtimeType,
        _this.id,
        _this.title,
        _this.plannedAt,
        _this.checkedInAt,
        _this.checkedOutAt,
        _this.lat,
        _this.lng,
        _this.photoPath,
        _this.note,
        _this.outcome);
  }

  @override
  String toString() {
    final _this = this as Visit;
    return 'Visit(id: ${_this.id}, title: ${_this.title}, plannedAt: ${_this.plannedAt}, checkedInAt: ${_this.checkedInAt}, checkedOutAt: ${_this.checkedOutAt}, lat: ${_this.lat}, lng: ${_this.lng}, photoPath: ${_this.photoPath}, note: ${_this.note}, outcome: ${_this.outcome})';
  }
}

/// @nodoc
abstract mixin class $VisitCopyWith<$Res> {
  factory $VisitCopyWith(Visit value, $Res Function(Visit) _then) =
      _$VisitCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime? plannedAt,
      DateTime? checkedInAt,
      DateTime? checkedOutAt,
      double? lat,
      double? lng,
      String? photoPath,
      String? note,
      String? outcome});
}

/// @nodoc
class _$VisitCopyWithImpl<$Res> implements $VisitCopyWith<$Res> {
  _$VisitCopyWithImpl(this._self, this._then);

  final Visit _self;
  final $Res Function(Visit) _then;

  /// Create a copy of Visit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? plannedAt = freezed,
    Object? checkedInAt = freezed,
    Object? checkedOutAt = freezed,
    Object? lat = freezed,
    Object? lng = freezed,
    Object? photoPath = freezed,
    Object? note = freezed,
    Object? outcome = freezed,
  }) {
    return _then(Visit(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      plannedAt: freezed == plannedAt
          ? _self.plannedAt
          : plannedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      checkedInAt: freezed == checkedInAt
          ? _self.checkedInAt
          : checkedInAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      checkedOutAt: freezed == checkedOutAt
          ? _self.checkedOutAt
          : checkedOutAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lat: freezed == lat
          ? _self.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double?,
      lng: freezed == lng
          ? _self.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double?,
      photoPath: freezed == photoPath
          ? _self.photoPath
          : photoPath // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      outcome: freezed == outcome
          ? _self.outcome
          : outcome // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Visit].
extension VisitPatterns on Visit {
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
    TResult Function(_Visit value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Visit() when $default != null:
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
    TResult Function(_Visit value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Visit():
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
    TResult? Function(_Visit value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Visit() when $default != null:
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
            String title,
            DateTime? plannedAt,
            DateTime? checkedInAt,
            DateTime? checkedOutAt,
            double? lat,
            double? lng,
            String? photoPath,
            String? note,
            String? outcome)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Visit() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.plannedAt,
            _that.checkedInAt,
            _that.checkedOutAt,
            _that.lat,
            _that.lng,
            _that.photoPath,
            _that.note,
            _that.outcome);
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
            String title,
            DateTime? plannedAt,
            DateTime? checkedInAt,
            DateTime? checkedOutAt,
            double? lat,
            double? lng,
            String? photoPath,
            String? note,
            String? outcome)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Visit():
        return $default(
            _that.id,
            _that.title,
            _that.plannedAt,
            _that.checkedInAt,
            _that.checkedOutAt,
            _that.lat,
            _that.lng,
            _that.photoPath,
            _that.note,
            _that.outcome);
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
            String title,
            DateTime? plannedAt,
            DateTime? checkedInAt,
            DateTime? checkedOutAt,
            double? lat,
            double? lng,
            String? photoPath,
            String? note,
            String? outcome)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Visit() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.plannedAt,
            _that.checkedInAt,
            _that.checkedOutAt,
            _that.lat,
            _that.lng,
            _that.photoPath,
            _that.note,
            _that.outcome);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Visit implements Visit {
  const _Visit(
      {required this.id,
      required this.title,
      this.plannedAt,
      this.checkedInAt,
      this.checkedOutAt,
      this.lat,
      this.lng,
      this.photoPath,
      this.note,
      this.outcome});
  factory _Visit.fromJson(Map<String, dynamic> json) => _$VisitFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final DateTime? plannedAt;
  @override
  final DateTime? checkedInAt;
  @override
  final DateTime? checkedOutAt;
  @override
  final double? lat;
  @override
  final double? lng;
  @override
  final String? photoPath;
  @override
  final String? note;
  @override
  final String? outcome;

  /// Create a copy of Visit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VisitCopyWith<_Visit> get copyWith =>
      __$VisitCopyWithImpl<_Visit>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VisitToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Visit &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.plannedAt, plannedAt) ||
                other.plannedAt == plannedAt) &&
            (identical(other.checkedInAt, checkedInAt) ||
                other.checkedInAt == checkedInAt) &&
            (identical(other.checkedOutAt, checkedOutAt) ||
                other.checkedOutAt == checkedOutAt) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.photoPath, photoPath) ||
                other.photoPath == photoPath) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.outcome, outcome) || other.outcome == outcome));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, id, title, plannedAt, checkedInAt,
        checkedOutAt, lat, lng, photoPath, note, outcome);
  }

  @override
  String toString() {
    return 'Visit(id: $id, title: $title, plannedAt: $plannedAt, checkedInAt: $checkedInAt, checkedOutAt: $checkedOutAt, lat: $lat, lng: $lng, photoPath: $photoPath, note: $note, outcome: $outcome)';
  }
}

/// @nodoc
abstract mixin class _$VisitCopyWith<$Res> implements $VisitCopyWith<$Res> {
  factory _$VisitCopyWith(_Visit value, $Res Function(_Visit) _then) =
      __$VisitCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime? plannedAt,
      DateTime? checkedInAt,
      DateTime? checkedOutAt,
      double? lat,
      double? lng,
      String? photoPath,
      String? note,
      String? outcome});
}

/// @nodoc
class __$VisitCopyWithImpl<$Res> implements _$VisitCopyWith<$Res> {
  __$VisitCopyWithImpl(this._self, this._then);

  final _Visit _self;
  final $Res Function(_Visit) _then;

  /// Create a copy of Visit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? plannedAt = freezed,
    Object? checkedInAt = freezed,
    Object? checkedOutAt = freezed,
    Object? lat = freezed,
    Object? lng = freezed,
    Object? photoPath = freezed,
    Object? note = freezed,
    Object? outcome = freezed,
  }) {
    return _then(_Visit(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      plannedAt: freezed == plannedAt
          ? _self.plannedAt
          : plannedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      checkedInAt: freezed == checkedInAt
          ? _self.checkedInAt
          : checkedInAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      checkedOutAt: freezed == checkedOutAt
          ? _self.checkedOutAt
          : checkedOutAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lat: freezed == lat
          ? _self.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double?,
      lng: freezed == lng
          ? _self.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double?,
      photoPath: freezed == photoPath
          ? _self.photoPath
          : photoPath // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      outcome: freezed == outcome
          ? _self.outcome
          : outcome // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$SalesTarget {
  String get label;
  int get achieved;
  int get target;

  /// Create a copy of SalesTarget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SalesTargetCopyWith<SalesTarget> get copyWith =>
      _$SalesTargetCopyWithImpl<SalesTarget>(this as SalesTarget, _$identity);

  /// Serializes this SalesTarget to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as SalesTarget;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SalesTarget &&
            (identical(other.label, _this.label) ||
                other.label == _this.label) &&
            (identical(other.achieved, _this.achieved) ||
                other.achieved == _this.achieved) &&
            (identical(other.target, _this.target) ||
                other.target == _this.target));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as SalesTarget;
    return Object.hash(runtimeType, _this.label, _this.achieved, _this.target);
  }

  @override
  String toString() {
    final _this = this as SalesTarget;
    return 'SalesTarget(label: ${_this.label}, achieved: ${_this.achieved}, target: ${_this.target})';
  }
}

/// @nodoc
abstract mixin class $SalesTargetCopyWith<$Res> {
  factory $SalesTargetCopyWith(
          SalesTarget value, $Res Function(SalesTarget) _then) =
      _$SalesTargetCopyWithImpl;
  @useResult
  $Res call({String label, int achieved, int target});
}

/// @nodoc
class _$SalesTargetCopyWithImpl<$Res> implements $SalesTargetCopyWith<$Res> {
  _$SalesTargetCopyWithImpl(this._self, this._then);

  final SalesTarget _self;
  final $Res Function(SalesTarget) _then;

  /// Create a copy of SalesTarget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? achieved = null,
    Object? target = null,
  }) {
    return _then(SalesTarget(
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      achieved: null == achieved
          ? _self.achieved
          : achieved // ignore: cast_nullable_to_non_nullable
              as int,
      target: null == target
          ? _self.target
          : target // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [SalesTarget].
extension SalesTargetPatterns on SalesTarget {
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
    TResult Function(_SalesTarget value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SalesTarget() when $default != null:
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
    TResult Function(_SalesTarget value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SalesTarget():
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
    TResult? Function(_SalesTarget value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SalesTarget() when $default != null:
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
    TResult Function(String label, int achieved, int target)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SalesTarget() when $default != null:
        return $default(_that.label, _that.achieved, _that.target);
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
    TResult Function(String label, int achieved, int target) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SalesTarget():
        return $default(_that.label, _that.achieved, _that.target);
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
    TResult? Function(String label, int achieved, int target)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SalesTarget() when $default != null:
        return $default(_that.label, _that.achieved, _that.target);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SalesTarget implements SalesTarget {
  const _SalesTarget(
      {required this.label, required this.achieved, required this.target});
  factory _SalesTarget.fromJson(Map<String, dynamic> json) =>
      _$SalesTargetFromJson(json);

  @override
  final String label;
  @override
  final int achieved;
  @override
  final int target;

  /// Create a copy of SalesTarget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SalesTargetCopyWith<_SalesTarget> get copyWith =>
      __$SalesTargetCopyWithImpl<_SalesTarget>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SalesTargetToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SalesTarget &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.achieved, achieved) ||
                other.achieved == achieved) &&
            (identical(other.target, target) || other.target == target));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, label, achieved, target);
  }

  @override
  String toString() {
    return 'SalesTarget(label: $label, achieved: $achieved, target: $target)';
  }
}

/// @nodoc
abstract mixin class _$SalesTargetCopyWith<$Res>
    implements $SalesTargetCopyWith<$Res> {
  factory _$SalesTargetCopyWith(
          _SalesTarget value, $Res Function(_SalesTarget) _then) =
      __$SalesTargetCopyWithImpl;
  @override
  @useResult
  $Res call({String label, int achieved, int target});
}

/// @nodoc
class __$SalesTargetCopyWithImpl<$Res> implements _$SalesTargetCopyWith<$Res> {
  __$SalesTargetCopyWithImpl(this._self, this._then);

  final _SalesTarget _self;
  final $Res Function(_SalesTarget) _then;

  /// Create a copy of SalesTarget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? label = null,
    Object? achieved = null,
    Object? target = null,
  }) {
    return _then(_SalesTarget(
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      achieved: null == achieved
          ? _self.achieved
          : achieved // ignore: cast_nullable_to_non_nullable
              as int,
      target: null == target
          ? _self.target
          : target // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
