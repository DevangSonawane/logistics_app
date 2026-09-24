import 'package:flutter_test/flutter_test.dart';
import 'package:roadops/features/ops/orders/create_order_page.dart';
import 'package:roadops/features/ops/planning/plan_trip_page.dart';

/// NOTE: not executed yet - full test pass happens at the end (user call).
void main() {
  group('whatsapp indent parse', () {
    test('parses the canonical message', () {
      final parsed = parseWhatsappMessage(
        '2 trucks 32 ft Pune to Chennai tomorrow',
      );
      expect(parsed.cargo, '2 truck load');
      expect(parsed.vehicle, '32 ft MXL');
      expect(parsed.from, 'Pune');
      expect(parsed.to, 'Chennai');
      expect(parsed.dateOffsetDays, 1);
    });

    test('handles partial messages', () {
      final parsed = parseWhatsappMessage('need 1 trailer today');
      expect(parsed.cargo, '1 truck load');
      expect(parsed.vehicle, 'Trailer');
      expect(parsed.from, isNull);
      expect(parsed.dateOffsetDays, 0);
    });

    test('empty message yields nothing', () {
      final parsed = parseWhatsappMessage('hello');
      expect(parsed.cargo, isNull);
      expect(parsed.vehicle, isNull);
      expect(parsed.from, isNull);
      expect(parsed.dateOffsetDays, isNull);
    });
  });

  group('haversine road estimate', () {
    test('pune-chennai lands near the 1180 km lane', () {
      final double km = haversineRoadKm(18.5204, 73.8567, 13.0827, 80.2707);
      expect(km, inInclusiveRange(1000, 1350));
    });

    test('mumbai-delhi lands near the 1420 km lane', () {
      final double km = haversineRoadKm(19.076, 72.8777, 28.6139, 77.209);
      expect(km, inInclusiveRange(1250, 1650));
    });

    test('same point is zero', () {
      expect(haversineRoadKm(18.5, 73.8, 18.5, 73.8), 0);
    });
  });
}
