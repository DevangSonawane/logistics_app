import '../../mock/mock_business_data.dart';
import '../../mock/mock_delay.dart';
import '../models/customer.dart';
import 'customer_repository.dart';

class MockCustomerRepository implements CustomerRepository {
  @override
  Future<List<Customer>> list() async {
    await mockDelay();
    throwIfChaos();
    return MockBusinessData.customers();
  }

  @override
  Future<Customer?> get(String id) async {
    await mockDelay();
    final List<Customer> all = MockBusinessData.customers();
    for (final Customer c in all) {
      if (c.id == id) return c;
    }
    return null;
  }
}
