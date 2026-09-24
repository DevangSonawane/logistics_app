import '../../mock/mock_business_data.dart';
import '../../mock/mock_delay.dart';
import '../models/finance.dart';
import 'finance_repository.dart';

class MockFinanceRepository implements FinanceRepository {
  @override
  Future<List<LedgerEntry>> customerLedger(String customerId) async {
    await mockDelay();
    throwIfChaos();
    return MockBusinessData.customerLedger(customerId);
  }

  @override
  Future<List<LedgerEntry>> vendorLedger(String vendor) async {
    await mockDelay();
    throwIfChaos();
    return MockBusinessData.vendorLedger(vendor);
  }

  @override
  Future<List<AgeingBucket>> ageing() async {
    await mockDelay();
    return MockBusinessData.ageing();
  }

  @override
  Future<List<BankAccount>> bankBalances() async {
    await mockDelay();
    return MockBusinessData.banks();
  }

  @override
  Future<GstSummary> gstSummary() async {
    await mockDelay();
    return MockBusinessData.gst();
  }

  @override
  Future<List<LedgerEntry>> dayBook() async {
    await mockDelay();
    return MockBusinessData.dayBook();
  }

  @override
  Future<List<TripPnl>> tripPnl() async {
    await mockDelay();
    return MockBusinessData.tripPnl();
  }

  @override
  Future<List<PnlLine>> pnl() async {
    await mockDelay();
    return MockBusinessData.pnl();
  }
}
