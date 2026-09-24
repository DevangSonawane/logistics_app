import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
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
    final AsyncValue<({Driver driver, List<VehicleDoc> docs})> docs =
        ref.watch(driverDocumentsProvider(driverId));
    return AppScaffold(
      title: l10n.documentsTitle,
      body: docs.when(
        loading: () => const SkeletonList(),
        error: (e, _) => ErrorState(
          message: l10n.commonError,
          onRetry: () => ref.invalidate(driverDocumentsProvider(driverId)),
        ),
        data: (data) => ListView.separated(
          itemCount: data.docs.length,
          separatorBuilder: (_, __) =>
              const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, index) {
            final VehicleDoc doc = data.docs[index];
            final DocExpiryBand band =
                expiryBand(doc.expiry, DateTime.now());
            final (String label, Color color) = switch (band) {
              DocExpiryBand.ok => (
                  l10n.expiresInDays(doc.expiry.difference(DateTime.now()).inDays),
                  AppColors.success
                ),
              DocExpiryBand.warning =>
                (l10n.expiresInDays(doc.expiry.difference(DateTime.now()).inDays),
                    AppColors.warning),
              DocExpiryBand.critical => doc.expiry.isBefore(DateTime.now())
                  ? (l10n.expiredLabel, AppColors.danger)
                  : (
                      l10n.expiresInDays(
                        doc.expiry.difference(DateTime.now()).inDays,
                      ),
                      AppColors.danger
                    ),
            };
            return AppCard(
              onTap: () => _openDoc(context, doc),
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Icon(
                    _iconFor(doc.type),
                    size: AppSpacing.xxxl,
                    color: context.tokens.inkMuted,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _typeLabel(l10n, doc.type),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          '${l10n.docNumberLabel}: ${doc.number}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: context.tokens.inkMuted),
                        ),
                        Text(
                          Formatters.date(doc.expiry),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: context.tokens.inkMuted),
                        ),
                      ],
                    ),
                  ),
                  StatusChip(label: label, color: color),
                ],
              ),
            );
          },
        ),
      ),
    );
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
    showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _typeLabel(l10n, doc.type),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.md),
              if (doc.photoPath != null)
                InteractiveViewer(
                  child: Image.file(
                    File(doc.photoPath!),
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.broken_image_outlined,
                      size: AppSpacing.huge,
                    ),
                  ),
                )
              else
                const Icon(
                  Icons.description_outlined,
                  size: AppSpacing.huge,
                ),
              const SizedBox(height: AppSpacing.md),
              Text('${l10n.docNumberLabel}: ${doc.number}'),
              Text(Formatters.date(doc.expiry)),
            ],
          ),
        ),
      ),
    );
  }
}
