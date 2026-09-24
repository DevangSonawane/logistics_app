import '../models/approval.dart';

/// Approvals inbox: owner + accountant decision flows.
abstract class ApprovalRepository {
  Future<List<ApprovalItem>> list();
  Future<ApprovalItem> decide({
    required String id,
    required bool approve,
    String? comment,
  });

  /// Undo window (5 s toast) reopens a just-decided item.
  Future<ApprovalItem> reopen(String id);

  /// Raises a new approval (e.g. market advance above the limit).
  Future<ApprovalItem> create({
    required ApprovalType type,
    required String requester,
    required int amount,
    required String reason,
  });
}
