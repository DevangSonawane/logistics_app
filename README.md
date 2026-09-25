# RoadOps — Logistics App (Flutter, frontend + mock data)

Single Flutter app, one login, **six role-based experiences**: Driver, Owner,
Ops/Dispatcher, Sales, Supervisor, Accountant. All data flows through
repository interfaces with `Mock*` implementations and artificial latency —
swapping in the real API later means changing one provider file, no UI edits.

> Build spec: `Logistics_Flutter_App_Build_Prompt.md` (source of truth).
> Working rules: `AGENTS.md`.

## Stack

Flutter 3.47 / Dart 3.13 · `flutter_riverpod` 3.x (codegen) · `go_router` 18
(role-guarded `StatefulShellRoute`s per role) · `freezed` + `json_serializable`
· Hive (session, cache, offline queue, GPS track) · `flutter_secure_storage`
(tokens, app PIN) · Dio (future API client, mocked now).

## Run

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter run
```

Device integration tests (`integration_test/`) need the SDK package
temporarily: add `integration_test: {sdk: flutter}` to dev_dependencies,
`flutter pub get`, run, then remove it again — shipping it breaks the
release javac step (its Android plugin isn't on the release classpath).

Verify:

```bash
flutter analyze        # must report no issues
flutter test --concurrency=1 --timeout 90s   # full suite (unit + widget)
```

`--concurrency=1` matters on 8 GB machines: each widget file boots the whole
app and parallel tester processes get OOM-killed.

## Demo accounts (OTP for all: `123456`, expired: `000000`)

| Role | Name | Phone | Lands on |
|---|---|---|---|
| Driver | Ramesh Yadav | `9000000001` | Permissions → Driver home (running trip) |
| Driver | Suresh Patil | `9000000002` | Permissions → Driver home (trip offer) |
| Driver | Murugan K | `9000000003` | Permissions → Driver home (empty state) |
| Owner | Anil Mehta | `9000000011` | Permissions → Biometric → Owner home |
| Ops | Priya Nair | `9000000021` | Permissions → Biometric → Ops home |
| Sales | Karan Shah | `9000000031` | Permissions → Biometric → Sales home |
| Supervisor | Vijay Gaikwad | `9000000041` | Permissions → Biometric → Supervisor home |
| Accountant | Neha Kulkarni | `9000000051` | Permissions → Biometric → Accountant home |
| Multi | Rajesh Iyer | `9000000099` | Role picker → … |

Consignee POD OTP: `4321`. Lock screen demo PIN: `1234`.
Invalid phone: `1234567890`. Blocked: `9000000000`.
The login page shows a tappable demo-accounts panel (`AppConfig.demo`).

## Architecture (text diagram)

```
UI (features/<role>/… + core/widgets design system)
  ↓ Riverpod providers (@riverpod / Notifier)
Repositories (data/repositories/*.dart abstract + mock_*.dart)
  ↓ mock_delay() latency + chaos flag
Seed (data/mock/*.dart)   ←── swap point: repository_providers.dart
```

- Offline: every driver/supervisor mutation applies optimistically, enqueues a
  typed `OfflineAction` in Hive, uploads immediately when online; `SyncController`
  drains FIFO (connectivity regain, 60 s poll, manual) with exponential backoff.
  Server (Ops) wins conflicts → action rejected + dialog + refresh.
- GPS: foreground service + persistent notification while a trip is Started;
  battery-aware cadence; points in Hive, uploaded in batches of 5.
- Strings: ARB only (`lib/core/l10n`). Colors/spacing/type: theme tokens only.
- Roles are router-enforced (`role_guard.dart`); `/driver/*` is unreachable for
  other roles (403 page), deep links included.

## Swap mock → real API

1. Implement `XxxRepository` against Dio (`core/network/api_client.dart`,
   `api_endpoints.dart` documents the contract).
2. Change the provider in `data/repositories/repository_providers.dart`.
3. Flip `AppConfig.useMockApi`. UI code does not change.

## Add a language

1. Add `app_xx.arb` in `lib/core/l10n/` (`@@locale` + translated keys;
   missing keys fall back to English).
2. Add `Locale('xx')` to `supportedLocales` (`locale_provider.dart`) and to the
   language pickers. No restart needed — UI switches instantly.

## Known limitations (all have TODOs in code)

- No real backend/OTP/SMS/FCM/e-way/GST/WhatsApp-Business/Bluetooth-printer/
  gateway/Tally — all mocked or stubbed behind services.
- `AppConfig.mapsEnabled = false` until a Maps key is configured (static
  fallback, never crashes). `FLAG_SECURE` + Bluetooth printer: Phase 8 TODOs.
- Fonts load at runtime via `google_fonts`; bundling Noto/PlusJakarta under
  `assets/fonts/` for offline drivers is a TODO.
- Translations beyond English/Hindi core strings are best-effort; get a native
  review before release. `en_IN` renders September as "Sept" and lowercase
  am/pm (normalized to AM/PM in `Formatters`).
- Widget tests use in-memory boxes/secure-storage fakes; Hive file writes
  never complete in FakeAsync (documented in `test/helpers/`).
