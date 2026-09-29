import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../core/widgets/status_chip.dart';
import '../../../data/models/driver.dart';
import '../../../data/models/vehicle.dart';
import '../../auth/application/session_provider.dart';
import '../application/driver_providers.dart';

/// D6. Documents: licence/RC/insurance/fitness/permit/PUC with expiry
/// countdown chips. Cached offline; tap opens a zoomable view.
class DriverDocumentsPage extends ConsumerWidget {
  const DriverDocumentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String? driverId = ref.watch(
      sessionProvider.select((s) => s.user?.id),
    );
    if (driverId == null) {
      return AppScaffold(body: ErrorState(message: l10n.commonError));
    }
    final AsyncValue<({Driver driver, List<VehicleDoc> docs})> docs = ref.watch(
      driverDocumentsProvider(driverId),
    );
    return docs.when(
      loading: () =>
          AppScaffold(title: l10n.documentsTitle, body: const SkeletonList()),
      error: (e, _) => AppScaffold(
        title: l10n.documentsTitle,
        body: ErrorState(
          message: l10n.commonError,
          onRetry: () => ref.invalidate(driverDocumentsProvider(driverId)),
        ),
      ),
      data: (data) {
        final int critical = data.docs
            .where(
              (d) =>
                  expiryBand(d.expiry, DateTime.now()) ==
                  DocExpiryBand.critical,
            )
            .length;
        final AppColorTokens tokens = context.tokens;
        return AppScaffold(
          padding: EdgeInsets.zero,
          body: Column(
            children: [
              Container(
                color: tokens.surface,
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.md,
                ),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.documentsTitle,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontSize: 22),
                      ),
                      if ((data.driver.vehicleReg ?? '').isNotEmpty)
                        Text(
                          data.driver.vehicleReg!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: tokens.primary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      if (critical > 0) ...[
                        const SizedBox(height: AppSpacing.sm),
                        _CriticalAlert(count: critical),
                      ],
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.lg,
                  ),
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: AppSpacing.sm,
                      crossAxisSpacing: AppSpacing.sm,
                      childAspectRatio: 0.92,
                    ),
                    itemCount: data.docs.length,
                    itemBuilder: (context, index) {
                      final VehicleDoc doc = data.docs[index];
                      final DocExpiryBand band = expiryBand(
                        doc.expiry,
                        DateTime.now(),
                      );
                      final (String label, Color color) =
                          switch (band) {
                        DocExpiryBand.ok => (
                          l10n.expiresInDays(
                            doc.expiry
                                .difference(DateTime.now())
                                .inDays,
                          ),
                          AppColors.success,
                        ),
                        DocExpiryBand.warning => (
                          l10n.expiresInDays(
                            doc.expiry
                                .difference(DateTime.now())
                                .inDays,
                          ),
                          AppColors.warning,
                        ),
                        DocExpiryBand.critical =>
                          doc.expiry.isBefore(DateTime.now())
                              ? (
                                  l10n.expiredLabel,
                                  AppColors.danger
                                )
                              : (
                                  l10n.expiresInDays(
                                    doc.expiry
                                        .difference(DateTime.now())
                                        .inDays,
                                  ),
                                  AppColors.danger,
                                ),
                      };
                      return _DocGridCard(
                        doc: doc,
                        typeLabel: _typeLabel(l10n, doc.type),
                        chipLabel: label,
                        chipColor: color,
                        onTap: () => _openDoc(context, doc),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

IconData _iconFor(VehicleDocType type) {
  return switch (type) {
    VehicleDocType.licence => Icons.badge_outlined,
    VehicleDocType.rc => Icons.directions_car_outlined,
    VehicleDocType.insurance => Icons.verified_user_outlined,
    VehicleDocType.fitness => Icons.fact_check_outlined,
    VehicleDocType.permit => Icons.assignment_outlined,
    VehicleDocType.puc => Icons.eco_outlined,
  };
}

String _typeLabel(AppLocalizations l10n, VehicleDocType type) {
  return switch (type) {
    VehicleDocType.licence => l10n.docLicence,
    VehicleDocType.rc => l10n.docRc,
    VehicleDocType.insurance => l10n.docInsurance,
    VehicleDocType.fitness => l10n.docFitness,
    VehicleDocType.permit => l10n.docPermit,
    VehicleDocType.puc => l10n.docPuc,
  };
}

  void _openDoc(BuildContext context, VehicleDoc doc) {
  final AppLocalizations l10n = AppLocalizations.of(context);
  final AppColorTokens tokens = context.tokens;
  showDialog<void>(
    context: context,
    builder: (context) => Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: AppSpacing.cardRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: tokens.primary.withValues(alpha: 0.1),
                  ),
                  child: Icon(
                    _iconFor(doc.type),
                    size: 20,
                    color: tokens.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    _typeLabel(l10n, doc.type),
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              height: 180,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: tokens.surfaceAlt,
                borderRadius: AppSpacing.inputRadius,
              ),
              child: doc.photoPath != null
                  ? ClipRRect(
                      borderRadius: AppSpacing.inputRadius,
                      child: InteractiveViewer(
                        child: Image.file(
                          File(doc.photoPath!),
                          errorBuilder: (_, _, _) =>
                              const Icon(
                            Icons.broken_image_outlined,
                            size: AppSpacing.huge,
                          ),
                        ),
                      ),
                    )
                  : const Icon(
                      Icons.description_outlined,
                      size: AppSpacing.huge,
                    ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              '${l10n.docNumberLabel}: ${doc.number}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              Formatters.date(doc.expiry),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: tokens.inkMuted),
            ),
            const SizedBox(height: AppSpacing.md),
            AppButton(
              label: l10n.closeAction,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Red alert card overlapping the header when documents are critical.
class _CriticalAlert extends StatelessWidget {
  const _CriticalAlert({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_outlined,
            color: AppColors.danger,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              '$count · ${l10n.expiredLabel}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
  }
}

/// Grid card: tinted icon bubble, semibold type, expiry chip, number.
class _DocGridCard extends StatelessWidget {
  const _DocGridCard({
    required this.doc,
    required this.typeLabel,
    required this.chipLabel,
    required this.chipColor,
    required this.onTap,
  });

  final VehicleDoc doc;
  final String typeLabel;
  final String chipLabel;
  final Color chipColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: tokens.surface,
          borderRadius: AppSpacing.cardRadius,
          border: Border.all(color: tokens.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: chipColor.withValues(alpha: 0.12),
              ),
              child: Icon(
                _iconFor(doc.type),
                size: 20,
                color: chipColor,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              typeLabel,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              doc.number,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: tokens.inkMuted,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.xs),
            StatusChip(label: chipLabel, color: chipColor),
          ],
        ),
      ),
    );
  }
}
