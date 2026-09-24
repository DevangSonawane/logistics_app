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
  /// Single source of truth for rebranding: this value is mirrored in
  /// android/app/build.gradle.kts (namespace + applicationId) and the iOS
  /// PRODUCT_BUNDLE_IDENTIFIER. Replace "yourcompany" in all three places.
  /// TODO(Phase 8): align the Google Maps key with this id.
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

  /// Flip to true once a Google Maps API key is configured (android
  /// manifest + iOS AppDelegate). Until then live maps render the
  /// static MapPlaceholder fallback and never crash.
  static const bool mapsEnabled = false;
}
