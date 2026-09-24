import 'package:flutter/material.dart';

import '../theme/app_typography.dart';
import '../utils/formatters.dart';

/// Amount in Indian grouping (₹1,23,456). Use [short] for KPI-style
/// lakh/crore (₹12.4 L) and [exact] for paise precision.
class AmountText extends StatelessWidget {
  const AmountText(
    this.amount, {
    super.key,
    this.short = false,
    this.exact = false,
    this.style,
  });

  final num amount;
  final bool short;
  final bool exact;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final String text = short
        ? Formatters.inrShort(amount)
        : exact
            ? Formatters.inrExact(amount)
            : Formatters.inr(amount);
    return Text(
      text,
      style: style ??
          AppTypography.kpiNumber(Theme.of(context).colorScheme.onSurface),
    );
  }
}
