import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

/// Roles supported by the single RoadOps app.
enum AppRole { driver, owner, ops, sales, supervisor, accountant }

/// Granular permissions checked via `canProvider(...)`.
enum AppPermission {
  approveAdvance,
  approveExpense,
  approveRate,
  approveCredit,
  approveVendorPayment,
  recordReceipt,
}

/// Logged-in user. Created by admin only; no self sign-up.
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String name,
    required String phone,
    required List<AppRole> roles,
    required List<String> branchIds,
    String? avatarUrl,
    required String language,
    @Default(false) bool canRecordReceipt,
    @Default(true) bool isActive,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}

/// Static role -> permission map. Amount-limit rules (e.g. accountant
/// forwards above Rs.50,000 to Owner) are enforced at the UI layer.
bool hasPermission(AppUser user, AppRole activeRole, AppPermission permission) {
  switch (permission) {
    case AppPermission.recordReceipt:
      return activeRole == AppRole.accountant && user.canRecordReceipt;
    case AppPermission.approveAdvance:
    case AppPermission.approveExpense:
      return activeRole == AppRole.owner || activeRole == AppRole.accountant;
    case AppPermission.approveRate:
    case AppPermission.approveCredit:
    case AppPermission.approveVendorPayment:
      return activeRole == AppRole.owner;
  }
}
