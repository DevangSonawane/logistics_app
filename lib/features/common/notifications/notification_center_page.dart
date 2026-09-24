import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../data/models/app_user.dart';
import '../../../data/models/notification.dart';
import '../../../data/repositories/repository_providers.dart';
import '../../owner/application/owner_providers.dart';
import '../../auth/application/session_provider.dart';

/// Notification centre: Today / Earlier groups, unread dots, type icons,
/// deep-link navigation on tap, mark-all-read.
class NotificationCenterPage extends ConsumerWidget {
  const NotificationCenterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<AppNotification>> feed =
        ref.watch(notificationsProvider);
    return AppScaffold(
      title: l10n.centreTitle,
      actions: [
        TextButton(
          onPressed: () async {
            await ref
                .read(notificationRepositoryProvider)
                .markAllRead();
            ref.invalidate(notificationsProvider);
            ref.invalidate(unreadNotificationsCountProvider);
          },
          child: Text(l10n.markAllRead),
        ),
      ],
      refresh: () async {
        ref.invalidate(notificationsProvider);
      },
      body: feed.when(
        loading: () => const SkeletonList(),
        error: (e, _) => ErrorState(
          message: l10n.commonError,
          onRetry: () => ref.invalidate(notificationsProvider),
        ),
        data: (List<AppNotification> items) {
          if (items.isEmpty) {
            return EmptyState(
              title: l10n.noNotifications,
              message: '',
              icon: Icons.notifications_outlined,
            );
          }
          final DateTime now = DateTime.now();
          final List<AppNotification> today = items
              .where((n) => n.at.isSameDay(now))
              .toList();
          final List<AppNotification> earlier = items
              .where((n) => !n.at.isSameDay(now))
              .toList();
          return ListView(
            children: [
              if (today.isNotEmpty) ...[
                _GroupHeader(title: l10n.todayGroup),
                for (final AppNotification n in today)
                  _Tile(notification: n),
              ],
              if (earlier.isNotEmpty) ...[
                _GroupHeader(title: l10n.earlierGroup),
                for (final AppNotification n in earlier)
                  _Tile(notification: n),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _GroupHeader extends StatelessWidget {
  const _GroupHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}

class _Tile extends ConsumerWidget {
  const _Tile({required this.notification});

  final AppNotification notification;

  IconData get _icon {
    return switch (notification.type) {
      'sos' => Icons.sos_outlined,
      'approval' => Icons.approval_outlined,
      'payment' => Icons.payments_outlined,
      'delay' => Icons.schedule_outlined,
      'pod' => Icons.receipt_long_outlined,
      'doc' => Icons.description_outlined,
      'eway' => Icons.receipt_outlined,
      'lead' => Icons.person_add_outlined,
      'invoice' => Icons.request_quote_outlined,
      'credit' => Icons.credit_card_outlined,
      'brief' => Icons.wb_sunny_outlined,
      'trip' => Icons.local_shipping_outlined,
      _ => Icons.notifications_outlined,
    };
  }

  Future<void> _open(BuildContext context, WidgetRef ref) async {
    if (!notification.read) {
      await ref
          .read(notificationRepositoryProvider)
          .markRead(notification.id);
      ref.invalidate(notificationsProvider);
      ref.invalidate(unreadNotificationsCountProvider);
    }
    if (!context.mounted) return;
    openDeeplink(context, ref, notification.deeplink);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: context.tokens.surface,
          borderRadius: AppSpacing.cardRadius,
          border: Border.all(color: context.tokens.border),
        ),
        child: InkWell(
          onTap: () => _open(context, ref),
          child: Row(
            children: [
              Icon(_icon, color: context.tokens.inkMuted),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium,
                          ),
                        ),
                        if (!notification.read)
                          Container(
                            width: AppSpacing.sm,
                            height: AppSpacing.sm,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                            ),
                          ),
                      ],
                    ),
                    Text(
                      notification.body,
                      style:
                          Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      Formatters.dateTime(notification.at),
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: context.tokens.inkFaint,
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Routes a roadops:// deep link role-aware; the guard stays the backstop.
void openDeeplink(BuildContext context, WidgetRef ref, String? link) {
  if (link == null || link.isEmpty) return;
  final Uri? uri = Uri.tryParse(link);
  if (uri == null) return;
  final List<String> seg = uri.pathSegments;
  if (seg.length < 2) return;
  final AppRole? role =
      ref.read(sessionProvider).activeRole;
  switch (seg[0]) {
    case 'trip':
      if (role == AppRole.driver) {
        context.push(RouteNames.driverHome);
      } else if (role == AppRole.ops) {
        context.push('${RouteNames.opsTrips}/${seg[1]}');
      } else if (role == AppRole.owner) {
        context.push(RouteNames.ownerMap);
      }
    case 'approval':
      if (role == AppRole.owner) {
        context.push(RouteNames.ownerApprovals);
      } else if (role == AppRole.accountant) {
        context.push('/accountant/approvals');
      }
    case 'lead':
      if (role == AppRole.sales) {
        context.push('/sales/leads/${seg[1]}');
      }
    case 'invoice':
      if (role == AppRole.accountant) {
        context.push('/accountant/invoices/${seg[1]}');
      }
  }
}

extension _SameDay on DateTime {
  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}
