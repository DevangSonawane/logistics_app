import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_theme.dart';
import 'app_typography.dart';

/// Oversized driver variant: body sizes x1.15, taller buttons, larger
/// tap targets. Applied only to the driver role shell (Phase 3).
abstract final class DriverTheme {
  static const double textScale = 1.15;

  static ThemeData themed(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    final AppColorTokens tokens =
        brightness == Brightness.dark ? AppColorTokens.dark : AppColorTokens.light;
    final ThemeData base =
        brightness == Brightness.dark ? AppTheme.dark : AppTheme.light;
    return base.copyWith(
      textTheme: AppTypography.textTheme(scale: textScale),
      extensions: [tokens],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(
            AppSpacing.minTapTarget,
            AppSpacing.driverButtonHeight,
          ),
          textStyle: AppTypography.textTheme().labelLarge,
        ),
      ),
      iconTheme: base.iconTheme.copyWith(size: 28),
    );
  }
}
