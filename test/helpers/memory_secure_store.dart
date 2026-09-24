import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:roadops/core/storage/secure_store.dart';

class _FakeSecureStorage extends Mock implements FlutterSecureStorage {}

/// In-memory SecureStore for widget tests (the real plugin has no
/// test implementation and throws MissingPluginException).
SecureStore memorySecureStore() {
  final _FakeSecureStorage storage = _FakeSecureStorage();
  final Map<String, String> data = {};
  when(() => storage.read(key: any(named: 'key'))).thenAnswer(
    (Invocation i) async => data[i.namedArguments[#key] as String],
  );
  when(
    () => storage.write(
      key: any(named: 'key'),
      value: any(named: 'value'),
    ),
  ).thenAnswer((Invocation i) async {
    data[i.namedArguments[#key] as String] =
        i.namedArguments[#value] as String;
  });
  when(() => storage.delete(key: any(named: 'key'))).thenAnswer(
    (Invocation i) async => data.remove(i.namedArguments[#key] as String),
  );
  when(storage.deleteAll).thenAnswer((_) async => data.clear());
  return SecureStore(storage: storage);
}
