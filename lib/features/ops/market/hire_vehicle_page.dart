import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/services/image_service.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/photo_capture_sheet.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../data/models/hire.dart';
import '../../../data/repositories/repository_providers.dart';
import '../application/ops_providers.dart';

/// P6. Market vehicles: broker master + KYC, entry to the hire memo.
class HireVehiclePage extends ConsumerStatefulWidget {
  const HireVehiclePage({super.key});

  @override
  ConsumerState<HireVehiclePage> createState() => _HireVehiclePageState();
}

class _HireVehiclePageState extends ConsumerState<HireVehiclePage> {
  final TextEditingController _vehicle = TextEditingController();
  final TextEditingController _owner = TextEditingController();
  final TextEditingController _pan = TextEditingController();
  final TextEditingController _driver = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final List<String> _kyc = [];
  String? _error;
  bool _working = false;

  @override
  void dispose() {
    _vehicle.dispose();
    _owner.dispose();
    _pan.dispose();
    _driver.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _addKyc() async {
    if (_kyc.length >= 3) return;
    final AppLocalizations l10n = AppLocalizations.of(context);
    final PhotoSource? source = await PhotoCaptureSheet.show(
      context,
      cameraLabel: l10n.photoCamera,
      galleryLabel: l10n.photoGallery,
    );
    if (source == null || !mounted) return;
    final String? path = await ref
        .read(imageServiceProvider)
        .capture(source: source, tag: 'kyc');
    if (!mounted || path == null) return;
    setState(() => _kyc.add(path));
  }

  Future<void> _continue() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (!Validators.isVehicleNoValid(_vehicle.text)) {
      setState(() => _error = l10n.vehicleNoError);
      return;
    }
    if (_owner.text.trim().isEmpty ||
        !Validators.isPhoneValid(_phone.text.trim()) ||
        _driver.text.trim().isEmpty) {
      setState(() => _error = l10n.fillAllFields);
      return;
    }
    if (_pan.text.trim().isNotEmpty &&
        !Validators.isPanValid(_pan.text.trim())) {
      setState(() => _error = l10n.panError);
      return;
    }
    setState(() {
      _error = null;
      _working = true;
    });
    try {
      final MarketVehicle saved = await ref
          .read(hireRepositoryProvider)
          .addVehicle(
            MarketVehicle(
              vehicleNo: _vehicle.text.trim().toUpperCase(),
              ownerName: _owner.text.trim(),
              pan: _pan.text.trim().isEmpty
                  ? null
                  : _pan.text.trim().toUpperCase(),
              driverName: _driver.text.trim(),
              driverPhone: _phone.text.trim(),
              kycPhotos: List.of(_kyc),
            ),
          );
      ref.invalidate(marketVehiclesProvider);
      if (!mounted) return;
      context.push('/ops/market/memo', extra: saved);
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = l10n.commonError);
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<MarketVehicle>> known =
        ref.watch(marketVehiclesProvider);
    return AppScaffold(
      title: l10n.marketTitle,
      body: ListView(
        children: [
          Text(
            l10n.knownVehicles,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          known.when(
            loading: () => const SkeletonList(itemCount: 2),
            error: (e, _) => ErrorState(message: l10n.commonError),
            data: (List<MarketVehicle> list) => Column(
              children: [
                for (final MarketVehicle v in list)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.local_shipping_outlined,
                    ),
                    title: Text(v.vehicleNo),
                    subtitle: Text(
                      '${v.ownerName} · ${v.driverName}',
                    ),
                  ),
              ],
            ),
          ),
          const Divider(height: AppSpacing.xxl),
          Text(
            l10n.addVehicleTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _vehicle,
            label: l10n.vehicleNoLabel,
            hint: 'MH 12 AB 1234',
            textCapitalization: TextCapitalization.characters,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _owner,
            label: l10n.ownerNameLabel,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _pan,
            label: l10n.panLabel,
            textCapitalization: TextCapitalization.characters,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _driver,
            label: l10n.driverNameLabel,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _phone,
            label: l10n.phoneLabel,
            keyboardType: TextInputType.phone,
            phonePrefix: true,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(child: Text(l10n.kycPhotos)),
              TextButton.icon(
                icon: const Icon(Icons.add_a_photo_outlined),
                label: Text(l10n.addAction),
                onPressed: _addKyc,
              ),
            ],
          ),
          Text(
            '${_kyc.length} / 3',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              _error!,
              style: const TextStyle(color: Colors.red),
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            label: l10n.permissionNext,
            variant: AppButtonVariant.accent,
            large: true,
            loading: _working,
            onPressed: _working ? null : _continue,
          ),
        ],
      ),
    );
  }
}
