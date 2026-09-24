import '../mock/mock_delay.dart';
import '../models/invoice.dart';
import 'invoice_repository.dart';

/// Mock invoices: 20 across draft/sent/part-paid/paid/overdue with IRN
/// chips on the e-invoiced ones.
class MockInvoiceRepository implements InvoiceRepository {
  MockInvoiceRepository() {
    final DateTime now = DateTime.now();
    final List<String> custs = [
      'cust-tata:Tata Agrico Ltd',
      'cust-reliance:Reliance Retail',
      'cust-asian:Asian Paints',
      'cust-bajaj:Bajaj Auto',
      'cust-amul:Amul Dairy',
    ];
    const List<InvoiceStatus> cycle = [
      InvoiceStatus.sent,
      InvoiceStatus.paid,
      InvoiceStatus.overdue,
      InvoiceStatus.partPaid,
      InvoiceStatus.draft,
    ];
    for (int i = 0; i < 20; i++) {
      final List<String> parts = custs[i % custs.length].split(':');
      final InvoiceStatus status = cycle[i % cycle.length];
      final int amount = 180000 + (i * 47000) % 600000;
      _invoices.add(
        Invoice(
          id: 'inv-${2190 + i}',
          no: 'INV-${2190 + i}',
          customerId: parts[0],
          customerName: parts[1],
          amount: amount,
          gst: (amount * 0.18).round(),
          status: status,
          dueDate: now.add(Duration(days: 30 - (i * 7) % 60)),
          irn: i % 3 == 0 ? 'IRN-77${(100000 + i * 137).toString()}' : null,
          paidAmount: status == InvoiceStatus.paid
              ? amount
              : status == InvoiceStatus.partPaid
                  ? amount ~/ 2
                  : 0,
        ),
      );
    }
  }

  final List<Invoice> _invoices = [];

  @override
  Future<List<Invoice>> list() async {
    await mockDelay();
    throwIfChaos();
    return List.unmodifiable(_invoices);
  }

  @override
  Future<Invoice?> get(String id) async {
    await mockDelay();
    for (final Invoice inv in _invoices) {
      if (inv.id == id) return inv;
    }
    return null;
  }
}
