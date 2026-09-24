import 'package:flutter_test/flutter_test.dart';
import 'package:roadops/data/models/hub.dart';
import 'package:roadops/data/models/invoice.dart';
import 'package:roadops/data/repositories/mock_finance_repository.dart';
import 'package:roadops/data/repositories/mock_hub_repository.dart';
import 'package:roadops/data/repositories/mock_invoice_repository.dart';
import 'package:roadops/data/repositories/mock_notification_repository.dart';

/// NOTE: not executed yet - full test pass happens at the end (user call).
void main() {
  group('hub supervisor', () {
    test('today has loadings and arrivals', () async {
      final MockHubRepository repo = MockHubRepository();
      final List<HubTask> tasks = await repo.todayTasks();
      expect(
        tasks.where((t) => t.type == HubTaskType.loading).length,
        5,
      );
      expect(
        tasks.where((t) => t.type == HubTaskType.arrival).length,
        5,
      );
    });

    test('gate in/out stamps times and finishes the task', () async {
      final MockHubRepository repo = MockHubRepository();
      final HubTask in_ = await repo.gateIn('hub-1', 'MH12 AB 1234', 'R');
      expect(in_.gateInAt, isNotNull);
      expect(in_.status, HubTaskStatus.inProgress);
      final HubTask out = await repo.gateOut('hub-1');
      expect(out.gateOutAt, isNotNull);
      expect(out.status, HubTaskStatus.done);
    });

    test('manifest captures scanned items', () async {
      final MockHubRepository repo = MockHubRepository();
      final Manifest manifest = await repo.createManifest(
        'Chennai Hub',
        [
          ScanItem(code: 'PKG-1', at: DateTime(2026)),
          ScanItem(code: 'PKG-2', at: DateTime(2026), damaged: true),
        ],
      );
      expect(manifest.items.length, 2);
      expect((await repo.manifests()).first.id, manifest.id);
    });
  });

  group('invoices and receipts', () {
    test('seed mixes statuses with IRN chips', () async {
      final MockInvoiceRepository repo = MockInvoiceRepository();
      final List<Invoice> invoices = await repo.list();
      expect(invoices.length, 20);
      expect(
        invoices.map((i) => i.status).toSet(),
        containsAll([
          InvoiceStatus.draft,
          InvoiceStatus.sent,
          InvoiceStatus.partPaid,
          InvoiceStatus.paid,
          InvoiceStatus.overdue,
        ]),
      );
      expect(invoices.any((i) => i.irn != null), isTrue);
    });

    test('record receipt echoes the payload', () async {
      final MockFinanceRepository finance = MockFinanceRepository();
      final Receipt saved = await finance.recordReceipt(
        Receipt(
          id: 'local',
          customerId: 'cust-tata',
          invoiceIds: const ['inv-2190'],
          amount: 100000,
          mode: 'UPI',
          at: DateTime(2026),
        ),
      );
      expect(saved.amount, 100000);
      expect(saved.mode, 'UPI');
    });
  });

  group('notification centre', () {
    test('unread count drops on read and mark-all', () async {
      final MockNotificationRepository repo =
          MockNotificationRepository();
      final int before = await repo.unreadCount();
      expect(before, greaterThan(0));
      final String firstUnread =
          (await repo.list()).firstWhere((n) => !n.read).id;
      await repo.markRead(firstUnread);
      expect(await repo.unreadCount(), before - 1);
      await repo.markAllRead();
      expect(await repo.unreadCount(), 0);
    });
  });
}
