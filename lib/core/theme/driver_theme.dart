import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_theme.dart';
import 'app_typography.dart';

/// Driver variant: same type scale as staff (users asked for a
/// compact, non-zoomed look), taller buttons and larger tap targets.
/// Applied only to the driver role shell. Drivers who want bigger
/// text can raise it in Profile -> text size.
abstract final class DriverTheme {
  static const double textScale = 1.0;

  static ThemeData themed(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    final AppColorTokens tokens =
        brightness == Brightness.dark ? AppColorTokens.dark : AppColorTokens.light;
    final ThemeData base =
        brightness == Brightness.dark ? AppTheme.dark : AppTheme.light;
    return base.copyWith(
      textTheme:
          AppTypography.textTheme(scale: textScale, color: tokens.ink),
      extensions: [tokens],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(
            AppSpacing.minTapTarget,
            AppSpacing.driverButtonHeight,
          ),
          textStyle: AppTypography.textTheme(color: tokens.ink).labelLarge,
        ),
      ),
      iconTheme: base.iconTheme.copyWith(size: 24),
    );
  }
}
