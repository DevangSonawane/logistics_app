import '../../mock/mock_business_data.dart';
import '../../mock/mock_delay.dart';
import '../models/exception.dart';
import 'exception_repository.dart';

class MockExceptionRepository implements ExceptionRepository {
  MockExceptionRepository() {
    _items.addAll(MockBusinessData.exceptions());
  }

  final List<ExceptionItem> _items = [];

  @override
  Future<List<ExceptionItem>> list() async {
    await mockDelay();
    throwIfChaos();
    final List<ExceptionItem> sorted = List.of(_items);
    sorted.sort((a, b) {
      if (a.resolved != b.resolved) return a.resolved ? 1 : -1;
      final int sev = b.severity.index.compareTo(a.severity.index);
      if (sev != 0) return sev;
      return b.at.compareTo(a.at);
    });
    return sorted;
  }

  @override
  Future<ExceptionItem> resolve(String id, String note) async {
    await mockDelay();
    final int i = _items.indexWhere((e) => e.id == id);
    if (i < 0) throw const MockApiException('Exception not found');
    final ExceptionItem updated =
        _items[i].copyWith(resolved: true, resolutionNote: note);
    _items[i] = updated;
    return updated;
  }

  @override
  Future<ExceptionItem> escalate(String id) async {
    await mockDelay();
    final int i = _items.indexWhere((e) => e.id == id);
    if (i < 0) throw const MockApiException('Exception not found');
    final ExceptionItem current = _items[i];
    final int next =
        (current.severity.index + 1).clamp(0, ExceptionSeverity.values.length - 1);
    final ExceptionItem updated = current.copyWith(
      severity: ExceptionSeverity.values[next],
    );
    _items[i] = updated;
    return updated;
  }
}
