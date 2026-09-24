import '../models/hub.dart';

/// Hub supervisor store: today's tasks, gate, loading flow, scans,
/// manifests and LR data.
abstract class HubRepository {
  Future<List<HubTask>> todayTasks();
  Future<HubTask> gateIn(String taskId, String vehicleNo, String driver);
  Future<HubTask> gateOut(String taskId);
  Future<HubTask> updateTask(HubTask task);
  Future<Manifest> createManifest(String destHub, List<ScanItem> items);
  Future<List<Manifest>> manifests();
}
