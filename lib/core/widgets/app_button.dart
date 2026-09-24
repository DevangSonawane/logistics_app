import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Button variants from the design system.
enum AppButtonVariant { primary, accent, secondary, danger, text }

/// Single button component. Sizes: md 52 dp, lg 64 dp (driver).
/// Accent (neon lime) marks the single most important action per screen.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.large = false,
    this.loading = false,
    this.icon,
    this.expanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool large;
  final bool loading;
  final IconData? icon;
  final bool expanded;

  double get _height =>
      large ? AppSpacing.driverButtonHeight : AppSpacing.buttonHeightMd;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    final VoidCallback? action = loading ? null : onPressed;
    final Widget content = loading
        ? SizedBox(
            width: AppSpacing.xl,
            height: AppSpacing.xl,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: _foreground(tokens),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: AppSpacing.xl),
                const SizedBox(width: AppSpacing.sm),
              ],
              Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
            ],
          );

    final ButtonStyle style = switch (variant) {
      AppButtonVariant.primary => ElevatedButton.styleFrom(
          backgroundColor: tokens.primary,
          foregroundColor: tokens.onPrimary,
          minimumSize: Size(AppSpacing.minTapTarget, _height),
        ),
      AppButtonVariant.accent => ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.onAccent,
          minimumSize: Size(AppSpacing.minTapTarget, _height),
        ),
      AppButtonVariant.danger => ElevatedButton.styleFrom(
          backgroundColor: AppColors.danger,
          foregroundColor: Colors.white,
          minimumSize: Size(AppSpacing.minTapTarget, _height),
        ),
      AppButtonVariant.secondary => OutlinedButton.styleFrom(
          foregroundColor: tokens.ink,
          side: BorderSide(color: tokens.border),
          minimumSize: Size(AppSpacing.minTapTarget, _height),
        ),
      AppButtonVariant.text => TextButton.styleFrom(
          foregroundColor: tokens.primary,
          minimumSize: Size(AppSpacing.minTapTarget, _height),
        ),
    };

    final Widget button = switch (variant) {
      AppButtonVariant.secondary => OutlinedButton(
          onPressed: action,
          style: style,
          child: content,
        ),
      AppButtonVariant.text => TextButton(
          onPressed: action,
          style: style,
          child: content,
        ),
      _ => ElevatedButton(
          onPressed: action,
          style: style,
          child: content,
        ),
    };

    if (!expanded) return button;
    return SizedBox(width: double.infinity, child: button);
  }

  Color _foreground(AppColorTokens tokens) {
    return switch (variant) {
      AppButtonVariant.accent => AppColors.onAccent,
      AppButtonVariant.secondary || AppButtonVariant.text => tokens.primary,
      AppButtonVariant.danger => Colors.white,
      _ => tokens.onPrimary,
    };
  }
}
