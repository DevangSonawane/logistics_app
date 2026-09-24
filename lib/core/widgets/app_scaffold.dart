import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import 'offline_banner.dart';

/// Standard screen scaffold: optional app bar, offline banner under it,
/// padded body, optional bottom nav / FAB.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.showOfflineBanner = true,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.refresh,
  });

  final Widget body;
  final String? title;
  final List<Widget>? actions;
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
          : AppBar(title: Text(title!), actions: actions),
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
