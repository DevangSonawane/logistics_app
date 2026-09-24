import 'package:flutter/material.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../owner/approvals/approvals_inbox_page.dart';

/// A4. Payments + expenses approvals with the Rs.50,000 amount-limit rule:
/// bigger items forward to the owner instead of final approval.
class AccountApprovalsPage extends StatelessWidget {
  const AccountApprovalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return ApprovalsInboxPage(
      approvalCap: 50000,
      capNote: l10n.limitForwarded,
    );
  }
}
