import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Gradient header with an overlapping card (Rule 3: break the grid).
/// The [overlap] child bleeds over the header's bottom edge; content below
/// starts with negative spacing handled internally.
class OverlapHeader extends StatelessWidget {
  const OverlapHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing = const SizedBox.shrink(),
    this.gradient = AppColors.heroGradient,
    this.foreground = Colors.white,
    this.overlap,
    this.heroValue,
    this.heroLabel,
  });

  final String title;
  final String? subtitle;
  final Widget trailing;

  /// Hero gradient override per role surface.
  final LinearGradient gradient;

  /// Text/icon color drawn on the gradient. Defaults to white for the
  /// saturated purple heroes; pass ink for the near-white headers.
  final Color foreground;

  /// Card overlapping the header's bottom edge (the screen's focal point).
  final Widget? overlap;

  /// Oversized display value rendered in the gradient (Rule 2 + 4).
  final String? heroValue;
  final String? heroLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(color: foreground),
                        ),
                        if (subtitle != null)
                          Text(
                            subtitle!,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: foreground.withValues(alpha: 0.7),
                                ),
                          ),
                      ],
                    ),
                  ),
                  trailing,
                ],
              ),
              if (heroValue != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  heroValue!,
                  style: AppTypography.kpiNumber(
                    foreground,
                  ).copyWith(fontSize: 40),
                ),
                if (heroLabel != null)
                  Text(
                    heroLabel!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                          color: foreground.withValues(alpha: 0.7),
                        ),
                  ),
              ],
              SizedBox(
                height: overlap == null ? AppSpacing.xl : AppSpacing.xxxl,
              ),
              if (overlap != null)
                Transform.translate(
                  offset: const Offset(0, AppSpacing.xxxl),
                  child: overlap!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
