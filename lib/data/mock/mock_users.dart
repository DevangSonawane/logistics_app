import '../models/app_user.dart';
import '../models/branch.dart';

/// Demo credentials from Section 9 of the build prompt.
/// OTP for every account: 123456. Wrong OTP errors, 000000 = expired.
/// Consignee POD OTP: 4321. Lock page demo PIN: 1234.
abstract final class MockUsers {
  static const String demoOtp = '123456';
  static const String expiredOtp = '000000';
  static const String podOtp = '4321';
  static const String demoPin = '1234';

  static const String invalidPhone = '1234567890';
  static const String blockedPhone = '9000000000';

  static const List<AppUser> users = [
    AppUser(
      id: 'u-driver-1',
      name: 'Ramesh Yadav',
      phone: '9000000001',
      roles: [AppRole.driver],
      branchIds: ['br-pune'],
      language: 'hi',
    ),
    AppUser(
      id: 'u-driver-2',
      name: 'Suresh Patil',
      phone: '9000000002',
      roles: [AppRole.driver],
      branchIds: ['br-pune'],
      language: 'mr',
    ),
    AppUser(
      id: 'u-driver-3',
      name: 'Murugan K',
      phone: '9000000003',
      roles: [AppRole.driver],
      branchIds: ['br-chennai'],
      language: 'ta',
    ),
    AppUser(
      id: 'u-owner-1',
      name: 'Anil Mehta',
      phone: '9000000011',
      roles: [AppRole.owner],
      branchIds: ['br-mumbai', 'br-pune', 'br-chennai', 'br-delhi'],
      language: 'en',
    ),
    AppUser(
      id: 'u-ops-1',
      name: 'Priya Nair',
      phone: '9000000021',
      roles: [AppRole.ops],
      branchIds: ['br-mumbai'],
      language: 'en',
    ),
    AppUser(
      id: 'u-sales-1',
      name: 'Karan Shah',
      phone: '9000000031',
      roles: [AppRole.sales],
      branchIds: ['br-mumbai'],
      language: 'en',
    ),
    AppUser(
      id: 'u-sup-1',
      name: 'Vijay Gaikwad',
      phone: '9000000041',
      roles: [AppRole.supervisor],
      branchIds: ['br-pune'],
      language: 'mr',
    ),
    AppUser(
      id: 'u-acct-1',
      name: 'Neha Kulkarni',
      phone: '9000000051',
      roles: [AppRole.accountant],
      branchIds: ['br-mumbai'],
      language: 'en',
      canRecordReceipt: true,
    ),
    AppUser(
      id: 'u-multi-1',
      name: 'Rajesh Iyer',
      phone: '9000000099',
      roles: [AppRole.owner, AppRole.ops, AppRole.driver],
      branchIds: ['br-mumbai', 'br-chennai'],
      language: 'en',
    ),
  ];

  static AppUser? byPhone(String phone) {
    for (final AppUser user in users) {
      if (user.phone == phone) return user;
    }
    return null;
  }
}

/// Seed company + branches. Full domain seed (customers, lanes, vehicles,
/// drivers, trips, orders, leads, invoices, approvals, exceptions,
/// notifications, ledgers, hub tasks, KPIs, rate cards) lands in Phase 3-7.
// TODO(Phases 3-7): expand mock_data.dart with the Section 8.2 seed.
abstract final class MockCompany {
  static const Company company = Company(
    id: 'co-1',
    name: 'Shree Ganesh Roadlines Pvt Ltd',
    branches: [
      Branch(id: 'br-mumbai', name: 'Mumbai HQ', city: 'Mumbai'),
      Branch(id: 'br-pune', name: 'Pune Hub', city: 'Pune'),
      Branch(id: 'br-chennai', name: 'Chennai Branch', city: 'Chennai'),
      Branch(id: 'br-delhi', name: 'Delhi Branch', city: 'Delhi'),
    ],
  );
}
