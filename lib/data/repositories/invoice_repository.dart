import '../models/invoice.dart';

/// Accountant invoices + receipts.
abstract class InvoiceRepository {
  Future<List<Invoice>> list();
  Future<Invoice?> get(String id);
}
