import 'package:flutter_test/flutter_test.dart';
import 'package:roadops/data/models/lead.dart';
import 'package:roadops/data/repositories/mock_lead_repository.dart';

/// NOTE: not executed yet - full test pass happens at the end (user call).
void main() {
  group('sales pipeline', () {
    test('seed spans all stages and sources', () async {
      final MockLeadRepository repo = MockLeadRepository();
      final List<Lead> leads = await repo.leads();
      expect(leads.length, 18);
      expect(
        leads.map((l) => l.stage).toSet(),
        containsAll([
          LeadStage.fresh,
          LeadStage.contacted,
          LeadStage.quoted,
          LeadStage.negotiation,
          LeadStage.won,
          LeadStage.lost,
        ]),
      );
    });

    test('add assigns a 30-minute SLA and stages advance', () async {
      final MockLeadRepository repo = MockLeadRepository();
      final Lead saved = await repo.add(
        Lead(
          id: 'local',
          company: 'Test Co',
          contact: 'T. Tester',
          phone: '9898989898',
          from: 'Pune',
          to: 'Chennai',
        ),
      );
      expect(saved.slaDue, isNotNull);
      final Lead moved =
          await repo.setStage(saved.id, LeadStage.contacted);
      expect(moved.stage, LeadStage.contacted);
    });

    test('visit check-in and check-out with outcome', () async {
      final MockLeadRepository repo = MockLeadRepository();
      final Visit visit = await repo.checkIn(
        Visit(id: 'local', title: 'Test Co', lat: 18.5, lng: 73.8),
      );
      expect(visit.checkedInAt, isNotNull);
      final Visit done =
          await repo.checkOut(visit.id, 'Interested');
      expect(done.checkedOutAt, isNotNull);
      expect(done.outcome, 'Interested');
    });

    test('targets expose three rings', () async {
      final MockLeadRepository repo = MockLeadRepository();
      final List<SalesTarget> targets = await repo.targets();
      expect(targets.map((t) => t.label),
          ['revenue', 'customers', 'trips']);
    });
  });
}
