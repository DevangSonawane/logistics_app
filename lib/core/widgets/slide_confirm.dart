import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Slide-to-confirm for critical driver status changes
/// (Reached / Started / Delivered) to prevent accidental taps.
/// Renders at least 64 dp tall in driver mode.
class SlideConfirm extends StatelessWidget {
  const SlideConfirm({
    super.key,
    required this.label,
    required this.onConfirm,
    this.icon = Icons.arrow_forward,
    this.enabled = true,
  });

  final String label;
  final Future<void> Function() onConfirm;
  final IconData icon;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: SlideAction(
        text: label,
        outerColor: AppColors.accent,
        innerColor: AppColors.onAccent,
        sliderButtonIcon: Icon(icon, color: AppColors.accent),
        height: AppSpacing.driverButtonHeight,
        textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.onAccent,
            ),
        onSubmit: enabled ? () async => onConfirm() : () async {},
      ),
    );
  }
}
