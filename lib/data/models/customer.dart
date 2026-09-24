import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
abstract class CustomerContact with _$CustomerContact {
  const factory CustomerContact({
    required String name,
    required String phone,
    String? role,
  }) = _CustomerContact;

  factory CustomerContact.fromJson(Map<String, dynamic> json) =>
      _$CustomerContactFromJson(json);
}

/// Customer master with credit terms and outstanding (sales nudges +
/// accountant ageing read the same record). Money in integer rupees.
@freezed
abstract class Customer with _$Customer {
  const factory Customer({
    required String id,
    required String name,
    required String gstin,
    String? pan,
    @Default(30) int creditDays,
    @Default(0) int creditLimit,
    @Default(0) int outstanding,
    @Default([]) List<CustomerContact> contacts,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}
