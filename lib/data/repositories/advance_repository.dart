import '../models/advance.dart';

/// Advance repository: request + per-trip history.
abstract class AdvanceRepository {
  Future<List<Advance>> list(String tripId);

  Future<Advance> request(Advance advance);
}
