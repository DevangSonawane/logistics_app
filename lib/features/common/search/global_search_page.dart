import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/route_names.dart';
import '../../../core/storage/boxes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/debouncer.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/search_bar.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../data/models/customer.dart';
import '../../../data/models/trip.dart';
import '../../../data/models/vehicle.dart';
import '../../../data/repositories/repository_providers.dart';

/// Global search: Trips, LRs, Vehicles, Customers tabs with recents.
/// Queries debounce 300 ms; recents persist in the Hive cache box.
class GlobalSearchPage extends ConsumerStatefulWidget {
  const GlobalSearchPage({super.key});

  @override
  ConsumerState<GlobalSearchPage> createState() => _GlobalSearchPageState();
}

class _GlobalSearchPageState extends ConsumerState<GlobalSearchPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _query = TextEditingController();
  final Debouncer _debouncer = Debouncer();
  late final TabController _tabs = TabController(length: 4, vsync: this);
  String _term = '';
  List<String> _recents = [];
  bool _recentsLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_recentsLoaded) {
      _recentsLoaded = true;
      try {
        _recents = List<String>.from(
          ref.read(cacheBoxProvider).read(
                'recent_searches',
                defaultValue: [],
              ) as List,
        );
      } catch (_) {}
    }
  }

  @override
  void dispose() {
    _query.dispose();
    _debouncer.dispose();
    _tabs.dispose();
    super.dispose();
  }

  void _remember(String term) {
    if (term.isEmpty) return;
    final List<String> next = [
      term,
      ..._recents.where((r) => r != term),
    ].take(8).toList();
    setState(() => _recents = next);
    try {
      ref.read(cacheBoxProvider).write('recent_searches', next);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppScaffold(
      title: l10n.searchTitle,
      body: Column(
        children: [
          AppSearchBar(
            controller: _query,
            hint: l10n.searchHint,
            onChanged: (v) => _debouncer(() {
              setState(() => _term = v.trim().toLowerCase());
              _remember(v.trim());
            }),
            onSubmitted: (v) => setState(() {
              _term = v.trim().toLowerCase();
              _remember(v.trim());
            }),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (_term.isEmpty && _recents.isNotEmpty)
            Wrap(
              spacing: AppSpacing.sm,
              children: [
                for (final String r in _recents)
                  ActionChip(
                    label: Text(r),
                    onPressed: () {
                      _query.text = r;
                      setState(
                        () => _term = r.toLowerCase(),
                      );
                    },
                  ),
              ],
            ),
          TabBar(
            controller: _tabs,
            tabs: [
              Tab(text: l10n.searchTrips),
              Tab(text: l10n.searchLrs),
              Tab(text: l10n.searchVehicles),
              Tab(text: l10n.searchCustomers),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                _TripResults(term: _term),
                _LrResults(term: _term),
                _VehicleResults(term: _term),
                _CustomerResults(term: _term),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TripResults extends ConsumerWidget {
  const _TripResults({required this.term});

  final String term;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (term.isEmpty) {
      return EmptyState(
        title: l10n.searchHint,
        message: '',
        icon: Icons.search_outlined,
      );
    }
    return FutureBuilder<List<Trip>>(
      future: ref.watch(tripRepositoryProvider).runningTrips(),
      builder: (context, snapshot) {
        final List<Trip> items = (snapshot.data ?? const [])
            .where(
              (t) =>
                  t.no.toLowerCase().contains(term) ||
                  t.customer.toLowerCase().contains(term) ||
                  t.vehicleReg.toLowerCase().contains(term),
            )
            .toList();
        if (items.isEmpty) {
          return EmptyState(
            title: l10n.noResults,
            message: '',
            icon: Icons.search_off_outlined,
          );
        }
        return ListView(
          children: [
            for (final Trip t in items)
              ListTile(
                title: Text('${t.no} · ${t.customer}'),
                subtitle: Text(t.vehicleReg),
                onTap: () => context.push(
                  '${RouteNames.opsTrips}/${t.id}',
                ),
              ),
          ],
        );
      },
    );
  }
}

class _LrResults extends ConsumerWidget {
  const _LrResults({required this.term});

  final String term;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (term.isEmpty) {
      return EmptyState(
        title: l10n.searchHint,
        message: '',
        icon: Icons.search_outlined,
      );
    }
    return FutureBuilder<List<Trip>>(
      future: ref.watch(tripRepositoryProvider).runningTrips(),
      builder: (context, snapshot) {
        final List<Trip> items = (snapshot.data ?? const [])
            .where(
              (t) =>
                  (t.lrNo ?? '').toLowerCase().contains(term) ||
                  (t.ewayBillNo ?? '').toLowerCase().contains(term),
            )
            .toList();
        if (items.isEmpty) {
          return EmptyState(
            title: l10n.noResults,
            message: '',
            icon: Icons.search_off_outlined,
          );
        }
        return ListView(
          children: [
            for (final Trip t in items)
              ListTile(
                title: Text(t.lrNo ?? '-'),
                subtitle: Text('${t.no} · ${t.customer}'),
              ),
          ],
        );
      },
    );
  }
}

class _VehicleResults extends ConsumerWidget {
  const _VehicleResults({required this.term});

  final String term;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (term.isEmpty) {
      return EmptyState(
        title: l10n.searchHint,
        message: '',
        icon: Icons.search_outlined,
      );
    }
    return FutureBuilder<List<Vehicle>>(
      future: ref.watch(vehicleRepositoryProvider).list(),
      builder: (context, snapshot) {
        final List<Vehicle> items = (snapshot.data ?? const [])
            .where((v) => v.regNo.toLowerCase().contains(term))
            .toList();
        if (items.isEmpty) {
          return EmptyState(
            title: l10n.noResults,
            message: '',
            icon: Icons.search_off_outlined,
          );
        }
        return ListView(
          children: [
            for (final Vehicle v in items)
              ListTile(
                title: Text(v.regNo),
                subtitle: Text('${v.type} · ${v.ownership.name}'),
              ),
          ],
        );
      },
    );
  }
}

class _CustomerResults extends ConsumerWidget {
  const _CustomerResults({required this.term});

  final String term;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (term.isEmpty) {
      return EmptyState(
        title: l10n.searchHint,
        message: '',
        icon: Icons.search_outlined,
      );
    }
    return FutureBuilder<List<Customer>>(
      future: ref.watch(customerRepositoryProvider).list(),
      builder: (context, snapshot) {
        final List<Customer> items = (snapshot.data ?? const [])
            .where((c) => c.name.toLowerCase().contains(term))
            .toList();
        if (items.isEmpty) {
          return EmptyState(
            title: l10n.noResults,
            message: '',
            icon: Icons.search_off_outlined,
          );
        }
        return ListView(
          children: [
            for (final Customer c in items)
              ListTile(
                title: Text(c.name),
                subtitle: Text(c.gstin),
              ),
          ],
        );
      },
    );
  }
}
