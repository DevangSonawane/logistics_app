import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../core/widgets/status_chip.dart';
import '../../../data/models/driver.dart';
import '../../../data/models/order.dart';
import '../../../data/models/trip.dart';
import '../../../data/models/vehicle.dart';
import '../../../data/repositories/repository_providers.dart';
import '../application/ops_providers.dart';

/// Road-distance estimate: haversine with a 1.3x road factor.
/// Pure function covered by unit tests.
double haversineRoadKm(double aLat, double aLng, double bLat, double bLng) {
  const double r = 6371;
  final double dLat = (bLat - aLat) * math.pi / 180;
  final double dLng = (bLng - aLng) * math.pi / 180;
  final double h = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(aLat * math.pi / 180) *
          math.cos(bLat * math.pi / 180) *
          math.sin(dLng / 2) *
          math.sin(dLng / 2);
  return r * 2 * math.asin(math.sqrt(h)) * 1.3;
}

/// P3. Plan trip wizard: order -> ranked vehicles -> driver (validity +
/// on-trip block) -> summary + advance -> assign & notify. Return-load
/// suggestion closes the loop.
class PlanTripPage extends ConsumerStatefulWidget {
  const PlanTripPage({super.key, required this.orderId});

  final String orderId;

  @override
  ConsumerState<PlanTripPage> createState() => _PlanTripPageState();
}

class _PlanTripPageState extends ConsumerState<PlanTripPage> {
  int _step = 0;
  String? _vehicleId;
  String? _driverId;
  final TextEditingController _advance = TextEditingController();
  bool _working = false;
  bool _assigned = false;
  String? _assignedTripNo;

  /// Loaded once: rebuilding (e.g. picking a vehicle) must not refetch.
  late final Future<Order?> _orderFuture =
      ref.read(orderRepositoryProvider).get(widget.orderId);

  @override
  void dispose() {
    _advance.dispose();
    super.dispose();
  }

  double _haversineKm(Order order) {
    if (order.stops.length < 2) return 0;
    final OrderStop a = order.stops.first;
    final OrderStop b = order.stops.last;
    return haversineRoadKm(a.lat, a.lng, b.lat, b.lng);
  }

  Future<void> _assign(Order order) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (_vehicleId == null || _driverId == null) return;
    setState(() => _working = true);
    final List<Vehicle> vehicles =
        await ref.read(vehicleRepositoryProvider).list();
    final Vehicle vehicle = vehicles.firstWhere((v) => v.id == _vehicleId);
    final DateTime now = DateTime.now();
    final Trip trip = Trip(
      id: 'trip-${const Uuid().v4().substring(0, 6)}',
      no: 'TRIP-2026-${900 + now.millisecondsSinceEpoch % 90}',
      orderId: order.id,
      customer: order.customerName,
      pickupAddress: order.stops.first.address,
      pickupContact: order.customerName,
      pickupPhone: '9810000000',
      pickupLat: order.stops.first.lat,
      pickupLng: order.stops.first.lng,
      dropAddress: order.stops.last.address,
      dropContact: order.customerName,
      dropPhone: '9910000000',
      dropLat: order.stops.last.lat,
      dropLng: order.stops.last.lng,
      distanceKm: _haversineKm(order),
      freightAllowance: 3000,
      pickupBy: order.neededBy ?? now.add(const Duration(hours: 8)),
      vehicleReg: vehicle.regNo,
      driverId: _driverId!,
      status: TripStatus.offered,
      plannedEta: now.add(const Duration(hours: 24)),
      lrNo: 'LR-${89000 + now.millisecondsSinceEpoch % 900}',
      advanceGiven: int.tryParse(_advance.text.trim()) ?? 0,
    );
    try {
      await ref.read(tripRepositoryProvider).assignTrip(trip);
      await ref.read(orderRepositoryProvider).markPlanned(order.id, trip.id);
    } catch (_) {
      if (!mounted) return;
      setState(() => _working = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.commonError)),
      );
      return;
    }
    ref.invalidate(allOpsOrdersProvider);
    ref.invalidate(ordersByStatusProvider(OrderStatus.pending));
    if (!mounted) return;
    setState(() {
      _working = false;
      _assigned = true;
      _assignedTripNo = trip.no;
    });
  }

  bool get _canContinue =>
      _step == 0 ||
      (_step == 1 && _vehicleId != null) ||
      (_step == 2 && _driverId != null);

  void _next(Order order) {
    if (_step < 3 && _canContinue) {
      setState(() => _step++);
    } else if (_step == 3) {
      _assign(order);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return FutureBuilder<Order?>(
      future: _orderFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppScaffold(
            title: l10n.planTitle,
            body: const SkeletonList(),
          );
        }
        final Order? order = snapshot.data;
        if (order == null) {
          return AppScaffold(
            title: l10n.planTitle,
            body: ErrorState(message: l10n.commonError),
          );
        }
        if (_assigned) {
          return _ReturnLoad(
            order: order,
            tripNo: _assignedTripNo ?? '',
          );
        }
        final double km = _haversineKm(order);
        final List<String> steps = [
          l10n.planStepVehicle,
          l10n.planStepDriver,
          l10n.planStepSummary,
        ];
        return AppScaffold(
          title: l10n.planTitle,
          body: Column(
            children: [
              _OrderStrip(order: order),
              const SizedBox(height: AppSpacing.sm),
              _StepDots(
                steps: steps,
                current: _step == 0 ? 0 : _step - 1,
              ),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: _stepContent(order, km, steps),
              ),
              const SizedBox(height: AppSpacing.md),
              SafeArea(
                top: false,
                child: Row(
                  children: [
                    if (_step > 0)
                      IconButton.outlined(
                        onPressed: () => setState(() => _step--),
                        icon: const Icon(Icons.arrow_back_outlined),
                      ),
                    if (_step > 0)
                      const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: AppButton(
                        label: _step == 3
                            ? l10n.assignAction
                            : l10n.permissionNext,
                        loading: _working,
                        onPressed: _working || !_canContinue
                            ? null
                            : () => _next(order),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Step 0 shows the order as a confirmation card; steps 1-3 map onto
  /// vehicle / driver / summary.
  Widget _stepContent(Order order, double km, List<String> steps) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (_step == 0) {
      return ListView(
        padding: EdgeInsets.zero,
        children: [
          _OrderDetailCard(order: order, km: km),
        ],
      );
    }
    if (_step == 1) {
      return SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: _VehicleOptions(
          order: order,
          selected: _vehicleId,
          onPick: (id) => setState(() => _vehicleId = id),
        ),
      );
    }
    if (_step == 2) {
      return SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: _DriverOptions(
          selected: _driverId,
          onPick: (id) => setState(() => _driverId = id),
        ),
      );
    }
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _SummaryRow(label: l10n.routeKm, value: Formatters.distanceKm(km)),
        _SummaryRow(label: l10n.tollEst, value: Formatters.inr(km * 1.1)),
        _SummaryRow(
          label: l10n.dieselEst,
          value: '${(km / 4).round()} L · ${Formatters.inr(km / 4 * 91)}',
        ),
        _SummaryRow(
          label: l10n.etaLabel,
          value: Formatters.duration(Duration(hours: (km / 40).round())),
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          controller: _advance,
          label: l10n.advanceOptional,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}

/// Slim order strip pinned under the app bar.
class _OrderStrip extends StatelessWidget {
  const _OrderStrip({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: tokens.primary.withValues(alpha: 0.08),
        borderRadius: AppSpacing.cardRadius,
      ),
      child: Row(
        children: [
          Icon(
            Icons.receipt_long_outlined,
            color: tokens.primary,
            size: 18,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              '${order.no} · ${order.customerName}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: tokens.primary,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

/// Step 0 confirmation card: route, cargo, rate.
class _OrderDetailCard extends StatelessWidget {
  const _OrderDetailCard({required this.order, required this.km});

  final Order order;
  final double km;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: tokens.surface,
        borderRadius: AppSpacing.cardRadius,
        border: Border.all(color: tokens.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${order.no} · ${order.customerName}',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(
                Icons.route_outlined,
                size: 18,
                color: tokens.primary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  '${order.stops.first.address} → ${order.stops.last.address}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${order.vehicleType} · ${order.weightKg} kg · ${Formatters.inr(order.rate)}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: tokens.inkMuted,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            Formatters.distanceKm(km),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: tokens.primary,
                ),
          ),
        ],
      ),
    );
  }
}

/// Minimal 3-dot progress with labels.
class _StepDots extends StatelessWidget {
  const _StepDots({required this.steps, required this.current});

  final List<String> steps;
  final int current;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return Row(
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          Expanded(
            child: Column(
              children: [
                AnimatedContainer(
                  duration: AppSpacing.motionFast,
                  height: 4,
                  decoration: BoxDecoration(
                    color: i <= current
                        ? tokens.primary
                        : tokens.border,
                    borderRadius: AppSpacing.chipRadius,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  steps[i],
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                        color: i <= current
                            ? tokens.primary
                            : tokens.inkFaint,
                        fontWeight: i == current
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (i < steps.length - 1) const SizedBox(width: AppSpacing.sm),
        ],
      ],
    );
  }
}

class _VehicleOptions extends ConsumerWidget {
  const _VehicleOptions({
    required this.order,
    required this.selected,
    required this.onPick,
  });

  final Order order;
  final String? selected;
  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<Vehicle>> vehicles = ref.watch(
      rankedVehiclesProvider(
        weightKg: order.weightKg,
        vehicleType: order.vehicleType,
      ),
    );
    return vehicles.when(
      loading: () => const SkeletonList(itemCount: 3),
      error: (e, _) => ErrorState(message: l10n.commonError),
      data: (List<Vehicle> list) => Column(
        children: [
          for (final Vehicle v in list.take(5))
            _OptionCard(
              selected: selected == v.id,
              onTap: () => onPick(v.id),
              icon: Icons.local_shipping_outlined,
              title: v.regNo,
              subtitle:
                  '${v.type} · ${v.capacityTons}t · ${v.ownership.name}',
              trailing: _DocsChip(vehicle: v),
            ),
        ],
      ),
    );
  }
}

class _DocsChip extends StatelessWidget {
  const _DocsChip({required this.vehicle});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final bool ok = vehicle.docs.every(
      (d) => d.expiry.isAfter(DateTime.now()),
    );
    return StatusChip(
      label: ok ? l10n.docsValid : l10n.docsInvalid,
      color: ok ? AppColors.success : AppColors.danger,
    );
  }
}

class _DriverOptions extends ConsumerWidget {
  const _DriverOptions({required this.selected, required this.onPick});

  final String? selected;
  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<Driver>> drivers =
        ref.watch(rosterDriversProvider);
    final AsyncValue<Map<String, bool>> load =
        ref.watch(driverTripLoadProvider);
    return drivers.when(
      loading: () => const SkeletonList(itemCount: 3),
      error: (e, _) => ErrorState(message: l10n.commonError),
      data: (List<Driver> list) => Column(
        children: [
          for (final Driver d in list)
            Builder(builder: (context) {
              final bool onTrip =
                  load.value?[d.id] ?? false;
              final bool licenceOk =
                  d.licenseExpiry.isAfter(DateTime.now());
              final bool blocked = onTrip || !licenceOk;
              return _OptionCard(
                selected: selected == d.id,
                onTap: blocked ? null : () => onPick(d.id),
                icon: Icons.person_outline,
                title: d.name,
                subtitle:
                    '${d.phone} · ${l10n.onTimeLabel} ${d.onTimePct}%',
                trailing: blocked
                    ? StatusChip(
                        label: onTrip
                            ? l10n.onTripBlock
                            : l10n.licenceInvalid,
                        color: AppColors.danger,
                      )
                    : null,
              );
            }),
        ],
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.selected,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  final bool selected;
  final IconData icon;
  final VoidCallback? onTap;
  final String title;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Opacity(
        opacity: onTap == null ? 0.55 : 1,
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: AnimatedContainer(
            duration: AppSpacing.motionFast,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: selected
                  ? tokens.primary.withValues(alpha: 0.07)
                  : tokens.surface,
              borderRadius: AppSpacing.cardRadius,
              border: Border.all(
                color: selected ? tokens.primary : tokens.border,
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected
                        ? tokens.primary
                        : tokens.primary.withValues(alpha: 0.1),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: selected
                        ? tokens.onPrimary
                        : tokens.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                            Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        subtitle,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: tokens.inkMuted),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (selected)
                  Icon(
                    Icons.check_circle,
                    size: 22,
                    color: tokens.primary,
                  )
                else
                  trailing ?? const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

/// Return-load suggestion after a successful assignment.
class _ReturnLoad extends StatelessWidget {
  const _ReturnLoad({required this.order, required this.tripNo});

  final Order order;
  final String tripNo;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppScaffold(
      title: l10n.planTitle,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.check_circle,
            size: AppSpacing.huge,
            color: AppColors.success,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '${l10n.assignedMsg} $tripNo',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.12),
              borderRadius: AppSpacing.cardRadius,
              border: Border.all(color: AppColors.accent),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.returnLoadTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.returnLoadBody(order.stops.last.address),
                ),
              ],
            ),
          ),
          const Spacer(),
          AppButton(
            label: l10n.doneAction,
            onPressed: () => context.pop(),
          ),
        ],
      ),
    );
  }
}
