/// App-wide configuration. Single place to flip demo/mock behaviour.
///
/// Source of truth for the working app name and environment flags.
/// Real backend wiring happens in Phase 8+ by flipping [useMockApi] and
/// overriding providers in `data/repositories/repository_providers.dart`.
class AppConfig {
  const AppConfig._();

  /// Working app name shown on splash, login hero and app bars.
  static const String appName = 'RoadOps';

  /// Target application id for release builds.
  /// TODO(Phase 8): align android/app/build.gradle[.kts] applicationId,
  /// iOS bundle id and Google Maps key with this id.
  static const String packageId = 'com.yourcompany.roadops';

  /// Demo build flag. When true the login page shows the tappable
  /// "Demo accounts" panel and Profile shows demo tools.
  static const bool demo = true;

  /// Always true until the real API phase. UI code must never branch on this
  /// directly; repository providers encapsulate the mock/real switch.
  static const bool useMockApi = true;

  /// Demo-tools toggle (Profile, Phase 6): ~3% of mock calls fail to
  /// exercise error + retry states on every screen.
  static const bool chaosMode = false;
}
