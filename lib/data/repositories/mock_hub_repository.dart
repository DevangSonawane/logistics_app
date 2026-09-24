import 'package:uuid/uuid.dart';

import '../mock/mock_delay.dart';
import '../models/hub.dart';
import 'hub_repository.dart';

/// Mock hub store with 10 tasks (5 loadings, 5 arrivals) at the Pune hub.
class MockHubRepository implements HubRepository {
  MockHubRepository() {
    final DateTime now = DateTime.now();
    HubTask t({
      required String id,
      required HubTaskType type,
      required String veh,
      required String cust,
      required int etaMins,
      int pkgs = 24,
    }) =>
        HubTask(
          id: id,
          type: type,
          vehicleNo: veh,
          customer: cust,
          eta: now.add(Duration(minutes: etaMins)),
          expectedPackages: pkgs,
          declaredKg: 12000,
        );
    _tasks.addAll([
      t(id: 'hub-1', type: HubTaskType.loading, veh: 'MH12 AB 1234', cust: 'Bajaj Auto', etaMins: 30),
      t(id: 'hub-2', type: HubTaskType.loading, veh: 'MH14 CD 5678', cust: 'Parle Products', etaMins: 90, pkgs: 18),
      t(id: 'hub-3', type: HubTaskType.loading, veh: 'MH04 EF 9012', cust: 'Tata Agrico Ltd', etaMins: 150, pkgs: 12),
      t(id: 'hub-4', type: HubTaskType.loading, veh: 'KA01 GH 3456', cust: 'Asian Paints', etaMins: 210, pkgs: 30),
      t(id: 'hub-5', type: HubTaskType.loading, veh: 'TN09 JK 7890', cust: 'Godrej Consumer', etaMins: 270, pkgs: 22),
      t(id: 'hub-6', type: HubTaskType.arrival, veh: 'MH14 UU 7788', cust: 'Reliance Retail', etaMins: -20, pkgs: 26),
      t(id: 'hub-7', type: HubTaskType.arrival, veh: 'GJ01 RS 3344', cust: 'Amul Dairy', etaMins: 15, pkgs: 20),
      t(id: 'hub-8', type: HubTaskType.arrival, veh: 'DL01 TT 5566', cust: 'Havells India', etaMins: 60, pkgs: 28),
      t(id: 'hub-9', type: HubTaskType.arrival, veh: 'TN10 WW 1212', cust: 'Godrej Consumer', etaMins: 120, pkgs: 16),
      t(id: 'hub-10', type: HubTaskType.arrival, veh: 'MH12 LM 1122', cust: 'Parle Products', etaMins: 180, pkgs: 8),
    ]);
  }

  final List<HubTask> _tasks = [];
  final List<Manifest> _manifests = [];
  final Uuid _uuid = const Uuid();

  @override
  Future<List<HubTask>> todayTasks() async {
    await mockDelay();
    throwIfChaos();
    return List.unmodifiable(_tasks);
  }

  HubTask _require(String taskId) {
    final int i = _tasks.indexWhere((t) => t.id == taskId);
    if (i < 0) throw const MockApiException('Task not found');
    return _tasks[i];
  }

  void _save(HubTask task) {
    final int i = _tasks.indexWhere((t) => t.id == task.id);
    _tasks[i] = task;
  }

  @override
  Future<HubTask> gateIn(String taskId, String vehicleNo, String driver) async {
    await mockDelay();
    throwIfChaos();
    final HubTask updated = _require(taskId).copyWith(
      gateInAt: DateTime.now(),
      status: HubTaskStatus.inProgress,
    );
    _save(updated);
    return updated;
  }

  @override
  Future<HubTask> gateOut(String taskId) async {
    await mockDelay();
    final HubTask updated = _require(taskId).copyWith(
      gateOutAt: DateTime.now(),
      status: HubTaskStatus.done,
    );
    _save(updated);
    return updated;
  }

  @override
  Future<HubTask> updateTask(HubTask task) async {
    await mockDelay();
    _save(task);
    return task;
  }

  @override
  Future<Manifest> createManifest(
    String destHub,
    List<ScanItem> items,
  ) async {
    await mockDelay();
    throwIfChaos();
    final Manifest manifest = Manifest(
      id: 'mn-${_uuid.v4().substring(0, 6)}',
      destHub: destHub,
      items: List.of(items),
      createdAt: DateTime.now(),
    );
    _manifests.insert(0, manifest);
    return manifest;
  }

  @override
  Future<List<Manifest>> manifests() async {
    await mockDelay();
    return List.unmodifiable(_manifests);
  }
}
