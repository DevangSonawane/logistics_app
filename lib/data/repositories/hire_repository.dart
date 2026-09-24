import '../models/hire.dart';

/// Market (broker) vehicles: KYC master, hire memos, advance payout with
/// the above-limit approval rule.
abstract class HireRepository {
  Future<List<MarketVehicle>> vehicles();
  Future<MarketVehicle> addVehicle(MarketVehicle vehicle);
  Future<HireMemo> createMemo(HireMemo memo);

  /// Returns (paid, needsApproval): advances above the limit raise an
  /// approval request instead of paying out.
  Future<({bool paid, bool needsApproval})> payAdvance(
    HireMemo memo, {
    required String requester,
  });
}
