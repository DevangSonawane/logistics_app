import 'package:flutter/material.dart';

/// Color tokens from Section 4 of the build prompt.
/// Widgets must use these (via [AppColorTokens] extension on ThemeData)
/// and never hard-code hex values.
abstract final class AppColors {
  // Brand
  static const Color primary = Color(0xFF5B5BF0);
  static const Color primaryDark = Color(0xFF3D3DD1);
  static const Color primaryContainer = Color(0xFFE8E8FF);
  static const Color accent = Color(0xFFC6F432);
  static const Color onAccent = Color(0xFF0B1020);
  static const Color secondary = Color(0xFF00C2A8);

  // Status
  static const Color success = Color(0xFF12B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFF43F5E);
  static const Color info = Color(0xFF3B82F6);
  static const Color podPending = Color(0xFFF97316);

  // Gradients
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF5B5BF0), Color(0xFF8E5BFF)],
  );
  static const LinearGradient darkHeroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0B1020), Color(0xFF1E1B4B)],
  );
  static const LinearGradient limeGlow = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFC6F432), Color(0xFF9BE21A)],
  );

  // Role accents (subtle tint on shell app-bar and avatar ring)
  static const Color driverAccent = Color(0xFFC6F432);
  static const Color ownerAccent = Color(0xFF8E5BFF);
  static const Color opsAccent = Color(0xFF5B5BF0);
  static const Color salesAccent = Color(0xFFFF7A59);
  static const Color supervisorAccent = Color(0xFF00C2A8);
  static const Color accountantAccent = Color(0xFF3B82F6);
}

/// Theme-dependent surface/ink tokens, exposed through ThemeData via
/// `Theme.of(context).tokens`. Light values are the defaults.
class AppColorTokens extends ThemeExtension<AppColorTokens> {
  const AppColorTokens({
    required this.background,
    required this.surface,
    required this.surfaceAlt,
    required this.ink,
    required this.inkMuted,
    required this.inkFaint,
    required this.border,
    required this.primary,
    required this.onPrimary,
    required this.cardShadow,
  });

  final Color background;
  final Color surface;
  final Color surfaceAlt;
  final Color ink;
  final Color inkMuted;
  final Color inkFaint;
  final Color border;
  final Color primary;
  final Color onPrimary;
  final List<BoxShadow> cardShadow;

  static const AppColorTokens light = AppColorTokens(
    background: Color(0xFFF6F7FB),
    surface: Color(0xFFFFFFFF),
    surfaceAlt: Color(0xFFEEF0F7),
    ink: Color(0xFF0B1020),
    inkMuted: Color(0xFF5A6180),
    inkFaint: Color(0xFF9AA0BC),
    border: Color(0xFFE3E6F0),
    primary: AppColors.primary,
    onPrimary: Colors.white,
    cardShadow: [
      BoxShadow(
        color: Color(0x0F0B1020),
        blurRadius: 24,
        offset: Offset(0, 8),
      ),
    ],
  );

  static const AppColorTokens dark = AppColorTokens(
    background: Color(0xFF0B1020),
    surface: Color(0xFF141A33),
    surfaceAlt: Color(0xFF1C2444),
    ink: Color(0xFFF4F6FF),
    inkMuted: Color(0xFFA5ACCB),
    inkFaint: Color(0xFF6B7394),
    border: Color(0xFF2A3358),
    primary: Color(0xFF8080FF),
    onPrimary: Color(0xFF0B1020),
    cardShadow: [],
  );

  @override
  AppColorTokens copyWith({
    Color? background,
    Color? surface,
    Color? surfaceAlt,
    Color? ink,
    Color? inkMuted,
    Color? inkFaint,
    Color? border,
    Color? primary,
    Color? onPrimary,
    List<BoxShadow>? cardShadow,
  }) {
    return AppColorTokens(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceAlt: surfaceAlt ?? this.surfaceAlt,
      ink: ink ?? this.ink,
      inkMuted: inkMuted ?? this.inkMuted,
      inkFaint: inkFaint ?? this.inkFaint,
      border: border ?? this.border,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      cardShadow: cardShadow ?? this.cardShadow,
    );
  }

  @override
  AppColorTokens lerp(ThemeExtension<AppColorTokens>? other, double t) {
    if (other is! AppColorTokens) return this;
    return AppColorTokens(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceAlt: Color.lerp(surfaceAlt, other.surfaceAlt, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      inkMuted: Color.lerp(inkMuted, other.inkMuted, t)!,
      inkFaint: Color.lerp(inkFaint, other.inkFaint, t)!,
      border: Color.lerp(border, other.border, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      cardShadow: t < 0.5 ? cardShadow : other.cardShadow,
    );
  }
}

/// Shortcut to reach theme tokens from a [BuildContext].
extension TokensContextX on BuildContext {
  AppColorTokens get tokens =>
      Theme.of(this).extension<AppColorTokens>() ?? AppColorTokens.light;
}
