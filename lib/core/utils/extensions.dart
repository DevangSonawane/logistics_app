import 'package:flutter/material.dart';

/// Common BuildContext / type helpers.
extension StringX on String {
  /// First letter upper-cased, rest unchanged.
  String get capitalized {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension DateTimeX on DateTime {
  /// True when both instants fall on the same calendar day.
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension MediaQueryX on BuildContext {
  /// Phone (360x640) through tablet layouts.
  bool get isTablet => MediaQuery.sizeOf(this).width >= 600;
}

extension StatusColorX on Color {
  /// Tinted pill background: status color at 12% over the surface.
  Color get pillBackground => withValues(alpha: 0.12);
}
