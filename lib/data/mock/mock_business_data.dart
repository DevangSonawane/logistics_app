import 'dart:math';

import '../models/approval.dart';
import '../models/customer.dart';
import '../models/dashboard.dart';
import '../models/driver.dart';
import '../models/exception.dart';
import '../models/finance.dart';
import '../models/lane.dart';
import '../models/notification.dart';
import '../models/order.dart';
import '../models/trip.dart';
import '../models/vehicle.dart';

/// Section 8.2 business seed: customers, lanes, vehicles, drivers, orders,
/// trips, approvals, exceptions, notifications, ledgers, KPIs, rate cards.
/// Money in integer rupees.
abstract final class MockBusinessData {
  static List<Customer> customers() => const [
        Customer(
          id: 'cust-tata',
          name: 'Tata Agrico Ltd',
          gstin: '27AAKCS1234F1Z5',
          pan: 'AAKCS1234F',
          creditDays: 45,
          creditLimit: 5000000,
          outstanding: 1240000,
          contacts: [CustomerContact(name: 'R. Sharma', phone: '9811111111')],
        ),
        Customer(
          id: 'cust-reliance',
          name: 'Reliance Retail',
          gstin: '27AAKCR4567G1Z2',
          pan: 'AAKCR4567G',
          creditDays: 30,
          creditLimit: 8000000,
          outstanding: 2180000,
          contacts: [CustomerContact(name: 'M. Iyer', phone: '9822222222')],
        ),
        Customer(
          id: 'cust-asian',
          name: 'Asian Paints',
          gstin: '27AAKCA7890H1Z3',
          pan: 'AAKCA7890H',
          creditDays: 60,
          creditLimit: 4000000,
          outstanding: 640000,
          contacts: [CustomerContact(name: 'S. Rao', phone: '9833333333')],
        ),
        Customer(
          id: 'cust-godrej',
          name: 'Godrej Consumer',
          gstin: '27AAKCG1122J1Z4',
          pan: 'AAKCG1122J',
          creditDays: 45,
          creditLimit: 3500000,
          outstanding: 410000,
          contacts: [CustomerContact(name: 'P. Menon', phone: '9844444444')],
        ),
        Customer(
          id: 'cust-havells',
          name: 'Havells India',
          gstin: '07AAKCH3344K1Z5',
          pan: 'AAKCH3344K',
          creditDays: 30,
          creditLimit: 3000000,
          outstanding: 980000,
          contacts: [CustomerContact(name: 'V. Gupta', phone: '9855555555')],
        ),
        Customer(
          id: 'cust-parle',
          name: 'Parle Products',
          gstin: '27AAKCP5566L1Z6',
          pan: 'AAKCP5566L',
          creditDays: 45,
          creditLimit: 2500000,
          outstanding: 320000,
          contacts: [CustomerContact(name: 'A. Shah', phone: '9866666666')],
        ),
        Customer(
          id: 'cust-bajaj',
          name: 'Bajaj Auto',
          gstin: '27AAKCB7788M1Z7',
          pan: 'AAKCB7788M',
          creditDays: 60,
          creditLimit: 6000000,
          outstanding: 1560000,
          contacts: [CustomerContact(name: 'S. Patil', phone: '9877777777')],
        ),
        Customer(
          id: 'cust-amul',
          name: 'Amul Dairy',
          gstin: '24AAKCA9900N1Z8',
          pan: 'AAKCA9900N',
          creditDays: 30,
          creditLimit: 4500000,
          outstanding: 870000,
          contacts: [CustomerContact(name: 'H. Patel', phone: '9888888888')],
        ),
      ];

  static List<Lane> lanes() => const [
        Lane(id: 'lane-1', from: 'Pune', to: 'Chennai', distanceKm: 1180, transitHrs: 30),
        Lane(id: 'lane-2', from: 'Mumbai', to: 'Delhi', distanceKm: 1420, transitHrs: 36),
        Lane(id: 'lane-3', from: 'Mumbai', to: 'Bengaluru', distanceKm: 985, transitHrs: 26),
        Lane(id: 'lane-4', from: 'Pune', to: 'Hyderabad', distanceKm: 560, transitHrs: 15),
        Lane(id: 'lane-5', from: 'Delhi', to: 'Jaipur', distanceKm: 280, transitHrs: 8),
        Lane(id: 'lane-6', from: 'Chennai', to: 'Bengaluru', distanceKm: 350, transitHrs: 10),
        Lane(id: 'lane-7', from: 'Ahmedabad', to: 'Mumbai', distanceKm: 530, transitHrs: 14),
        Lane(id: 'lane-8', from: 'Nagpur', to: 'Pune', distanceKm: 720, transitHrs: 19),
        Lane(id: 'lane-9', from: 'Kolkata', to: 'Patna', distanceKm: 600, transitHrs: 17),
        Lane(id: 'lane-10', from: 'Indore', to: 'Mumbai', distanceKm: 590, transitHrs: 16),
      ];

  static List<Vehicle> vehicles() {
    final DateTime now = DateTime.now();
    Vehicle v({
      required String id,
      required String reg,
      required String type,
      required double cap,
      VehicleOwnership own = VehicleOwnership.own,
      VehicleStatus status = VehicleStatus.idle,
      required double lat,
      required double lng,
      int insDays = 300,
      int fitDays = 200,
    }) =>
        Vehicle(
          id: id,
          regNo: reg,
          type: type,
          capacityTons: cap,
          ownership: own,
          status: status,
          lastLat: lat,
          lastLng: lng,
          lastUpdate: now.subtract(const Duration(minutes: 12)),
          mileageKm: 120000 + id.hashCode % 200000,
          docs: [
            VehicleDoc(type: VehicleDocType.insurance, number: 'POL-$id', expiry: now.add(Duration(days: insDays))),
            VehicleDoc(type: VehicleDocType.fitness, number: 'FIT-$id', expiry: now.add(Duration(days: fitDays))),
            VehicleDoc(type: VehicleDocType.permit, number: 'NP-$id', expiry: now.add(const Duration(days: 300))),
          ],
        );
    return [
      v(id: 'v-1', reg: 'MH12 AB 1234', type: '32 ft MXL', cap: 16, status: VehicleStatus.onTrip, lat: 16.5, lng: 77.5),
      v(id: 'v-2', reg: 'MH14 CD 5678', type: '32 ft MXL', cap: 16, lat: 19.0, lng: 73.0),
      v(id: 'v-3', reg: 'MH04 EF 9012', type: '20 ft', cap: 9, lat: 19.07, lng: 72.87),
      v(id: 'v-4', reg: 'KA01 GH 3456', type: 'Container', cap: 18, status: VehicleStatus.onTrip, lat: 14.5, lng: 76.0),
      v(id: 'v-5', reg: 'TN09 JK 7890', type: '32 ft MXL', cap: 16, status: VehicleStatus.onTrip, lat: 12.9, lng: 79.5),
      v(id: 'v-6', reg: 'MH12 LM 1122', type: 'Tata Ace', cap: 1.5, lat: 18.52, lng: 73.85),
      v(id: 'v-7', reg: 'GJ01 RS 3344', type: 'Reefer', cap: 14, status: VehicleStatus.onTrip, lat: 21.0, lng: 73.5),
      v(id: 'v-8', reg: 'DL01 TT 5566', type: 'Trailer', cap: 25, lat: 28.6, lng: 77.2),
      v(id: 'v-9', reg: 'MH14 UU 7788', type: '32 ft MXL', cap: 16, status: VehicleStatus.onTrip, lat: 20.5, lng: 76.8, insDays: 6),
      v(id: 'v-10', reg: 'KA05 VV 9900', type: '20 ft', cap: 9, status: VehicleStatus.maintenance, lat: 12.97, lng: 77.59, fitDays: 15),
      v(id: 'v-11', reg: 'TN10 WW 1212', type: 'Container', cap: 18, own: VehicleOwnership.market, status: VehicleStatus.onTrip, lat: 13.5, lng: 79.0),
      v(id: 'v-12', reg: 'MH04 XX 3434', type: '32 ft MXL', cap: 16, own: VehicleOwnership.market, lat: 19.2, lng: 73.1, insDays: 25),
      v(id: 'v-13', reg: 'GJ27 YY 5656', type: '20 ft', cap: 9, own: VehicleOwnership.market, lat: 23.0, lng: 72.5),
      v(id: 'v-14', reg: 'DL08 ZZ 7878', type: '32 ft MXL', cap: 16, own: VehicleOwnership.market, lat: 28.7, lng: 77.1),
      v(id: 'v-15', reg: 'MH12 AA 9090', type: 'Tata Ace', cap: 1.5, own: VehicleOwnership.market, lat: 18.6, lng: 73.9),
    ];
  }

  static List<Driver> drivers() {
    final DateTime now = DateTime.now();
    Driver d({
      required String id,
      required String name,
      required String phone,
      required String lang,
      String? vehicle,
    }) =>
        Driver(
          id: id,
          name: name,
          phone: phone,
          licenseNo: 'LIC-${id.hashCode % 90000 + 10000}',
          licenseExpiry: now.add(const Duration(days: 500)),
          rating: 4.3 + (id.hashCode % 6) / 10,
          onTimePct: 88 + id.hashCode % 10,
          languages: [lang],
          vehicleReg: vehicle,
        );
    return [
      d(id: 'u-driver-1', name: 'Ramesh Yadav', phone: '9000000001', lang: 'hi', vehicle: 'MH12 AB 1234'),
      d(id: 'u-driver-2', name: 'Suresh Patil', phone: '9000000002', lang: 'mr', vehicle: 'MH14 CD 5678'),
      d(id: 'u-driver-3', name: 'Murugan K', phone: '9000000003', lang: 'ta'),
      d(id: 'u-driver-4', name: 'Ravi Kumar', phone: '9000000004', lang: 'te', vehicle: 'KA01 GH 3456'),
      d(id: 'u-driver-5', name: 'Basavaraj', phone: '9000000005', lang: 'kn', vehicle: 'TN09 JK 7890'),
      d(id: 'u-driver-6', name: 'Sukhdev Singh', phone: '9000000006', lang: 'pa', vehicle: 'GJ01 RS 3344'),
      d(id: 'u-driver-7', name: 'Abdul Rahman', phone: '9000000007', lang: 'bn', vehicle: 'MH14 UU 7788'),
      d(id: 'u-driver-8', name: 'Manoj Tiwari', phone: '9000000008', lang: 'hi', vehicle: 'TN10 WW 1212'),
      d(id: 'u-driver-9', name: 'Arjun Deshmukh', phone: '9000000009', lang: 'mr', vehicle: 'MH04 EF 9012'),
      d(id: 'u-driver-10', name: 'Deepak Chauhan', phone: '9000000010', lang: 'hi', vehicle: 'MH12 LM 1122'),
    ];
  }

  static List<Order> orders() {
    final DateTime now = DateTime.now();
    final List<Order> list = [];
    final List<Map<String, dynamic>> spec = [
      {'c': 0, 'l': 0, 's': OrderStatus.pending, 't': OrderType.ftl, 'v': '32 ft MXL', 'w': 14000.0, 'r': 78500},
      {'c': 1, 'l': 1, 's': OrderStatus.pending, 't': OrderType.ftl, 'v': '32 ft MXL', 'w': 15000.0, 'r': 96000},
      {'c': 2, 'l': 2, 's': OrderStatus.pending, 't': OrderType.ftl, 'v': '20 ft', 'w': 8000.0, 'r': 52000},
      {'c': 6, 'l': 0, 's': OrderStatus.planned, 't': OrderType.ftl, 'v': '32 ft MXL', 'w': 14500.0, 'r': 79000},
      {'c': 3, 'l': 3, 's': OrderStatus.planned, 't': OrderType.ftl, 'v': 'Container', 'w': 16000.0, 'r': 41000},
      {'c': 4, 'l': 4, 's': OrderStatus.planned, 't': OrderType.ftl, 'v': '20 ft', 'w': 7000.0, 'r': 24000},
      {'c': 5, 'l': 5, 's': OrderStatus.running, 't': OrderType.ptl, 'v': 'Tata Ace', 'w': 1200.0, 'r': 9500},
      {'c': 0, 'l': 6, 's': OrderStatus.running, 't': OrderType.ftl, 'v': '20 ft', 'w': 8500.0, 'r': 38000},
      {'c': 7, 'l': 9, 's': OrderStatus.running, 't': OrderType.ftl, 'v': 'Reefer', 'w': 12000.0, 'r': 44000},
      {'c': 1, 'l': 7, 's': OrderStatus.completed, 't': OrderType.ftl, 'v': '32 ft MXL', 'w': 15000.0, 'r': 54000},
      {'c': 2, 'l': 8, 's': OrderStatus.completed, 't': OrderType.ftl, 'v': 'Trailer', 'w': 22000.0, 'r': 61000},
      {'c': 3, 'l': 0, 's': OrderStatus.completed, 't': OrderType.ftl, 'v': '32 ft MXL', 'w': 14000.0, 'r': 78000},
      {'c': 4, 'l': 1, 's': OrderStatus.completed, 't': OrderType.ftl, 'v': '32 ft MXL', 'w': 15500.0, 'r': 95500},
      {'c': 5, 'l': 2, 's': OrderStatus.completed, 't': OrderType.ptl, 'v': 'Tata Ace', 'w': 900.0, 'r': 8200},
      {'c': 6, 'l': 3, 's': OrderStatus.completed, 't': OrderType.ftl, 'v': 'Container', 'w': 17000.0, 'r': 43000},
      {'c': 7, 'l': 4, 's': OrderStatus.pending, 't': OrderType.ptl, 'v': 'Tata Ace', 'w': 1100.0, 'r': 6800},
      {'c': 0, 'l': 9, 's': OrderStatus.pending, 't': OrderType.ftl, 'v': '20 ft', 'w': 7500.0, 'r': 42000},
      {'c': 1, 'l': 5, 's': OrderStatus.completed, 't': OrderType.ftl, 'v': '20 ft', 'w': 8000.0, 'r': 26000},
      {'c': 2, 'l': 6, 's': OrderStatus.completed, 't': OrderType.ftl, 'v': '32 ft MXL', 'w': 14500.0, 'r': 39500},
      {'c': 3, 'l': 7, 's': OrderStatus.pending, 't': OrderType.ftl, 'v': '32 ft MXL', 'w': 15000.0, 'r': 48000},
    ];
    final List<Customer> custs = customers();
    final List<Lane> laneList = lanes();
    for (int i = 0; i < spec.length; i++) {
      final Map<String, dynamic> s = spec[i];
      final Customer c = custs[s['c'] as int];
      final Lane l = laneList[s['l'] as int];
      list.add(
        Order(
          id: 'ord-${1040 + i}',
          no: 'ORD-${1040 + i}',
          customerId: c.id,
          customerName: c.name,
          type: s['t'] as OrderType,
          stops: [
            OrderStop(address: '${l.from} warehouse', lat: 18.5, lng: 73.8, windowStart: now.add(const Duration(hours: 4))),
            OrderStop(address: '${l.to} depot', lat: 13.0, lng: 80.2),
          ],
          vehicleType: s['v'] as String,
          commodity: 'General goods',
          weightKg: (s['w'] as double),
          rate: s['r'] as int,
          status: s['s'] as OrderStatus,
          neededBy: now.add(Duration(days: 1 + i % 4)),
        ),
      );
    }
    return list;
  }

  /// 25 business trips: 6 running (2 delayed), 5 delivered POD-pending,
  /// 8 closed, 4 planned, 2 cancelled.
  static List<Trip> businessTrips() {
    final DateTime now = DateTime.now();
    final List<Trip> list = [];
    final List<String> custNames = [
      'Tata Agrico Ltd', 'Reliance Retail', 'Asian Paints', 'Godrej Consumer',
      'Havells India', 'Parle Products', 'Bajaj Auto', 'Amul Dairy',
    ];
    final List<(double, double)> routeEnds = [
      (19.076, 72.8777), // Mumbai
      (28.6139, 77.209), // Delhi
      (12.9716, 77.5946), // Bengaluru
      (17.385, 78.4867), // Hyderabad
    ];
    Trip base(int i, TripStatus status) {
      final (double lat, double lng) = routeEnds[i % routeEnds.length];
      return Trip(
        id: 'trip-b-${i.toString().padLeft(2, '0')}',
        no: 'TRIP-2026-${800 + i}',
        orderId: 'ORD-${1040 + (i % 20)}',
        customer: custNames[i % custNames.length],
        pickupAddress: 'Pickup hub ${i + 1}',
        pickupContact: 'Contact ${i + 1}',
        pickupPhone: '98100000${(10 + i).toString().padLeft(2, '0')}',
        pickupLat: 18.5204,
        pickupLng: 73.8567,
        dropAddress: 'Drop point ${i + 1}',
        dropContact: 'Receiver ${i + 1}',
        dropPhone: '99100000${(10 + i).toString().padLeft(2, '0')}',
        dropLat: lat,
        dropLng: lng,
        distanceKm: 500 + (i * 37) % 900,
        freightAllowance: 3000 + (i * 211) % 3000,
        pickupBy: now.add(Duration(hours: 4 + i)),
        vehicleReg: vehicles()[i % vehicles().length].regNo,
        driverId: 'u-driver-${4 + (i % 7)}',
        status: status,
        plannedEta: now.add(Duration(hours: 20 + i)),
        liveEta: now.add(Duration(hours: 20 + i + (i % 3 == 0 ? 5 : 0))),
        lrNo: 'LR-${88000 + i}',
        ewayBillNo: 'EWB-27120044${(5500 + i).toString()}',
        advanceGiven: 8000 + (i * 613) % 9000,
      );
    }

    for (int i = 0; i < 6; i++) {
      list.add(base(i, TripStatus.started));
    }
    for (int i = 6; i < 11; i++) {
      list.add(base(i, TripStatus.delivered).copyWith(podStatus: PodStatus.submitted));
    }
    for (int i = 11; i < 19; i++) {
      list.add(base(i, TripStatus.closed));
    }
    for (int i = 19; i < 23; i++) {
      list.add(base(i, TripStatus.assigned));
    }
    for (int i = 23; i < 25; i++) {
      list.add(base(i, TripStatus.cancelled));
    }
    return list;
  }

  static List<ApprovalItem> approvals() {
    final DateTime now = DateTime.now();
    ApprovalItem a({
      required String id,
      required ApprovalType type,
      required String requester,
      required int amount,
      required String reason,
      String? risk,
      required int ageHrs,
    }) =>
        ApprovalItem(
          id: id,
          type: type,
          requester: requester,
          amount: amount,
          reason: reason,
          riskFlag: risk,
          createdAt: now.subtract(Duration(hours: ageHrs)),
        );
    return [
      a(id: 'ap-1', type: ApprovalType.advance, requester: 'Ramesh Yadav', amount: 3000, reason: 'Toll plazas after Solapur', ageHrs: 6),
      a(id: 'ap-2', type: ApprovalType.expense, requester: 'Sukhdev Singh', amount: 12400, reason: 'Diesel HP pump Panipat', risk: 'Above norm by 22%', ageHrs: 9),
      a(id: 'ap-3', type: ApprovalType.rate, requester: 'Priya Nair', amount: 72000, reason: 'Pune-Chennai 32 ft, urgent loading', risk: 'Below contract rate', ageHrs: 3),
      a(id: 'ap-4', type: ApprovalType.credit, requester: 'Karan Shah', amount: 150000, reason: '60-day credit for new lane', risk: 'Credit limit crossed', ageHrs: 26),
      a(id: 'ap-5', type: ApprovalType.vendor, requester: 'Priya Nair', amount: 85000, reason: 'Broker balance on POD', risk: 'Above your Rs.50,000 limit', ageHrs: 12),
      a(id: 'ap-6', type: ApprovalType.purchase, requester: 'Vijay Gaikwad', amount: 18000, reason: 'Tarpaulin + ropes for hub', ageHrs: 30),
      a(id: 'ap-7', type: ApprovalType.advance, requester: 'Ravi Kumar', amount: 5000, reason: 'Food + toll buffer', ageHrs: 2),
      a(id: 'ap-8', type: ApprovalType.expense, requester: 'Basavaraj', amount: 2400, reason: 'Puncture repair Tumkur road', ageHrs: 15),
      a(id: 'ap-9', type: ApprovalType.expense, requester: 'Manoj Tiwari', amount: 31000, reason: 'Clutch plate replacement', risk: 'Above norm by 35%', ageHrs: 20),
      a(id: 'ap-10', type: ApprovalType.advance, requester: 'Arjun Deshmukh', amount: 8000, reason: 'Diesel top-up Nashik', ageHrs: 1),
      a(id: 'ap-11', type: ApprovalType.rate, requester: 'Priya Nair', amount: 54000, reason: 'Nagpur-Pune return load', ageHrs: 8),
      a(id: 'ap-12', type: ApprovalType.vendor, requester: 'Neha Kulkarni', amount: 42000, reason: 'Monthly GPS subscription', ageHrs: 50),
    ];
  }

  static List<ExceptionItem> exceptions() {
    final DateTime now = DateTime.now();
    ExceptionItem e({
      required String id,
      required ExceptionType type,
      required ExceptionSeverity sev,
      required String trip,
      required String veh,
      required String driver,
      required String phone,
      required String msg,
      required int minsAgo,
    }) =>
        ExceptionItem(
          id: id,
          type: type,
          tripId: trip,
          vehicleReg: veh,
          driverName: driver,
          driverPhone: phone,
          severity: sev,
          message: msg,
          at: now.subtract(Duration(minutes: minsAgo)),
        );
    return [
      e(id: 'ex-sos', type: ExceptionType.sos, sev: ExceptionSeverity.critical, trip: 'trip-ramesh-1', veh: 'MH12 AB 1234', driver: 'Ramesh Yadav', phone: '9000000001', msg: 'SOS: breakdown near Solapur', minsAgo: 25),
      e(id: 'ex-1', type: ExceptionType.delay, sev: ExceptionSeverity.high, trip: 'trip-b-00', veh: 'MH14 UU 7788', driver: 'Abdul Rahman', phone: '9000000007', msg: 'Delayed 5h vs ETA (traffic at Satara)', minsAgo: 40),
      e(id: 'ex-2', type: ExceptionType.delay, sev: ExceptionSeverity.high, trip: 'trip-b-03', veh: 'GJ01 RS 3344', driver: 'Sukhdev Singh', phone: '9000000006', msg: 'Delayed 3h vs ETA', minsAgo: 90),
      e(id: 'ex-3', type: ExceptionType.halt, sev: ExceptionSeverity.medium, trip: 'trip-b-01', veh: 'KA01 GH 3456', driver: 'Ravi Kumar', phone: '9000000004', msg: 'Halt 2h near Chitradurga', minsAgo: 130),
      e(id: 'ex-4', type: ExceptionType.deviation, sev: ExceptionSeverity.medium, trip: 'trip-b-02', veh: 'TN09 JK 7890', driver: 'Basavaraj', phone: '9000000005', msg: 'Route deviation 18 km', minsAgo: 200),
      e(id: 'ex-5', type: ExceptionType.overspeed, sev: ExceptionSeverity.low, trip: 'trip-b-04', veh: 'TN10 WW 1212', driver: 'Manoj Tiwari', phone: '9000000008', msg: 'Overspeed 92 km/h (limit 80)', minsAgo: 300),
      e(id: 'ex-6', type: ExceptionType.deviceOff, sev: ExceptionSeverity.high, trip: 'trip-b-05', veh: 'MH12 AB 1234', driver: 'Ramesh Yadav', phone: '9000000001', msg: 'GPS device off 45 min', minsAgo: 55),
      e(id: 'ex-7', type: ExceptionType.ewayExpiring, sev: ExceptionSeverity.high, trip: 'trip-b-01', veh: 'KA01 GH 3456', driver: 'Ravi Kumar', phone: '9000000004', msg: 'E-way bill expires in 6h', minsAgo: 20),
      e(id: 'ex-8', type: ExceptionType.podPending, sev: ExceptionSeverity.medium, trip: 'trip-b-06', veh: 'MH04 EF 9012', driver: 'Arjun Deshmukh', phone: '9000000009', msg: 'POD pending 30h', minsAgo: 400),
      e(id: 'ex-9', type: ExceptionType.podPending, sev: ExceptionSeverity.medium, trip: 'trip-b-07', veh: 'MH12 LM 1122', driver: 'Deepak Chauhan', phone: '9000000010', msg: 'POD pending 26h', minsAgo: 500),
    ];
  }

  static List<AppNotification> notifications() {
    final DateTime now = DateTime.now();
    AppNotification n({
      required String id,
      required String title,
      required String body,
      required String type,
      String? link,
      required int minsAgo,
      bool read = false,
    }) =>
        AppNotification(
          id: id,
          title: title,
          body: body,
          type: type,
          deeplink: link,
          read: read,
          at: now.subtract(Duration(minutes: minsAgo)),
        );
    return [
      n(id: 'n-1', title: 'SOS from Ramesh Yadav', body: 'Breakdown near Solapur', type: 'sos', link: 'roadops://trip/trip-ramesh-1', minsAgo: 25),
      n(id: 'n-2', title: 'Advance request Rs.3,000', body: 'Ramesh Yadav - toll plazas', type: 'approval', link: 'roadops://approval/ap-1', minsAgo: 35),
      n(id: 'n-3', title: 'Payment received Rs.4.2 L', body: 'Reliance Retail - invoice INV-2210', type: 'payment', minsAgo: 70, read: true),
      n(id: 'n-4', title: 'Trip delayed 5h', body: 'TRIP-2026-800 traffic at Satara', type: 'delay', link: 'roadops://trip/trip-b-00', minsAgo: 90),
      n(id: 'n-5', title: 'POD pending 30h', body: 'TRIP-2026-806 needs follow-up', type: 'pod', minsAgo: 150, read: true),
      n(id: 'n-6', title: 'Insurance expiring', body: 'MH14 UU 7788 expires in 6 days', type: 'doc', minsAgo: 220),
      n(id: 'n-7', title: 'E-way bill expiring', body: 'TRIP-2026-801 expires in 6h', type: 'eway', minsAgo: 240),
      n(id: 'n-8', title: 'New lead: Sharma Traders', body: 'Pune-Chennai lane, 8 trips/month', type: 'lead', link: 'roadops://lead/lead-1', minsAgo: 300, read: true),
      n(id: 'n-9', title: 'Invoice overdue', body: 'INV-2198 Rs.1.8 L, 12 days overdue', type: 'invoice', link: 'roadops://invoice/inv-2198', minsAgo: 380),
      n(id: 'n-10', title: 'Expense approved', body: 'Diesel Rs.11,800 approved', type: 'approval', minsAgo: 420, read: true),
      n(id: 'n-11', title: 'Trip delivered', body: 'TRIP-2026-806 POD submitted', type: 'trip', link: 'roadops://trip/trip-b-06', minsAgo: 460, read: true),
      n(id: 'n-12', title: 'Credit limit crossed', body: 'Reliance Retail at 104% of limit', type: 'credit', minsAgo: 520),
      n(id: 'n-13', title: 'Vehicle maintenance due', body: 'KA05 VV 9900 service overdue', type: 'doc', minsAgo: 600, read: true),
      n(id: 'n-14', title: 'Rate exception', body: 'Pune-Chennai below contract rate', type: 'approval', link: 'roadops://approval/ap-3', minsAgo: 700),
      n(id: 'n-15', title: 'Daily brief ready', body: 'Your 9 AM summary is ready', type: 'brief', minsAgo: 760, read: true),
    ];
  }

  static List<LedgerEntry> customerLedger(String customerId) {
    final DateTime now = DateTime.now();
    final Customer customer =
        customers().firstWhere((c) => c.id == customerId);
    int balance = 0;
    final List<LedgerEntry> entries = [];
    final List<(int, int, String, int)> rows = [
      (45, 0, 'Opening balance', 0),
      (38, 285000, 'INV-2201 freight', 1),
      (30, 0, 'Receipt UTR-88112', -1),
      (21, 312000, 'INV-2210 freight', 1),
      (12, 0, 'Receipt UTR-88455', -1),
      (5, 298000, 'INV-2218 freight', 1),
    ];
    for (int i = 0; i < rows.length; i++) {
      final (daysAgo, amount, particulars, sign) = rows[i];
      if (sign > 0) {
        balance += amount;
      } else if (sign < 0) {
        balance -= amount;
      }
      entries.add(
        LedgerEntry(
          id: '$customerId-$i',
          accountName: customer.name,
          date: now.subtract(Duration(days: daysAgo)),
          particulars: particulars,
          debit: sign > 0 ? amount : 0,
          credit: sign < 0 ? amount : 0,
          balance: balance,
        ),
      );
    }
    return entries;
  }

  static List<LedgerEntry> vendorLedger(String vendor) {
    final DateTime now = DateTime.now();
    return [
      LedgerEntry(id: 'v-1', accountName: vendor, date: now.subtract(const Duration(days: 20)), particulars: 'Hire memo HM-301', debit: 0, credit: 78000, balance: 78000),
      LedgerEntry(id: 'v-2', accountName: vendor, date: now.subtract(const Duration(days: 12)), particulars: 'Advance paid', debit: 30000, credit: 0, balance: 48000),
      LedgerEntry(id: 'v-3', accountName: vendor, date: now.subtract(const Duration(days: 4)), particulars: 'Hire memo HM-312', debit: 0, credit: 64000, balance: 112000),
    ];
  }

  static List<AgeingBucket> ageing() => const [
        AgeingBucket(label: '0-30', amount: 4250000),
        AgeingBucket(label: '31-60', amount: 1820000),
        AgeingBucket(label: '61-90', amount: 960000),
        AgeingBucket(label: '90+', amount: 410000),
      ];

  static List<BankAccount> banks() => const [
        BankAccount(name: 'HDFC Current', balance: 2840000),
        BankAccount(name: 'ICICI Current', balance: 1280000),
      ];

  static GstSummary gst() => const GstSummary(
        month: 'Sep 2026',
        cgst: 184000,
        sgst: 184000,
        igst: 412000,
      );

  static List<LedgerEntry> dayBook() {
    final DateTime now = DateTime.now();
    return [
      LedgerEntry(id: 'd-1', accountName: 'Day book', date: now, particulars: 'Freight received - Reliance', debit: 0, credit: 420000, balance: 420000),
      LedgerEntry(id: 'd-2', accountName: 'Day book', date: now, particulars: 'Diesel - Ramesh trip', debit: 11800, credit: 0, balance: 408200),
      LedgerEntry(id: 'd-3', accountName: 'Day book', date: now, particulars: 'Broker advance HM-312', debit: 30000, credit: 0, balance: 378200),
      LedgerEntry(id: 'd-4', accountName: 'Day book', date: now, particulars: 'Freight received - Bajaj', debit: 0, credit: 265000, balance: 643200),
    ];
  }

  static List<TripPnl> tripPnl() => const [
        TripPnl(tripNo: 'TRIP-2026-812', lane: 'Pune-Chennai', revenue: 78500, cost: 61200, margin: 17300),
        TripPnl(tripNo: 'TRIP-2026-821', lane: 'Mumbai-Delhi', revenue: 96000, cost: 78400, margin: 17600),
        TripPnl(tripNo: 'TRIP-2026-833', lane: 'Pune-Hyderabad', revenue: 41000, cost: 33900, margin: 7100),
        TripPnl(tripNo: 'TRIP-2026-841', lane: 'Mumbai-Bengaluru', revenue: 52000, cost: 44800, margin: 7200),
        TripPnl(tripNo: 'TRIP-2026-845', lane: 'Delhi-Jaipur', revenue: 24000, cost: 22100, margin: 1900),
        TripPnl(tripNo: 'TRIP-2026-846', lane: 'Chennai-Bengaluru', revenue: 26000, cost: 27500, margin: -1500),
      ];

  static List<PnlLine> pnl() => const [
        PnlLine(label: 'Freight revenue', amount: 19600000),
        PnlLine(label: 'Vehicle hire', amount: -5200000),
        PnlLine(label: 'Diesel', amount: -4800000),
        PnlLine(label: 'Toll + permits', amount: -1400000),
        PnlLine(label: 'Driver payout', amount: -3900000),
        PnlLine(label: 'Gross profit', amount: 4300000),
        PnlLine(label: 'Office + staff', amount: -1800000),
        PnlLine(label: 'Net profit', amount: 2500000),
      ];

  static DashboardKpis kpis() => const DashboardKpis(
        tripsToday: 34,
        running: 18,
        delayed: 4,
        delivered: 12,
        revenueToday: 840000,
        revenueMonth: 19600000,
        collectionsMonth: 16200000,
        outstanding: 7440000,
        cashBank: 4120000,
        utilisationPct: 78,
      );

  static List<TrendPoint> trend() {
    final Random random = Random(7);
    return List.generate(30, (i) {
      final int base = 520000 + (i * 9000) % 180000;
      final int noise = random.nextInt(90000) - 45000;
      final int revenue = base + noise;
      return TrendPoint(
        day: '${i + 1}',
        revenue: revenue,
        collection: revenue - 40000 - random.nextInt(80000),
      );
    });
  }

  static List<LaneMargin> topLanes() => const [
        LaneMargin(lane: 'Pune-Chennai', marginPct: 22),
        LaneMargin(lane: 'Mumbai-Delhi', marginPct: 18),
        LaneMargin(lane: 'Pune-Hyderabad', marginPct: 17),
        LaneMargin(lane: 'Mumbai-Bengaluru', marginPct: 14),
        LaneMargin(lane: 'Nagpur-Pune', marginPct: 12),
      ];

  static List<CustomerMargin> bottomCustomers() => const [
        CustomerMargin(name: 'Chennai-Bengaluru lane', marginPct: -6, outstanding: 320000),
        CustomerMargin(name: 'Delhi-Jaipur lane', marginPct: 4, outstanding: 980000),
        CustomerMargin(name: 'Parle Products', marginPct: 7, outstanding: 320000),
      ];

  static List<AttentionItem> attention() => const [
        AttentionItem(title: 'Trips delayed', count: 3, kind: 'delay'),
        AttentionItem(title: 'Approvals waiting', count: 5, kind: 'approval'),
        AttentionItem(title: 'Documents expiring', count: 2, kind: 'doc'),
        AttentionItem(title: 'POD pending over 24h', count: 4, kind: 'pod'),
      ];

  static String brief() =>
      'Good morning. 34 trips today: 18 running, 4 delayed, 12 delivered. '
      'Revenue billed Rs.8.4 L today, Rs.1.96 Cr this month against Rs.1.62 Cr collected. '
      'Outstanding Rs.74.4 L needs follow-up, led by Reliance Retail. '
      'Fleet utilisation 78%. Wins: Pune-Chennai margin 22%. '
      'Risks: 2 insurance renewals due this week, 4 PODs pending over 24h.';

  static DataAnswer ask(String query) {
    final String q = query.toLowerCase();
    if (q.contains('margin') || q.contains('lowest')) {
      return const DataAnswer(
        text: 'Chennai-Bengaluru ran at -6% margin last month, the lowest. '
            'Diesel escalation and empty returns are the cause.',
        series: [12, 9, 4, -2, -6],
      );
    }
    if (q.contains('delay')) {
      return const DataAnswer(
        text: '4 trips are delayed right now: 2 traffic holds near Satara, '
            '1 halt at Chitradurga and 1 GPS gap. Worst is TRIP-2026-800 at +5h.',
        series: [1, 2, 2, 3, 4],
      );
    }
    if (q.contains('outstanding') || q.contains('payment') || q.contains('dues')) {
      return const DataAnswer(
        text: 'Outstanding is Rs.74.4 L. Reliance Retail (Rs.21.8 L, 104% of limit) '
            'and Bajaj Auto (Rs.15.6 L) top the list. Rs.9.6 L sits in 61-90 days.',
        series: [62, 68, 71, 73, 74],
      );
    }
    return const DataAnswer(
      text: 'Fleet utilisation is 78% this month with 34 trips today. '
          'Pune-Chennai remains the most profitable lane at 22% margin.',
      series: [70, 72, 75, 76, 78],
    );
  }

  /// Contract rate per trip by lane + vehicle type.
  static int? rateFor(String from, String to, String vehicle) {
    const Map<String, int> cards = {
      'Pune|Chennai|32 ft MXL': 78500,
      'Mumbai|Delhi|32 ft MXL': 96000,
      'Mumbai|Bengaluru|20 ft': 52000,
      'Pune|Hyderabad|Container': 41000,
      'Delhi|Jaipur|20 ft': 24000,
      'Chennai|Bengaluru|20 ft': 26000,
      'Pune|Chennai|20 ft': 54000,
      'Mumbai|Delhi|20 ft': 68000,
    };
    return cards['$from|$to|$vehicle'];
  }

  static const int detentionPerDay = 2000;
  static const int loadingCharge = 1500;
  static const int multiDropPerPoint = 2500;
  static const String dieselNote =
      'Diesel escalation applies beyond Rs.90/litre base.';
}
