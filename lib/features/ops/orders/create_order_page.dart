import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../data/models/customer.dart';
import '../../../data/models/order.dart';
import '../../../data/repositories/repository_providers.dart';
import '../../owner/application/owner_providers.dart';
import '../application/ops_providers.dart';

/// Mock AI parse result for a pasted WhatsApp indent message.
typedef ParsedOrderMessage = ({
  String? cargo,
  String? vehicle,
  String? from,
  String? to,
  int? dateOffsetDays,
});

const List<String> orderVehicleTypes = [
  '32 ft MXL',
  '20 ft',
  'Tata Ace',
  'Container',
  'Reefer',
  'Trailer',
];

const List<String> _indentCities = [
  'pune', 'mumbai', 'chennai', 'delhi', 'bengaluru', 'hyderabad',
  'jaipur', 'ahmedabad', 'nagpur', 'kolkata', 'patna', 'indore',
];

/// Parses "2 trucks 32 ft Pune to Chennai tomorrow" into prefill data.
/// Pure function so the unit tests cover it without widgets.
ParsedOrderMessage parseWhatsappMessage(String text) {
  final String lower = text.toLowerCase();
  String? cargo;
  String? vehicle;
  String? from;
  String? to;
  int? dateOffset;
  final Match? truckMatch = RegExp(r'(\d+)\s*trucks?').firstMatch(lower);
  if (truckMatch != null) {
    cargo = '${truckMatch.group(1)} truck load';
  }
  for (final String v in orderVehicleTypes) {
    if (lower.contains(v.toLowerCase())) {
      vehicle = v;
      break;
    }
  }
  final List<String> found =
      _indentCities.where(lower.contains).toList();
  if (found.length >= 2) {
    from = found[0][0].toUpperCase() + found[0].substring(1);
    to = found[1][0].toUpperCase() + found[1].substring(1);
  }
  if (lower.contains('tomorrow')) {
    dateOffset = 1;
  } else if (lower.contains('today')) {
    dateOffset = 0;
  }
  return (
    cargo: cargo,
    vehicle: vehicle,
    from: from,
    to: to,
    dateOffsetDays: dateOffset,
  );
}

/// P2. Create order: 4-step stepper + "paste WhatsApp message" mock AI
/// parse that pre-fills with an "AI filled" chip per parsed field.
class CreateOrderPage extends ConsumerStatefulWidget {
  const CreateOrderPage({super.key});

  @override
  ConsumerState<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends ConsumerState<CreateOrderPage> {
  int _step = 0;
  String? _customerId;
  OrderType _type = OrderType.ftl;
  final TextEditingController _pickup = TextEditingController();
  final TextEditingController _drop = TextEditingController();
  DateTime? _neededBy;
  final TextEditingController _commodity = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  final TextEditingController _value = TextEditingController();
  String _vehicleType = '32 ft MXL';
  final TextEditingController _rate = TextEditingController();
  final Set<String> _aiFilled = {};
  bool _working = false;

  static const List<String> vehicleTypes = orderVehicleTypes;

  @override
  void dispose() {
    _pickup.dispose();
    _drop.dispose();
    _commodity.dispose();
    _weight.dispose();
    _value.dispose();
    _rate.dispose();
    super.dispose();
  }

  /// Mock AI parse: "2 trucks 32 ft Pune to Chennai tomorrow".
  void _parseWhatsapp(String text) {
    final ParsedOrderMessage parsed = parseWhatsappMessage(text);
    final Set<String> filled = {};
    if (parsed.cargo != null) {
      _commodity.text = parsed.cargo!;
      filled.add('cargo');
    }
    if (parsed.vehicle != null) {
      setState(() => _vehicleType = parsed.vehicle!);
      filled.add('vehicle');
    }
    if (parsed.from != null && parsed.to != null) {
      _pickup.text = parsed.from!;
      _drop.text = parsed.to!;
      filled.add('route');
    }
    if (parsed.dateOffsetDays != null) {
      _neededBy =
          DateTime.now().add(Duration(days: parsed.dateOffsetDays!));
      filled.add('date');
    }
    setState(() {
      _aiFilled.addAll(filled);
    });
  }

  Future<void> _pasteWhatsapp() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final TextEditingController controller = TextEditingController();
    final String? text = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.pasteWhatsapp),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(hintText: l10n.pasteHint),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancelAction),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(controller.text),
            child: Text(l10n.permissionNext),
          ),
        ],
      ),
    );
    if (text != null && text.trim().isNotEmpty && mounted) {
      _parseWhatsapp(text);
    }
  }

  Future<void> _submit() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (_customerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.selectCustomer)),
      );
      return;
    }
    setState(() => _working = true);
    final List<Customer> customers =
        await ref.read(customerRepositoryProvider).list();
    final Customer customer = customers.firstWhere(
      (c) => c.id == _customerId,
      orElse: () => customers.first,
    );
    final Order order = Order(
      id: 'local',
      no: 'local',
      customerId: customer.id,
      customerName: customer.name,
      type: _type,
      stops: [
        OrderStop(
          address: _pickup.text.trim(),
          lat: 18.5204,
          lng: 73.8567,
          windowStart: _neededBy,
        ),
        OrderStop(address: _drop.text.trim(), lat: 13.0827, lng: 80.2707),
      ],
      vehicleType: _vehicleType,
      commodity: _commodity.text.trim().isEmpty
          ? 'General goods'
          : _commodity.text.trim(),
      weightKg: double.tryParse(_weight.text.trim()) ?? 0,
      declaredValue: double.tryParse(_value.text.trim()),
      rate: int.tryParse(_rate.text.trim()) ?? 0,
    );
    try {
      await ref.read(orderRepositoryProvider).create(order);
    } catch (_) {
      if (!mounted) return;
      setState(() => _working = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.commonError)),
      );
      return;
    }
    ref.invalidate(ordersByStatusProvider(OrderStatus.pending));
    ref.invalidate(allOpsOrdersProvider);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.orderCreated)),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppScaffold(
      title: l10n.newOrder,
      body: Stepper(
        currentStep: _step,
        onStepContinue: () {
          if (_step < 3) {
            setState(() => _step++);
          } else {
            _submit();
          }
        },
        onStepCancel: () {
          if (_step > 0) setState(() => _step--);
        },
        controlsBuilder: (context, details) => Padding(
          padding: const EdgeInsets.only(top: AppSpacing.lg),
          child: Row(
            children: [
              Expanded(
                child: AppButton(
                  label: _step == 3 ? l10n.createOrder : l10n.permissionNext,
                  loading: _working,
                  onPressed: _working ? null : details.onStepContinue,
                ),
              ),
              if (_step > 0) ...[
                const SizedBox(width: AppSpacing.sm),
                TextButton(
                  onPressed: details.onStepCancel,
                  child: Text(l10n.goBackAction),
                ),
              ],
            ],
          ),
        ),
        steps: [
          Step(
            title: Text(l10n.stepCustomer),
            content: Column(
              children: [
                _CustomerDropdown(
                  value: _customerId,
                  onChanged: (v) => setState(() => _customerId = v),
                ),
                const SizedBox(height: AppSpacing.md),
                SegmentedButton<OrderType>(
                  segments: [
                    ButtonSegment(
                      value: OrderType.ftl,
                      label: Text(l10n.orderTypeFtl),
                    ),
                    ButtonSegment(
                      value: OrderType.ptl,
                      label: Text(l10n.orderTypePtl),
                    ),
                  ],
                  selected: {_type},
                  onSelectionChanged: (s) =>
                      setState(() => _type = s.first),
                ),
                const SizedBox(height: AppSpacing.md),
                OutlinedButton.icon(
                  icon: const Icon(Icons.chat_outlined),
                  label: Text(l10n.pasteWhatsapp),
                  onPressed: _pasteWhatsapp,
                ),
              ],
            ),
          ),
          Step(
            title: Text(l10n.stepRoute),
            content: Column(
              children: [
                AppTextField(
                  controller: _pickup,
                  label: l10n.pickupPoint,
                ),
                if (_aiFilled.contains('route'))
                  _AiChip(text: l10n.aiFilled),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  controller: _drop,
                  label: l10n.dropPoint,
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _neededBy == null
                            ? l10n.neededByLabel
                            : Formatters.date(_neededBy!),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 60),
                          ),
                        );
                        if (picked != null) {
                          setState(() => _neededBy = picked);
                        }
                      },
                      child: Text(l10n.pickDate),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Step(
            title: Text(l10n.stepCargo),
            content: Column(
              children: [
                AppTextField(
                  controller: _commodity,
                  label: l10n.commodityLabel,
                ),
                if (_aiFilled.contains('cargo'))
                  _AiChip(text: l10n.aiFilled),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  controller: _weight,
                  label: l10n.weightLabel,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  controller: _value,
                  label: l10n.declaredValueLabel,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: AppSpacing.md),
                DropdownButtonFormField<String>(
                  initialValue: _vehicleType,
                  decoration: InputDecoration(
                    labelText: l10n.vehicleTypeLabel,
                  ),
                  items: [
                    for (final String v in vehicleTypes)
                      DropdownMenuItem(value: v, child: Text(v)),
                  ],
                  onChanged: (v) {
                    if (v != null) setState(() => _vehicleType = v);
                  },
                ),
              ],
            ),
          ),
          Step(
            title: Text(l10n.stepRate),
            content: Column(
              children: [
                AppTextField(
                  controller: _rate,
                  label: l10n.rateLabel,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: AppSpacing.sm),
                _ContractCheck(
                  from: _pickup.text.trim(),
                  to: _drop.text.trim(),
                  vehicle: _vehicleType,
                  entered: int.tryParse(_rate.text.trim()) ?? 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomerDropdown extends ConsumerWidget {
  const _CustomerDropdown({required this.value, required this.onChanged});

  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<Customer>> customers =
        ref.watch(customersProvider);
    return customers.when(
      loading: () => const LinearProgressIndicator(),
      error: (e, _) => Text(l10n.commonError),
      data: (List<Customer> list) => DropdownButtonFormField<String>(
        initialValue: value,
        decoration: InputDecoration(labelText: l10n.customerLabel),
        items: [
          for (final Customer c in list)
            DropdownMenuItem(value: c.id, child: Text(c.name)),
        ],
        onChanged: onChanged,
      ),
    );
  }
}

class _AiChip extends StatelessWidget {
  const _AiChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Chip(
        label: Text(text),
        avatar: const Icon(Icons.auto_awesome_outlined, size: 16),
      ),
    );
  }
}

/// Contract rate lookup with a below-rate warning banner.
class _ContractCheck extends ConsumerWidget {
  const _ContractCheck({
    required this.from,
    required this.to,
    required this.vehicle,
    required this.entered,
  });

  final String from;
  final String to;
  final String vehicle;
  final int entered;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (from.isEmpty || to.isEmpty) return const SizedBox.shrink();
    final AsyncValue<int?> contract =
        ref.watch(contractRateProvider(from, to, vehicle));
    return contract.when(
      loading: () => const SizedBox.shrink(),
      error: (e, _) => const SizedBox.shrink(),
      data: (int? rate) {
        if (rate == null) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${l10n.contractRate}: ${Formatters.inr(rate)}'),
            if (entered > 0 && entered < rate)
              Container(
                margin: const EdgeInsets.only(top: AppSpacing.sm),
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.12),
                  borderRadius: AppSpacing.cardRadius,
                ),
                child: Text(l10n.belowContract),
              ),
          ],
        );
      },
    );
  }
}
