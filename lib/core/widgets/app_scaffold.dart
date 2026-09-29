import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import 'app_app_bar.dart';
import 'offline_banner.dart';

/// Standard screen scaffold: custom road bar, offline banner under it,
/// padded body, optional bottom nav / FAB.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.accent = AppColors.primary,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.showOfflineBanner = true,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.refresh,
  });

  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final Color accent;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool showOfflineBanner;
  final EdgeInsetsGeometry padding;
  final RefreshCallback? refresh;

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(padding: padding, child: body);
    if (refresh != null) {
      content = RefreshIndicator(onRefresh: refresh!, child: content);
    }
    return Scaffold(
      appBar: title == null
          ? null
          : RoadAppBar(
              title: title!,
              actions: actions ?? const [],
              accent: accent,
            ),
      body: Column(
        children: [
          if (showOfflineBanner) const OfflineBanner(),
          Expanded(child: content),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
