import 'package:freezed_annotation/freezed_annotation.dart';

part 'branch.freezed.dart';
part 'branch.g.dart';

/// Company branch (Mumbai HQ, Pune, Chennai, Delhi in seed data).
@freezed
abstract class Branch with _$Branch {
  const factory Branch({
    required String id,
    required String name,
    required String city,
    @Default(true) bool isActive,
  }) = _Branch;

  factory Branch.fromJson(Map<String, dynamic> json) =>
      _$BranchFromJson(json);
}

/// Company with its branches. Switchable from the owner shell (Phase 4).
@freezed
abstract class Company with _$Company {
  const factory Company({
    required String id,
    required String name,
    required List<Branch> branches,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
}
