import 'package:intl/intl.dart';

/// Indian-locale formatting helpers. All currency uses Indian digit
/// grouping (₹12,34,567); dates are dd MMM yyyy, times 12-hour.
abstract final class Formatters {
  static final NumberFormat _inr =
      NumberFormat.currency(locale: 'en_IN', symbol: '\u20B9', decimalDigits: 0);
  static final NumberFormat _inrExact =
      NumberFormat.currency(locale: 'en_IN', symbol: '\u20B9', decimalDigits: 2);
  static final DateFormat _date = DateFormat('dd MMM yyyy', 'en_IN');
  static final DateFormat _time = DateFormat('hh:mm a', 'en_IN');
  static final DateFormat _dateTime = DateFormat('dd MMM yyyy, hh:mm a', 'en_IN');

  /// Full Indian grouping: 1234567 -> ₹12,34,567.
  static String inr(num amount) => _inr.format(amount);

  /// With paise: 1234.5 -> ₹1,234.50.
  static String inrExact(num amount) => _inrExact.format(amount);

  /// Lakh/crore short form for KPIs: 1240000 -> ₹12.4 L, 12000000 -> ₹1.2 Cr.
  static String inrShort(num amount) {
    final double abs = amount.abs().toDouble();
    if (abs >= 10000000) {
      return '\u20B9${_trim(amount / 10000000)} Cr';
    }
    if (abs >= 100000) {
      return '\u20B9${_trim(amount / 100000)} L';
    }
    if (abs >= 1000) {
      return '\u20B9${_trim(amount / 1000)} K';
    }
    return inr(amount);
  }

  static String _trim(double value) {
    final String fixed = value.toStringAsFixed(1);
    return fixed.endsWith('.0')
        ? fixed.substring(0, fixed.length - 2)
        : fixed;
  }

  static String date(DateTime value) => _date.format(value);

  /// 12-hour with uppercase AM/PM (en_IN renders lowercase; normalized).
  static String time(DateTime value) => _ampm(_time.format(value));

  static String dateTime(DateTime value) => _ampm(_dateTime.format(value));

  static String _ampm(String value) {
    return value.replaceAll(' am', ' AM').replaceAll(' pm', ' PM');
  }

  static String distanceKm(double km) {
    if (km >= 100) return '${km.round()} km';
    return '${km.toStringAsFixed(1)} km';
  }

  static String duration(Duration value) {
    final int hours = value.inHours;
    final int minutes = value.inMinutes.remainder(60);
    if (hours <= 0) return '${minutes}m';
    return '${hours}h ${minutes}m';
  }
}
