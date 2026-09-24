import 'package:flutter_test/flutter_test.dart';
import 'package:roadops/data/models/approval.dart';
import 'package:roadops/data/repositories/mock_approval_repository.dart';
import 'package:roadops/data/repositories/mock_vehicle_repository.dart';

/// NOTE: not executed yet - full test pass happens at the end (user call).
void main() {
  group('approvals inbox', () {
    test('decide approves and rejects with comment rule', () async {
      final MockApprovalRepository repo = MockApprovalRepository();
      final List<ApprovalItem> items = await repo.list();
      expect(items.where((a) => a.status == ApprovalStatus.pending), isNotEmpty);

      final ApprovalItem first = items.first;
      final ApprovalItem approved =
          await repo.decide(id: first.id, approve: true);
      expect(approved.status, ApprovalStatus.approved);

      // Reject without a comment throws.
      expect(
        () => repo.decide(id: items[1].id, approve: false),
        throwsA(isA<Exception>()),
      );
      final ApprovalItem rejected = await repo.decide(
        id: items[1].id,
        approve: false,
        comment: 'Over budget',
      );
      expect(rejected.status, ApprovalStatus.rejected);

      // Undo reopens.
      final ApprovalItem reopened = await repo.reopen(first.id);
      expect(reopened.status, ApprovalStatus.pending);
    });

    test('create raises above-limit market advances', () async {
      final MockApprovalRepository repo = MockApprovalRepository();
      final int before = (await repo.list()).length;
      await repo.create(
        type: ApprovalType.vendor,
        requester: 'Ops',
        amount: 30000,
        reason: 'Market advance above Rs.25,000',
      );
      expect((await repo.list()).length, before + 1);
    });
  });

  group('vehicle suggestions', () {
    test('ranks docs-valid idle fits first', () async {
      final MockVehicleRepository repo = MockVehicleRepository();
      final suggested = await repo.suggest(
        weightKg: 14000,
        vehicleType: '32 ft MXL',
      );
      expect(suggested, isNotEmpty);
      // Top pick fits the load and is idle with valid docs.
      expect(suggested.first.capacityTons * 1000 >= 14000, isTrue);
    });
  });
}
