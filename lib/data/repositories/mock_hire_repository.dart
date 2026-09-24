import 'package:uuid/uuid.dart';

import '../mock/mock_delay.dart';
import '../models/approval.dart';
import '../models/hire.dart';
import 'approval_repository.dart';
import 'hire_repository.dart';

class MockHireRepository implements HireRepository {
  MockHireRepository({ApprovalRepository? approvals}) : _approvals = approvals;

  final List<MarketVehicle> _vehicles = const [
    MarketVehicle(
      vehicleNo: 'MH04 XX 3434',
      ownerName: 'Shinde Transport',
      pan: 'AAKCS4433P',
      driverName: 'Nilesh Shinde',
      driverPhone: '9816666666',
    ),
    MarketVehicle(
      vehicleNo: 'GJ27 YY 5656',
      ownerName: 'Patel Roadways',
      pan: 'AAKCP8877Q',
      driverName: 'Raju Patel',
      driverPhone: '9827777777',
    ),
  ];

  final ApprovalRepository? _approvals;
  final Uuid _uuid = const Uuid();

  /// Advances above this raise an approval instead of paying out.
  static const int advanceApprovalLimit = 25000;

  @override
  Future<List<MarketVehicle>> vehicles() async {
    await mockDelay();
    return List.unmodifiable(_vehicles);
  }

  @override
  Future<MarketVehicle> addVehicle(MarketVehicle vehicle) async {
    await mockDelay();
    throwIfChaos();
    return vehicle;
  }

  @override
  Future<HireMemo> createMemo(HireMemo memo) async {
    await mockDelay();
    throwIfChaos();
    return memo.copyWith(id: 'hm-${_uuid.v4().substring(0, 6)}');
  }

  @override
  Future<({bool paid, bool needsApproval})> payAdvance(
    HireMemo memo, {
    required String requester,
  }) async {
    await mockDelay();
    throwIfChaos();
    if (memo.advance > advanceApprovalLimit) {
      await _approvals?.create(
        type: ApprovalType.vendor,
        requester: requester,
        amount: memo.advance,
        reason: 'Market advance above Rs.25,000 (${memo.vehicleNo})',
      );
      return (paid: false, needsApproval: true);
    }
    return (paid: true, needsApproval: false);
  }
}
