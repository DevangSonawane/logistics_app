import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/services/share_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../data/models/hire.dart';
import '../../../data/repositories/repository_providers.dart';
import '../../auth/application/session_provider.dart';

/// Hire memo: freight agreed, advance, balance on POD, deductions.
/// Paying an above-limit advance raises an approval instead.
class HireMemoPage extends ConsumerStatefulWidget {
  const HireMemoPage({super.key, required this.vehicle});

  final MarketVehicle vehicle;

  @override
  ConsumerState<HireMemoPage> createState() => _HireMemoPageState();
}

class _HireMemoPageState extends ConsumerState<HireMemoPage> {
  final TextEditingController _freight = TextEditingController();
  final TextEditingController _advance = TextEditingController();
  final TextEditingController _deductions = TextEditingController();
  bool _working = false;
  bool _saved = false;

  @override
  void dispose() {
    _freight.dispose();
    _advance.dispose();
    _deductions.dispose();
    super.dispose();
  }

  int get _freightV => int.tryParse(_freight.text.trim()) ?? 0;
  int get _advanceV => int.tryParse(_advance.text.trim()) ?? 0;
  int get _deductionsV => int.tryParse(_deductions.text.trim()) ?? 0;
  int get _balance => _freightV - _advanceV - _deductionsV;

  Future<void> _payAdvance() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (_freightV <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.fillAllFields)),
      );
      return;
    }
    setState(() => _working = true);
    final String requester =
        ref.read(sessionProvider).user?.name ?? 'Ops';
    try {
      final HireMemo memo = await ref
          .read(hireRepositoryProvider)
          .createMemo(
            HireMemo(
              id: 'local',
              vehicleNo: widget.vehicle.vehicleNo,
              ownerName: widget.vehicle.ownerName,
              pan: widget.vehicle.pan,
              driverName: widget.vehicle.driverName,
              driverPhone: widget.vehicle.driverPhone,
              freight: _freightV,
              advance: _advanceV,
              deductions: _deductionsV,
              createdAt: DateTime.now(),
            ),
          );
      final ({bool paid, bool needsApproval}) result = await ref
          .read(hireRepositoryProvider)
          .payAdvance(memo, requester: requester);
      if (!mounted) return;
      setState(() {
        _working = false;
        _saved = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result.paid ? l10n.paidMsg : l10n.approvalRaised,
          ),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _working = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.commonError)),
      );
    }
  }

  Future<void> _shareMemo() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    await ShareService().sharePdf(
      '${l10n.memoTitle} ${widget.vehicle.vehicleNo}',
      [
        (l10n.ownerNameLabel, widget.vehicle.ownerName),
        (l10n.driverNameLabel,
            '${widget.vehicle.driverName} ${widget.vehicle.driverPhone}'),
        (l10n.freightAgreed, Formatters.inr(_freightV)),
        (l10n.advanceOptional, Formatters.inr(_advanceV)),
        (l10n.deductionsLabel, Formatters.inr(_deductionsV)),
        (l10n.balanceOnPod, Formatters.inr(_balance)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppScaffold(
      title: l10n.memoTitle,
      body: ListView(
        children: [
          Text(
            '${widget.vehicle.vehicleNo} · ${widget.vehicle.ownerName}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            controller: _freight,
            label: l10n.freightAgreed,
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _advance,
            label: l10n.advanceOptional,
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _deductions,
            label: l10n.deductionsLabel,
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.12),
              borderRadius: AppSpacing.cardRadius,
            ),
            child: Row(
              children: [
                Expanded(child: Text(l10n.balanceOnPod)),
                Text(
                  Formatters.inr(_balance),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            label: l10n.payAdvanceAction,
            variant: AppButtonVariant.accent,
            large: true,
            loading: _working,
            onPressed: _working ? null : _payAdvance,
          ),
          if (_saved) ...[
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              label: l10n.sharePdf,
              variant: AppButtonVariant.secondary,
              icon: Icons.share_outlined,
              onPressed: _shareMemo,
            ),
          ],
        ],
      ),
    );
  }
}
