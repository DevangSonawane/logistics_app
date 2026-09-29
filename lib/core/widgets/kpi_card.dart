import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// KPI card (soft embossed style): tinted icon bubble + label + optional
/// progress percent, big numeral, bottom range bar / sparkline / delta.
///
/// Numbers are pre-formatted by the caller (Formatters.inrShort).
class KpiCard extends StatelessWidget {
  const KpiCard({
    super.key,
    required this.label,
    required this.value,
    this.delta,
    this.deltaUp,
    this.icon,
    this.iconTint,
    this.sparkline,
    this.fraction,
    this.progressLabel,
    this.onTap,
  });

  final String label;
  final String value;
  final String? delta;
  final bool? deltaUp;
  final IconData? icon;
  final Color? iconTint;
  final List<double>? sparkline;

  /// 0..1 fill of the bottom range bar (e.g. utilisation, relative scale).
  final double? fraction;

  /// Percent text beside the label (e.g. "78%"). Shown only when given.
  final String? progressLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    final Color tint = iconTint ?? tokens.primary;
    final Widget card = Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: tokens.surfaceAlt,
        borderRadius: AppSpacing.cardRadius,
        boxShadow: [
          const BoxShadow(
            color: Colors.white,
            blurRadius: 12,
            offset: Offset(-6, -6),
          ),
          BoxShadow(
            color: tokens.inkFaint.withValues(alpha: 0.45),
            blurRadius: 12,
            offset: const Offset(6, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (icon != null)
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: tint,
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.white,
                        blurRadius: 4,
                        offset: Offset(-2, -2),
                      ),
                      BoxShadow(
                        color: tint.withValues(alpha: 0.5),
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Icon(icon, color: Colors.white, size: 18),
                ),
              if (icon != null) const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: tokens.inkMuted,
                        height: 1.2,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (progressLabel != null) ...[
                const SizedBox(width: AppSpacing.xs),
                Text(
                  progressLabel!,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: AppTypography.kpiNumber(tokens.ink).copyWith(fontSize: 24),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (fraction != null) ...[
            const SizedBox(height: AppSpacing.sm),
            _RangeBar(fraction: fraction!.clamp(0.0, 1.0), tint: tint),
          ] else if (sparkline != null) ...[
            const SizedBox(height: AppSpacing.sm),
            _Sparkline(values: sparkline!, color: tint),
          ] else if (delta != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: (deltaUp ?? true
                        ? AppColors.success
                        : AppColors.danger)
                    .withValues(alpha: 0.12),
                borderRadius: AppSpacing.chipRadius,
              ),
              child: Text(
                delta!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: deltaUp ?? true
                          ? AppColors.success
                          : AppColors.danger,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ],
      ),
    );
    if (onTap == null) return card;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppSpacing.cardRadius,
        onTap: onTap,
        child: card,
      ),
    );
  }
}

/// Embossed track with a solid tinted fill.
class _RangeBar extends StatelessWidget {
  const _RangeBar({required this.fraction, required this.tint});

  final double fraction;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: context.tokens.surface,
        borderRadius: AppSpacing.chipRadius,
        boxShadow: [
          BoxShadow(
            color: context.tokens.inkFaint.withValues(alpha: 0.35),
            blurRadius: 3,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: fraction,
        child: Container(
          decoration: BoxDecoration(
            color: tint,
            borderRadius: AppSpacing.chipRadius,
          ),
        ),
      ),
    );
  }
}

class _Sparkline extends StatelessWidget {
  const _Sparkline({required this.values, required this.color});

  final List<double> values;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (values.length < 2) return const SizedBox.shrink();
    final List<FlSpot> spots = [
      for (int i = 0; i < values.length; i++)
        FlSpot(i.toDouble(), values[i]),
    ];
    return SizedBox(
      height: AppSpacing.xxxl,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: color,
              barWidth: 2,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: color.withValues(alpha: 0.15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
