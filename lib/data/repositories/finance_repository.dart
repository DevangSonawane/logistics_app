import '../models/finance.dart';
import '../models/invoice.dart';

/// View-only finance reads for owner + accountant.
abstract class FinanceRepository {
  Future<List<LedgerEntry>> customerLedger(String customerId);
  Future<List<LedgerEntry>> vendorLedger(String vendor);
  Future<List<AgeingBucket>> ageing();
  Future<List<BankAccount>> bankBalances();
  Future<GstSummary> gstSummary();
  Future<List<LedgerEntry>> dayBook();
  Future<List<TripPnl>> tripPnl();
  Future<List<PnlLine>> pnl();

  /// Records a receipt against invoices (permission-gated upstream).
  Future<Receipt> recordReceipt(Receipt receipt);
}
