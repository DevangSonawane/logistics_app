import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'app_card.dart';

/// KPI card: label, animated big number, delta chip, mini sparkline,
/// tinted icon bubble. Numbers are pre-formatted by the caller
/// (Formatters.inrShort for KPIs).
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
    this.onTap,
  });

  final String label;
  final String value;
  final String? delta;
  final bool? deltaUp;
  final IconData? icon;
  final Color? iconTint;
  final List<double>? sparkline;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    final Color tint = iconTint ?? tokens.primary;
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: tint.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppSpacing.md),
                  ),
                  child: Icon(icon, color: tint, size: AppSpacing.xl),
                ),
              if (icon != null) const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: tokens.inkMuted),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(value, style: AppTypography.kpiNumber(tokens.ink)),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              if (delta != null)
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
              if (delta != null && sparkline != null)
                const SizedBox(width: AppSpacing.sm),
              if (sparkline != null)
                Expanded(child: _Sparkline(values: sparkline!, color: tint)),
            ],
          ),
        ],
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
