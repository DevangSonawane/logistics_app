import 'package:freezed_annotation/freezed_annotation.dart';

part 'approval.freezed.dart';
part 'approval.g.dart';

enum ApprovalType { advance, expense, rate, credit, vendor, purchase }

enum ApprovalStatus { pending, approved, rejected, info }

/// Approval inbox item. Amount-limit rules (accountant Rs.50,000) are
/// enforced at the UI layer; rejection requires a comment.
@freezed
abstract class ApprovalItem with _$ApprovalItem {
  const factory ApprovalItem({
    required String id,
    required ApprovalType type,
    required String requester,
    required int amount,
    required String reason,
    String? riskFlag,
    @Default([]) List<String> attachments,
    @Default(ApprovalStatus.pending) ApprovalStatus status,
    String? comment,
    required DateTime createdAt,
  }) = _ApprovalItem;

  factory ApprovalItem.fromJson(Map<String, dynamic> json) =>
      _$ApprovalItemFromJson(json);
}
