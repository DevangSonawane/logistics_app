import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/hub.dart';
import '../../../data/repositories/repository_providers.dart';

part 'supervisor_providers.g.dart';

@riverpod
Future<List<HubTask>> hubTasks(Ref ref) {
  return ref.watch(hubRepositoryProvider).todayTasks();
}

@riverpod
Future<List<Manifest>> manifests(Ref ref) {
  return ref.watch(hubRepositoryProvider).manifests();
}
