import 'package:flutter/material.dart';

/// Spacing, radius and elevation tokens from Section 4.3.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 40;

  /// Screen padding: 16 on phones, 20 on tablets.
  static double screenPadding(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 600 ? 20 : 16;
  }

  static const double radiusChip = 999;
  static const double radiusButton = 16;
  static const double radiusCard = 20;
  static const double radiusSheet = 28;
  static const double radiusInput = 14;

  static const BorderRadius chipRadius =
      BorderRadius.all(Radius.circular(radiusChip));
  static const BorderRadius buttonRadius =
      BorderRadius.all(Radius.circular(radiusButton));
  static const BorderRadius cardRadius =
      BorderRadius.all(Radius.circular(radiusCard));
  static const BorderRadius inputRadius =
      BorderRadius.all(Radius.circular(radiusInput));
  static const BorderRadius sheetRadius = BorderRadius.vertical(
    top: Radius.circular(radiusSheet),
  );

  // Motion
  static const Duration motionFast = Duration(milliseconds: 200);
  static const Duration motionNormal = Duration(milliseconds: 300);
  static const Curve motionCurve = Curves.easeOutCubic;

  // Driver minimums
  static const double minTapTarget = 56;
  static const double driverButtonHeight = 64;
  static const double buttonHeightMd = 52;
}
