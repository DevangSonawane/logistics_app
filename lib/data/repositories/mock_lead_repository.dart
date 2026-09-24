import 'package:uuid/uuid.dart';

import '../mock/mock_delay.dart';
import '../models/lead.dart';
import 'lead_repository.dart';

/// Mock sales pipeline. SLA clocks and duplicate detection are demo rules:
/// same phone/GSTIN warns, first response due in 30 minutes.
class MockLeadRepository implements LeadRepository {
  MockLeadRepository() {
    final DateTime now = DateTime.now();
    Lead l({
      required String id,
      required String company,
      required String contact,
      required String phone,
      required LeadSource source,
      required String from,
      required String to,
      required LeadStage stage,
      required int slaMins,
      int trips = 4,
      int rate = 75000,
    }) =>
        Lead(
          id: id,
          company: company,
          contact: contact,
          phone: phone,
          source: source,
          from: from,
          to: to,
          commodity: 'General goods',
          vehicleType: '32 ft MXL',
          expectedTrips: trips,
          targetRate: rate,
          stage: stage,
          slaDue: now.add(Duration(minutes: slaMins)),
        );
    _leads.addAll([
      l(id: 'lead-1', company: 'Sharma Traders', contact: 'R. Sharma', phone: '9811112222', source: LeadSource.website, from: 'Pune', to: 'Chennai', stage: LeadStage.fresh, slaMins: 12, trips: 8, rate: 78000),
      l(id: 'lead-2', company: 'Khan Goods', contact: 'S. Khan', phone: '9811113333', source: LeadSource.whatsapp, from: 'Mumbai', to: 'Delhi', stage: LeadStage.fresh, slaMins: 25),
      l(id: 'lead-3', company: 'Patel & Sons', contact: 'H. Patel', phone: '9811114444', source: LeadSource.indiamart, from: 'Ahmedabad', to: 'Mumbai', stage: LeadStage.contacted, slaMins: -30),
      l(id: 'lead-4', company: 'Gupta Mills', contact: 'V. Gupta', phone: '9811115555', source: LeadSource.justdial, from: 'Delhi', to: 'Jaipur', stage: LeadStage.contacted, slaMins: 60),
      l(id: 'lead-5', company: 'Nair Foods', contact: 'P. Nair', phone: '9811116666', source: LeadSource.referral, from: 'Chennai', to: 'Bengaluru', stage: LeadStage.quoted, slaMins: 120, rate: 26000),
      l(id: 'lead-6', company: 'Reddy Logistics', contact: 'K. Reddy', phone: '9811117777', source: LeadSource.website, from: 'Pune', to: 'Hyderabad', stage: LeadStage.quoted, slaMins: 180, rate: 41000),
      l(id: 'lead-7', company: 'Singh Brothers', contact: 'G. Singh', phone: '9811118888', source: LeadSource.walkin, from: 'Indore', to: 'Mumbai', stage: LeadStage.negotiation, slaMins: 300, rate: 42000),
      l(id: 'lead-8', company: 'Das Enterprises', contact: 'A. Das', phone: '9811119999', source: LeadSource.email, from: 'Kolkata', to: 'Patna', stage: LeadStage.negotiation, slaMins: 400),
      l(id: 'lead-9', company: 'Mehta Textiles', contact: 'N. Mehta', phone: '9811120000', source: LeadSource.ivr, from: 'Mumbai', to: 'Bengaluru', stage: LeadStage.won, slaMins: -5000, rate: 52000),
      l(id: 'lead-10', company: 'Joshi Papers', contact: 'D. Joshi', phone: '9811121111', source: LeadSource.website, from: 'Nagpur', to: 'Pune', stage: LeadStage.won, slaMins: -6000),
      l(id: 'lead-11', company: 'Chopra Plastics', contact: 'R. Chopra', phone: '9811122222', source: LeadSource.indiamart, from: 'Delhi', to: 'Jaipur', stage: LeadStage.lost, slaMins: -7000),
      l(id: 'lead-12', company: 'Verma Steels', contact: 'S. Verma', phone: '9811123333', source: LeadSource.justdial, from: 'Mumbai', to: 'Delhi', stage: LeadStage.fresh, slaMins: 8, trips: 12, rate: 95000),
      l(id: 'lead-13', company: 'Iyer Chemicals', contact: 'M. Iyer', phone: '9811124444', source: LeadSource.referral, from: 'Chennai', to: 'Bengaluru', stage: LeadStage.contacted, slaMins: 45),
      l(id: 'lead-14', company: 'Bose Electronics', contact: 'S. Bose', phone: '9811125555', source: LeadSource.email, from: 'Kolkata', to: 'Patna', stage: LeadStage.fresh, slaMins: 18),
      l(id: 'lead-15', company: 'Kulkarni Foods', contact: 'A. Kulkarni', phone: '9811126666', source: LeadSource.walkin, from: 'Pune', to: 'Hyderabad', stage: LeadStage.quoted, slaMins: 240),
      l(id: 'lead-16', company: 'Agarwal Traders', contact: 'P. Agarwal', phone: '9811127777', source: LeadSource.whatsapp, from: 'Indore', to: 'Mumbai', stage: LeadStage.fresh, slaMins: 5, trips: 6),
      l(id: 'lead-17', company: 'Menon Rubbers', contact: 'K. Menon', phone: '9811128888', source: LeadSource.website, from: 'Chennai', to: 'Bengaluru', stage: LeadStage.negotiation, slaMins: 360),
      l(id: 'lead-18', company: 'Pillai Spices', contact: 'R. Pillai', phone: '9811129999', source: LeadSource.referral, from: 'Mumbai', to: 'Bengaluru', stage: LeadStage.contacted, slaMins: 90),
    ]);
    _visits.addAll([
      Visit(id: 'vst-1', title: 'Sharma Traders', plannedAt: now.add(const Duration(hours: 2))),
      Visit(id: 'vst-2', title: 'Khan Goods', plannedAt: now.add(const Duration(hours: 5))),
      Visit(
        id: 'vst-0',
        title: 'Patel & Sons',
        plannedAt: now.subtract(const Duration(days: 1)),
        checkedInAt: now.subtract(const Duration(days: 1, hours: -2)),
        checkedOutAt: now.subtract(const Duration(days: 1, hours: -3)),
        outcome: 'Interested - quote sent',
      ),
    ]);
  }

  final List<Lead> _leads = [];
  final List<Visit> _visits = [];
  final Uuid _uuid = const Uuid();

  @override
  Future<List<Lead>> leads() async {
    await mockDelay();
    throwIfChaos();
    return List.unmodifiable(_leads);
  }

  @override
  Future<Lead> add(Lead lead) async {
    await mockDelay();
    throwIfChaos();
    final Lead saved = lead.copyWith(
      id: 'lead-${_uuid.v4().substring(0, 6)}',
      slaDue: DateTime.now().add(const Duration(minutes: 30)),
    );
    _leads.insert(0, saved);
    return saved;
  }

  @override
  Future<Lead> setStage(String id, LeadStage stage) async {
    await mockDelay();
    final int i = _leads.indexWhere((l) => l.id == id);
    if (i < 0) throw const MockApiException('Lead not found');
    final Lead updated = _leads[i].copyWith(stage: stage);
    _leads[i] = updated;
    return updated;
  }

  @override
  Future<List<Visit>> visits() async {
    await mockDelay();
    return List.unmodifiable(_visits);
  }

  @override
  Future<Visit> checkIn(Visit visit) async {
    await mockDelay();
    throwIfChaos();
    final Visit saved = visit.copyWith(
      id: 'vst-${_uuid.v4().substring(0, 6)}',
      checkedInAt: DateTime.now(),
    );
    _visits.insert(0, saved);
    return saved;
  }

  @override
  Future<Visit> checkOut(String id, String outcome) async {
    await mockDelay();
    final int i = _visits.indexWhere((v) => v.id == id);
    if (i < 0) throw const MockApiException('Visit not found');
    final Visit updated = _visits[i].copyWith(
      checkedOutAt: DateTime.now(),
      outcome: outcome,
    );
    _visits[i] = updated;
    return updated;
  }

  @override
  Future<List<SalesTarget>> targets() async {
    await mockDelay();
    return const [
      SalesTarget(label: 'revenue', achieved: 42, target: 60),
      SalesTarget(label: 'customers', achieved: 6, target: 10),
      SalesTarget(label: 'trips', achieved: 96, target: 140),
    ];
  }
}
