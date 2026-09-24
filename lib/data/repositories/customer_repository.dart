import '../models/customer.dart';

/// Customer master access (sales + accounts share it).
abstract class CustomerRepository {
  Future<List<Customer>> list();
  Future<Customer?> get(String id);
}
