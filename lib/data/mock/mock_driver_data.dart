import '../models/advance.dart';
import '../models/driver.dart';
import '../models/expense.dart';
import '../models/trip.dart';
import '../models/vehicle.dart';

/// Driver seed: Ramesh runs Pune->Chennai, Suresh has a trip offer,
/// Murugan has nothing (empty state). Money in integer rupees.
abstract final class MockDriverData {
  static Trip rameshTrip() {
    final DateTime now = DateTime.now();
    return Trip(
      id: 'trip-ramesh-1',
      no: 'TRIP-2026-0847',
      orderId: 'ORD-1042',
      customer: 'Bajaj Auto',
      pickupAddress: 'Bajaj Auto Plant, Akurdi, Pune',
      pickupContact: 'Sanjay Patil',
      pickupPhone: '9812345678',
      pickupLat: 18.5204,
      pickupLng: 73.8567,
      dropAddress: 'Bajaj Auto Depot, Ennore, Chennai',
      dropContact: 'Karthik Raja',
      dropPhone: '9912345678',
      dropLat: 13.0827,
      dropLng: 80.2707,
      distanceKm: 1180,
      freightAllowance: 4500,
      pickupBy: now.add(const Duration(hours: 6)),
      vehicleReg: 'MH12 AB 1234',
      driverId: 'u-driver-1',
      status: TripStatus.started,
      plannedEta: now.add(const Duration(hours: 20)),
      liveEta: now.add(const Duration(hours: 22)),
      steps: [
        TripStep(
          type: TripStepType.reachedPickup,
          at: now.subtract(const Duration(hours: 5)),
          lat: 18.5204,
          lng: 73.8567,
        ),
        TripStep(
          type: TripStepType.loadingDone,
          at: now.subtract(const Duration(hours: 3)),
          lat: 18.5204,
          lng: 73.8567,
        ),
        TripStep(
          type: TripStepType.startTrip,
          at: now.subtract(const Duration(hours: 2, minutes: 30)),
          lat: 18.6104,
          lng: 73.9167,
        ),
      ],
      lrNo: 'LR-88412',
      ewayBillNo: 'EWB-271200445566',
      advanceGiven: 15000,
    );
  }

  static Trip sureshOffer() {
    final DateTime now = DateTime.now();
    return Trip(
      id: 'trip-suresh-offer-1',
      no: 'TRIP-2026-0851',
      orderId: 'ORD-1049',
      customer: 'Parle Products',
      pickupAddress: 'Parle Factory, Vile Parle, Mumbai',
      pickupContact: 'Amit Shah',
      pickupPhone: '9822345678',
      pickupLat: 19.076,
      pickupLng: 72.8777,
      dropAddress: 'Parle Depot, Tumkur Road, Bengaluru',
      dropContact: 'Divya Nair',
      dropPhone: '9932345678',
      dropLat: 12.9716,
      dropLng: 77.5946,
      distanceKm: 985,
      freightAllowance: 4000,
      pickupBy: now.add(const Duration(hours: 10)),
      vehicleReg: 'MH14 CD 5678',
      driverId: 'u-driver-2',
      status: TripStatus.offered,
      plannedEta: now.add(const Duration(hours: 26)),
      lrNo: 'LR-88419',
      ewayBillNo: 'EWB-271200445577',
    );
  }

  static List<Expense> rameshExpenses() {
    final DateTime now = DateTime.now();
    return [
      Expense(
        id: 'exp-1',
        tripId: 'trip-ramesh-1',
        type: ExpenseType.diesel,
        amount: 11800,
        litres: 130,
        rate: 90.77,
        note: 'HP pump, Solapur road',
        status: ExpenseStatus.approved,
        normFlag: true,
        createdAt: now.subtract(const Duration(hours: 4)),
      ),
      Expense(
        id: 'exp-2',
        tripId: 'trip-ramesh-1',
        type: ExpenseType.toll,
        amount: 850,
        status: ExpenseStatus.submitted,
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
    ];
  }

  static List<Advance> rameshAdvances() {
    final DateTime now = DateTime.now();
    return [
      Advance(
        id: 'adv-1',
        tripId: 'trip-ramesh-1',
        amount: 15000,
        purpose: AdvancePurpose.fuel,
        status: AdvanceStatus.paid,
        requestedAt: now.subtract(const Duration(days: 1)),
      ),
      Advance(
        id: 'adv-2',
        tripId: 'trip-ramesh-1',
        amount: 3000,
        purpose: AdvancePurpose.toll,
        note: 'Toll plazas after Solapur',
        status: AdvanceStatus.requested,
        requestedAt: now.subtract(const Duration(hours: 6)),
      ),
    ];
  }

  static Driver driver(String userId) {
    return switch (userId) {
      'u-driver-1' => Driver(
          id: 'u-driver-1',
          name: 'Ramesh Yadav',
          phone: '9000000001',
          licenseNo: 'MH12 20150012345',
          licenseExpiry: DateTime.now().add(const Duration(days: 400)),
          rating: 4.7,
          onTimePct: 94,
          languages: const ['hi'],
          vehicleReg: 'MH12 AB 1234',
        ),
      'u-driver-2' => Driver(
          id: 'u-driver-2',
          name: 'Suresh Patil',
          phone: '9000000002',
          licenseNo: 'MH14 20170054321',
          licenseExpiry: DateTime.now().add(const Duration(days: 200)),
          rating: 4.5,
          onTimePct: 91,
          languages: const ['mr'],
          vehicleReg: 'MH14 CD 5678',
        ),
      _ => Driver(
          id: 'u-driver-3',
          name: 'Murugan K',
          phone: '9000000003',
          licenseNo: 'TN09 20190098765',
          licenseExpiry: DateTime.now().add(const Duration(days: 900)),
          rating: 4.8,
          onTimePct: 96,
          languages: const ['ta'],
        ),
    };
  }

  static EarningsSummary earnings() {
    final DateTime now = DateTime.now();
    return EarningsSummary(
      monthTotal: 38500,
      allowances: [
        AllowanceEntry(
          tripNo: 'TRIP-2026-0812',
          lane: 'Pune-Chennai',
          amount: 4500,
          date: now.subtract(const Duration(days: 12)),
        ),
        AllowanceEntry(
          tripNo: 'TRIP-2026-0821',
          lane: 'Mumbai-Delhi',
          amount: 6000,
          date: now.subtract(const Duration(days: 8)),
        ),
        AllowanceEntry(
          tripNo: 'TRIP-2026-0833',
          lane: 'Pune-Hyderabad',
          amount: 2800,
          date: now.subtract(const Duration(days: 4)),
        ),
        AllowanceEntry(
          tripNo: 'TRIP-2026-0847',
          lane: 'Pune-Chennai',
          amount: 4500,
          date: now,
        ),
      ],
      incentives: 2000,
      advanceTaken: 18000,
      expensesTotal: 12650,
      settlementBalance: 5350,
      tripsDone: 14,
      onTimePct: 94,
      slips: [
        SalarySlip(id: 'slip-08', month: 'Aug 2026', amount: 37200),
        SalarySlip(id: 'slip-07', month: 'Jul 2026', amount: 36500),
      ],
    );
  }

  static List<VehicleDoc> vehicleDocs() {
    final DateTime now = DateTime.now();
    return [
      VehicleDoc(
        type: VehicleDocType.licence,
        number: 'MH12 20150012345',
        expiry: now.add(const Duration(days: 400)),
      ),
      VehicleDoc(
        type: VehicleDocType.rc,
        number: 'MH12AB1234',
        expiry: now.add(const Duration(days: 800)),
      ),
      VehicleDoc(
        type: VehicleDocType.insurance,
        number: 'POL-882314',
        expiry: now.add(const Duration(days: 5)),
      ),
      VehicleDoc(
        type: VehicleDocType.fitness,
        number: 'FIT-55210',
        expiry: now.add(const Duration(days: 20)),
      ),
      VehicleDoc(
        type: VehicleDocType.permit,
        number: 'NP-77120',
        expiry: now.add(const Duration(days: 300)),
      ),
      VehicleDoc(
        type: VehicleDocType.puc,
        number: 'PUC-99012',
        expiry: now.add(const Duration(days: 60)),
      ),
    ];
  }
}
