import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:roadops/core/utils/formatters.dart';

void main() {
  setUpAll(() => initializeDateFormatting('en_IN', null));
  test('INR uses Indian grouping', () {
    expect(Formatters.inr(1234567), '\u20B912,34,567');
    expect(Formatters.inr(840000), '\u20B98,40,000');
    expect(Formatters.inr(500), '\u20B9500');
  });

  test('INR short uses lakh and crore', () {
    expect(Formatters.inrShort(19600000), '\u20B92 Cr');
    expect(Formatters.inrShort(12000000), '\u20B91.2 Cr');
    expect(Formatters.inrShort(1240000), '\u20B912.4 L');
    expect(Formatters.inrShort(840000), '\u20B98.4 L');
    expect(Formatters.inrShort(500), '\u20B9500');
  });

  test('dates are dd MMM yyyy and times 12-hour', () {
    // en_IN abbreviates September as "Sept" - still the dd MMM yyyy pattern.
    expect(Formatters.date(DateTime(2026, 9, 24)), '24 Sept 2026');
    expect(Formatters.date(DateTime(2026, 3, 5)), '05 Mar 2026');
    expect(Formatters.time(DateTime(2026, 9, 24, 15, 30)), '03:30 PM');
    expect(
      Formatters.dateTime(DateTime(2026, 9, 24, 9, 5)),
      '24 Sept 2026, 09:05 AM',
    );
  });

  test('distance and duration read naturally', () {
    expect(Formatters.distanceKm(1180), '1180 km');
    expect(Formatters.distanceKm(12.5), '12.5 km');
    expect(
      Formatters.duration(const Duration(hours: 18, minutes: 20)),
      '18h 20m',
    );
    expect(Formatters.duration(const Duration(minutes: 45)), '45m');
  });
}
