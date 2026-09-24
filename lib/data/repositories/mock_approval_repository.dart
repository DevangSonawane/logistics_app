import 'package:uuid/uuid.dart';

import '../mock/mock_business_data.dart';
import '../mock/mock_delay.dart';
import '../models/approval.dart';
import 'approval_repository.dart';

class MockApprovalRepository implements ApprovalRepository {
  MockApprovalRepository() {
    _items.addAll(MockBusinessData.approvals());
  }

  final List<ApprovalItem> _items = [];
  final Uuid _uuid = const Uuid();

  @override
  Future<List<ApprovalItem>> list() async {
    await mockDelay();
    throwIfChaos();
    final List<ApprovalItem> sorted = List.of(_items);
    sorted.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return sorted;
  }

  @override
  Future<ApprovalItem> decide({
    required String id,
    required bool approve,
    String? comment,
  }) async {
    await mockDelay();
    throwIfChaos();
    final int i = _items.indexWhere((a) => a.id == id);
    if (i < 0) throw const MockApiException('Approval not found');
    if (!approve && (comment == null || comment.trim().isEmpty)) {
      throw const MockApiException('Rejection needs a comment');
    }
    final ApprovalItem updated = _items[i].copyWith(
      status: approve ? ApprovalStatus.approved : ApprovalStatus.rejected,
      comment: comment,
    );
    _items[i] = updated;
    return updated;
  }

  @override
  Future<ApprovalItem> reopen(String id) async {
    await mockDelay();
    final int i = _items.indexWhere((a) => a.id == id);
    if (i < 0) throw const MockApiException('Approval not found');
    final ApprovalItem updated =
        _items[i].copyWith(status: ApprovalStatus.pending, comment: null);
    _items[i] = updated;
    return updated;
  }

  @override
  Future<ApprovalItem> create({
    required ApprovalType type,
    required String requester,
    required int amount,
    required String reason,
  }) async {
    await mockDelay();
    final ApprovalItem item = ApprovalItem(
      id: 'ap-${_uuid.v4().substring(0, 6)}',
      type: type,
      requester: requester,
      amount: amount,
      reason: reason,
      createdAt: DateTime.now(),
    );
    _items.insert(0, item);
    return item;
  }
}
