import '../models/customer.dart';
import '../models/order.dart';
import '../models/vehicle.dart';

/// Customer master access (sales + accounts share it).
abstract class CustomerRepository {
  Future<List<Customer>> list();
  Future<Customer?> get(String id);
}
