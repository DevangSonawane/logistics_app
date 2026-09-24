import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Static fallback shown when no Maps key is present (or maps fail).
/// Never crashes; the caller renders the trip list beside it.
class MapPlaceholder extends StatelessWidget {
  const MapPlaceholder({super.key, required this.message, this.height = 220});

  final String message;
  final double height;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: tokens.surfaceAlt,
        borderRadius: AppSpacing.cardRadius,
        border: Border.all(color: tokens.border),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.map_outlined,
                size: AppSpacing.huge,
                color: tokens.inkFaint,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: tokens.inkMuted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
