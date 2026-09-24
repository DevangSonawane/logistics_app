import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../network/connectivity_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// "You're offline..." strip rendered under the app bar when connectivity
/// is lost. Driver actions keep working; they queue automatically.
class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool online = ref.watch(isOnlineProvider);
    if (online) return const SizedBox.shrink();
    final AppColorTokens tokens = context.tokens;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      color: AppColors.warning.withValues(alpha: 0.15),
      child: Row(
        children: [
          const Icon(
            Icons.wifi_off,
            size: AppSpacing.lg,
            color: AppColors.warning,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              AppLocalizations.of(context).offlineMessage,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: tokens.ink),
            ),
          ),
        ],
      ),
    );
  }
}
