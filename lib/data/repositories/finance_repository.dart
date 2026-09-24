import '../models/finance.dart';

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
}
