import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_provider.g.dart';

/// Raw connectivity stream. The app treats "no network interface" as
/// offline; captive portals are handled by failed sync attempts.
@riverpod
Stream<List<ConnectivityResult>> connectivity(Ref ref) {
  return Connectivity().onConnectivityChanged;
}

/// True unless all interfaces report [ConnectivityResult.none].
/// Defaults to online while the first event is pending.
@riverpod
bool isOnline(Ref ref) {
  final AsyncValue<List<ConnectivityResult>> value =
      ref.watch(connectivityProvider);
  return value.maybeWhen(
    data: (List<ConnectivityResult> results) =>
        results.isEmpty || !results.contains(ConnectivityResult.none),
    orElse: () => true,
  );
}
