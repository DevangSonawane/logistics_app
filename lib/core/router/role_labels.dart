import '../l10n/app_localizations.dart';
import '../../data/models/app_user.dart';

/// Localized role names shared by login demo chips, role picker and profile.
String roleLabel(AppLocalizations l10n, AppRole role) {
  return switch (role) {
    AppRole.driver => l10n.roleDriver,
    AppRole.owner => l10n.roleOwner,
    AppRole.ops => l10n.roleOps,
    AppRole.sales => l10n.roleSales,
    AppRole.supervisor => l10n.roleSupervisor,
    AppRole.accountant => l10n.roleAccountant,
  };
}

/// "Owner + Ops" style summary for multi-role users.
String rolesSummary(AppLocalizations l10n, List<AppRole> roles) {
  return roles.map((r) => roleLabel(l10n, r)).join(' + ');
}
