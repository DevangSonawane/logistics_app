import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/error_state.dart';
import '../../../data/mock/mock_business_data.dart';
import '../application/sales_providers.dart';

/// S4. Quote flow: lane rate lookup -> rate card -> quick quote form.
/// Margin stays hidden; under-floor rates show "Needs approval".
class QuotePage extends ConsumerStatefulWidget {
  const QuotePage({super.key});

  @override
  ConsumerState<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends ConsumerState<QuotePage> {
  String _from = 'Pune';
  String _to = 'Chennai';
  String _vehicle = '32 ft MXL';
  final TextEditingController _rate = TextEditingController();
  bool _detention = false;
  bool _loading = false;
  bool _oda = false;
  bool _multiDrop = false;

  @override
  void dispose() {
    _rate.dispose();
    super.dispose();
  }

  int get _extras =>
      (_detention ? MockBusinessData.detentionPerDay : 0) +
      (_loading ? MockBusinessData.loadingCharge : 0) +
      (_oda ? 1200 : 0) +
      (_multiDrop ? MockBusinessData.multiDropPerPoint : 0);

  int get _total =>
      (int.tryParse(_rate.text.trim()) ?? 0) + _extras;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<int?> rate =
        ref.watch(laneRateProvider(_from, _to, _vehicle));
    const List<String> cities = [
      'Pune', 'Mumbai', 'Chennai', 'Delhi', 'Bengaluru', 'Hyderabad',
      'Jaipur', 'Ahmedabad', 'Nagpur', 'Kolkata', 'Patna', 'Indore',
    ];
    const List<String> vehicles = [
      '32 ft MXL', '20 ft', 'Tata Ace', 'Container', 'Reefer', 'Trailer',
    ];
    return AppScaffold(
      title: l10n.quoteTitle,
      actions: [
        IconButton(
          icon: const Icon(Icons.track_changes_outlined),
          onPressed: () => context.push('/sales/targets'),
        ),
      ],
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _from,
                  decoration:
                      InputDecoration(labelText: l10n.fromLabel),
                  items: [
                    for (final String c in cities)
                      DropdownMenuItem(value: c, child: Text(c)),
                  ],
                  onChanged: (v) {
                    if (v != null) setState(() => _from = v);
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _to,
                  decoration:
                      InputDecoration(labelText: l10n.toLabel),
                  items: [
                    for (final String c in cities)
                      DropdownMenuItem(value: c, child: Text(c)),
                  ],
                  onChanged: (v) {
                    if (v != null) setState(() => _to = v);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          DropdownButtonFormField<String>(
            initialValue: _vehicle,
            decoration:
                InputDecoration(labelText: l10n.vehicleTypeLabel),
            items: [
              for (final String v in vehicles)
                DropdownMenuItem(value: v, child: Text(v)),
            ],
            onChanged: (v) {
              if (v != null) setState(() => _vehicle = v);
            },
          ),
          const SizedBox(height: AppSpacing.md),
          rate.when(
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => ErrorState(message: l10n.commonError),
            data: (int? contract) {
              if (contract == null) {
                return Text(l10n.noRateCard);
              }
              if (_rate.text.isEmpty) {
                _rate.text = '$contract';
              }
              return AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${l10n.contractRate}: ${Formatters.inr(contract)}',
                      style:
                          Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      '${l10n.perTonRate}: ${Formatters.inr(contract ~/ 15)}',
                    ),
                    Text(
                      MockBusinessData.dieselNote,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _rate,
            label: l10n.rateLabel,
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              '${l10n.chargeDetention} (${Formatters.inr(MockBusinessData.detentionPerDay)})',
            ),
            value: _detention,
            onChanged: (v) =>
                setState(() => _detention = v ?? false),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              '${l10n.chargeLoading} (${Formatters.inr(MockBusinessData.loadingCharge)})',
            ),
            value: _loading,
            onChanged: (v) =>
                setState(() => _loading = v ?? false),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('${l10n.chargeOda} (${Formatters.inr(1200)})'),
            value: _oda,
            onChanged: (v) => setState(() => _oda = v ?? false),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              '${l10n.chargeMultiDrop} (${Formatters.inr(MockBusinessData.multiDropPerPoint)})',
            ),
            value: _multiDrop,
            onChanged: (v) =>
                setState(() => _multiDrop = v ?? false),
          ),
          const SizedBox(height: AppSpacing.sm),
          Builder(builder: (context) {
            final int? contract = rate.value;
            final int entered = int.tryParse(_rate.text.trim()) ?? 0;
            if (contract != null && entered > 0 && entered < contract) {
              return Container(
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.12),
                  borderRadius: AppSpacing.cardRadius,
                ),
                child: Text(l10n.needsApproval),
              );
            }
            return const SizedBox.shrink();
          }),
          Text(
            '${l10n.quoteTotal}: ${Formatters.inr(_total)}',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(
            label: l10n.quotePreviewAction,
            variant: AppButtonVariant.accent,
            large: true,
            onPressed: () => context.push(
              '/sales/quote/preview',
              extra: {
                'from': _from,
                'to': _to,
                'vehicle': _vehicle,
                'rate': int.tryParse(_rate.text.trim()) ?? 0,
                'charges': {
                  if (_detention)
                    'detention': MockBusinessData.detentionPerDay,
                  if (_loading)
                    'loading': MockBusinessData.loadingCharge,
                  if (_oda) 'oda': 1200,
                  if (_multiDrop)
                    'multidrop': MockBusinessData.multiDropPerPoint,
                },
              },
            ),
          ),
        ],
      ),
    );
  }
}
