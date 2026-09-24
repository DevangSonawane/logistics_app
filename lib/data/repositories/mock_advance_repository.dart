import 'package:uuid/uuid.dart';

import '../../mock/mock_delay.dart';
import '../../mock/mock_driver_data.dart';
import '../models/advance.dart';
import 'advance_repository.dart';

/// Mock advance store. Approvals arrive as mock notifications (Phase 3
/// marks requested items approved on the next sync drain for demo).
class MockAdvanceRepository implements AdvanceRepository {
  MockAdvanceRepository() {
    _byTrip['trip-ramesh-1'] = MockDriverData.rameshAdvances();
  }

  final Map<String, List<Advance>> _byTrip = {};
  final Uuid _uuid = const Uuid();

  @override
  Future<List<Advance>> list(String tripId) async {
    await mockDelay();
    throwIfChaos();
    return List.unmodifiable(_byTrip[tripId] ?? const []);
  }

  @override
  Future<Advance> request(Advance advance) async {
    await mockDelay();
    throwIfChaos();
    final Advance saved = advance.copyWith(
      id: _uuid.v4(),
      status: AdvanceStatus.requested,
      requestedAt: DateTime.now(),
    );
    _byTrip.putIfAbsent(advance.tripId, () => []).add(saved);
    return saved;
  }
}
