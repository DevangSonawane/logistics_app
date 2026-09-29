import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
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

  int get _total => (int.tryParse(_rate.text.trim()) ?? 0) + _extras;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<int?> rate = ref.watch(
      laneRateProvider(_from, _to, _vehicle),
    );
    const List<String> cities = [
      'Pune',
      'Mumbai',
      'Chennai',
      'Delhi',
      'Bengaluru',
      'Hyderabad',
      'Jaipur',
      'Ahmedabad',
      'Nagpur',
      'Kolkata',
      'Patna',
      'Indore',
    ];
    const List<String> vehicles = [
      '32 ft MXL',
      '20 ft',
      'Tata Ace',
      'Container',
      'Reefer',
      'Trailer',
    ];
    final AppColorTokens tokens = context.tokens;
    return AppScaffold(
      title: l10n.quoteTitle,
      actions: [
        IconButton(
          icon: const Icon(Icons.track_changes_outlined),
          onPressed: () => context.push('/sales/targets'),
        ),
      ],
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _SectionCard(
                  title: '$_from → $_to',
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _from,
                              isExpanded: true,
                              decoration: InputDecoration(
                                labelText: l10n.fromLabel,
                              ),
                              items: [
                                for (final String c in cities)
                                  DropdownMenuItem(
                                    value: c,
                                    child: _DropdownText(c),
                                  ),
                              ],
                              selectedItemBuilder: (context) => [
                                for (final String c in cities) _DropdownText(c),
                              ],
                              onChanged: (v) {
                                if (v != null) {
                                  setState(() => _from = v);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _to,
                              isExpanded: true,
                              decoration: InputDecoration(
                                labelText: l10n.toLabel,
                              ),
                              items: [
                                for (final String c in cities)
                                  DropdownMenuItem(
                                    value: c,
                                    child: _DropdownText(c),
                                  ),
                              ],
                              selectedItemBuilder: (context) => [
                                for (final String c in cities) _DropdownText(c),
                              ],
                              onChanged: (v) {
                                if (v != null) {
                                  setState(() => _to = v);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      DropdownButtonFormField<String>(
                        initialValue: _vehicle,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: l10n.vehicleTypeLabel,
                        ),
                        items: [
                          for (final String v in vehicles)
                            DropdownMenuItem(value: v, child: _DropdownText(v)),
                        ],
                        selectedItemBuilder: (context) => [
                          for (final String v in vehicles) _DropdownText(v),
                        ],
                        onChanged: (v) {
                          if (v != null) {
                            setState(() => _vehicle = v);
                          }
                        },
                      ),
                    ],
                  ),
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
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: AppSpacing.cardRadius,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.contractRate,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: tokens.inkMuted,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            Formatters.inr(contract),
                            style: AppTypography.kpiNumber(
                              tokens.primary,
                            ).copyWith(fontSize: 28),
                          ),
                          Text(
                            '${l10n.perTonRate}: ${Formatters.inr(contract ~/ 15)}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: tokens.inkMuted),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                _SectionCard(
                  title: l10n.quoteTotal,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: _rate,
                        label: l10n.rateLabel,
                        keyboardType: TextInputType.number,
                        prefixIcon: Icons.currency_rupee_outlined,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _ChargeRow(
                        label:
                            '${l10n.chargeDetention} (${Formatters.inr(MockBusinessData.detentionPerDay)})',
                        value: _detention,
                        onChanged: (v) => setState(() => _detention = v),
                      ),
                      _ChargeRow(
                        label:
                            '${l10n.chargeLoading} (${Formatters.inr(MockBusinessData.loadingCharge)})',
                        value: _loading,
                        onChanged: (v) => setState(() => _loading = v),
                      ),
                      _ChargeRow(
                        label: '${l10n.chargeOda} (${Formatters.inr(1200)})',
                        value: _oda,
                        onChanged: (v) => setState(() => _oda = v),
                      ),
                      _ChargeRow(
                        label:
                            '${l10n.chargeMultiDrop} (${Formatters.inr(MockBusinessData.multiDropPerPoint)})',
                        value: _multiDrop,
                        onChanged: (v) => setState(() => _multiDrop = v),
                        last: true,
                      ),
                    ],
                  ),
                ),
                Builder(
                  builder: (context) {
                    final int? contract = rate.value;
                    final int entered = int.tryParse(_rate.text.trim()) ?? 0;
                    if (contract != null && entered > 0 && entered < contract) {
                      return Container(
                        margin: const EdgeInsets.only(top: AppSpacing.md),
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.12),
                          borderRadius: AppSpacing.cardRadius,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.warning_amber_outlined,
                              size: 18,
                              color: AppColors.warning,
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(child: Text(l10n.needsApproval)),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primary, AppColors.primaryDark],
                    ),
                    borderRadius: AppSpacing.cardRadius,
                  ),
                  child: Column(
                    children: [
                      Text(
                        l10n.quoteTotal,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        Formatters.inr(_total),
                        style: AppTypography.kpiNumber(
                          Colors.white,
                        ).copyWith(fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SafeArea(
            top: false,
            child: AppButton(
              label: l10n.quotePreviewAction,
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
                    if (_loading) 'loading': MockBusinessData.loadingCharge,
                    if (_oda) 'oda': 1200,
                    if (_multiDrop)
                      'multidrop': MockBusinessData.multiDropPerPoint,
                  },
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DropdownText extends StatelessWidget {
  const _DropdownText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, maxLines: 1, overflow: TextOverflow.ellipsis);
  }
}

/// Card with a semibold section title.
class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.tokens.surface,
        borderRadius: AppSpacing.cardRadius,
        border: Border.all(color: context.tokens.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 15),
          ),
          const SizedBox(height: AppSpacing.md),
          child,
        ],
      ),
    );
  }
}

/// Compact charge toggle row.
class _ChargeRow extends StatelessWidget {
  const _ChargeRow({
    required this.label,
    required this.value,
    required this.onChanged,
    this.last = false,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyLarge),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
