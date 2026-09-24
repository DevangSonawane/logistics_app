import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography scale from Section 4.2 of the build prompt.
///
/// Headings/numerals: Plus Jakarta Sans. Body: Inter.
/// TODO(Phase 8): bundle PlusJakartaSans + Noto Sans Indic files under
/// assets/fonts for offline-safe driver usage instead of runtime fetch.
abstract final class AppTypography {
  static const double display = 32;
  static const double h1 = 24;
  static const double h2 = 20;
  static const double h3 = 18;
  static const double body = 15;
  static const double caption = 12;
  static const double kpi = 28;
  static const double driverButton = 20;

  /// Builds the Material text theme. [scale] lets driver mode multiply
  /// body sizes by 1.15 (see driver_theme.dart).
  static TextTheme textTheme({double scale = 1.0}) {
    final TextStyle heading = GoogleFonts.plusJakartaSans();
    final TextStyle content = GoogleFonts.inter();
    return TextTheme(
      displayLarge: heading.copyWith(
        fontSize: display * scale,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
      ),
      headlineLarge: heading.copyWith(
        fontSize: h1 * scale,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: heading.copyWith(
        fontSize: h2 * scale,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: heading.copyWith(
        fontSize: h3 * scale,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: content.copyWith(
        fontSize: body * scale,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: content.copyWith(
        fontSize: body * scale,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: content.copyWith(
        fontSize: caption * scale,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: heading.copyWith(
        fontSize: driverButton,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  /// KPI numerals with tabular figures for stable count-up animation.
  static TextStyle kpiNumber(Color color) {
    return GoogleFonts.plusJakartaSans(
      fontSize: kpi,
      fontWeight: FontWeight.w800,
      color: color,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }
}
