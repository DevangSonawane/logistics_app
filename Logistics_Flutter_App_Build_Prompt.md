# LOGISTICS APP: FLUTTER BUILD PROMPT (FRONTEND, MOCK DATA, SINGLE APP, 6 ROLE MODES)

> **How to use this document:** Paste this whole file into your AI coding tool (Claude Code, Cursor, etc.) or hand it to your Flutter developer. It is a complete build spec: stack, packages, folder structure, design system, every screen, demo credentials, mock data, flows and acceptance criteria. Build **frontend only** with a mock data layer that can later be swapped for the real API without touching UI code.

---

## 0. ROLE OF THE BUILDER (PROMPT PREAMBLE)

You are a senior Flutter engineer. Build a production-quality **single Flutter application** for an Indian logistics / transport company (FTL trucking, PTL parcel, own fleet + market/hired vehicles). One app, one login, **six role-based experiences**: Driver, Owner, Ops/Dispatcher, Sales, Supervisor, Accountant.

Hard rules:
1. Flutter stable (3.24+), Dart 3.5+, null safety, `flutter_lints` strict.
2. **Clean architecture, feature-first.** Each role is an isolated module. A driver must never load staff code paths (lazy route loading + role-gated router).
3. **Repository pattern with mock implementations.** Every repository is an abstract class; `Mock*Repository` returns realistic data with artificial latency (300-900 ms). Switching to real API later = change one provider override.
4. **No hard-coded strings in widgets.** All text via `AppLocalizations` (ARB). Ship English + Hindi fully; other languages (Marathi, Tamil, Telugu, Kannada, Bengali, Punjabi) with at least the core driver strings translated, remaining keys falling back to English.
5. **No hard-coded colors, sizes or text styles in widgets.** Only via theme tokens (Section 4).
6. Every screen has **loading (skeleton/shimmer), empty, error+retry** states.
7. Driver mode: min tap target 56 dp, primary buttons 64 dp tall, minimal text, icons + words, works offline.
8. Support light and dark theme. Support phones 360x640 up to tablets (responsive).
9. Code must compile with zero analyzer warnings. Provide a README with run steps.

---

## 1. PRODUCT SUMMARY

| Item | Detail |
|---|---|
| App name | **RoadOps** (working name, configurable in one constant) |
| Package id | `com.yourcompany.roadops` |
| Platforms | Android first (min SDK 23 / Android 6), iOS 13+ for owner/management |
| Users | Created by admin only. No self sign-up |
| Login | Phone number + OTP for **everyone** |
| Languages | English, Hindi, Marathi, Tamil, Telugu, Kannada, Bengali, Punjabi |
| Offline | Full offline queue for **Driver mode**. Staff modes online-only (except Supervisor scanning, which queues) |
| Key principle | The **trip** is the centre. Every cost, document and status attaches to a trip |

---

## 2. TECH STACK AND PACKAGES

### 2.1 Architecture choices
- **State management:** `flutter_riverpod` + `riverpod_annotation` + `riverpod_generator` (code-gen providers)
- **Routing:** `go_router` with role-based redirect guards and `ShellRoute` per role
- **Models:** `freezed` + `json_serializable` (immutable models, unions for states)
- **Local DB / offline queue:** `hive_flutter` (fast key-value) for cache, session and the offline action queue (each queued action is a typed JSON object)
- **Networking (future-ready):** `dio` with interceptors (auth, retry, logging). Mocked now.
- **DI:** Riverpod providers only. No GetIt.

### 2.2 `pubspec.yaml` (use latest compatible versions; the values below are minimums)

```yaml
name: roadops
description: Logistics app - Driver, Owner, Ops, Sales, Supervisor, Accountant
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.5.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  # State, routing, models
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5
  go_router: ^14.2.0
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0
  equatable: ^2.0.5
  collection: ^1.18.0
  intl: ^0.19.0

  # Storage / network
  hive_flutter: ^1.1.0
  shared_preferences: ^2.3.2
  flutter_secure_storage: ^9.2.2
  dio: ^5.7.0
  connectivity_plus: ^6.0.5
  path_provider: ^2.1.4
  uuid: ^4.5.0

  # UI / design
  google_fonts: ^6.2.1
  flutter_svg: ^2.0.10+1
  lottie: ^3.1.2
  shimmer: ^3.0.0
  cached_network_image: ^3.4.1
  iconsax_flutter: ^1.0.0
  fl_chart: ^0.69.0
  smooth_page_indicator: ^1.2.0+3
  flutter_animate: ^4.5.0
  gap: ^3.0.1
  pinput: ^5.0.0                # OTP input
  slide_to_act: ^2.0.2          # slide-to-confirm (status change)
  animated_bottom_navigation_bar: ^1.4.0
  flutter_slidable: ^3.1.1
  toastification: ^2.3.0
  skeletonizer: ^1.4.2

  # Maps / location
  google_maps_flutter: ^2.9.0
  geolocator: ^13.0.1
  geocoding: ^3.0.0
  flutter_foreground_task: ^8.10.4   # keeps driver GPS alive in background (Android foreground service)
  url_launcher: ^6.3.0               # call, WhatsApp, Google Maps navigation

  # Device features
  permission_handler: ^11.3.1
  image_picker: ^1.1.2
  camera: ^0.11.0+2
  image: ^4.2.0                      # compression / resize before queueing
  flutter_image_compress: ^2.3.0
  signature: ^5.5.0                  # e-signature for POD
  mobile_scanner: ^5.2.3             # barcode / QR scan (supervisor, PTL)
  speech_to_text: ^7.0.0             # driver voice commands (Hindi etc.)
  record: ^5.1.2                     # voice notes
  local_auth: ^2.3.0                 # biometric lock (staff)
  flutter_local_notifications: ^17.2.2
  firebase_core: ^3.4.0              # FCM prepared, mocked in demo
  firebase_messaging: ^15.1.0
  share_plus: ^10.0.2                # share PDFs to WhatsApp
  pdf: ^3.11.1                       # generate LR / quote / receipt PDFs locally
  printing: ^5.13.2
  open_filex: ^4.5.0
  file_picker: ^8.1.2
  battery_plus: ^6.1.0
  device_info_plus: ^10.1.2
  package_info_plus: ^8.0.2
  flutter_native_splash: ^2.4.1
  flutter_launcher_icons: ^0.14.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
  flutter_lints: ^4.0.0
  build_runner: ^2.4.12
  freezed: ^2.5.7
  json_serializable: ^6.8.0
  riverpod_generator: ^2.4.3
  custom_lint: ^0.6.7
  riverpod_lint: ^2.3.13
  mocktail: ^1.0.4

flutter:
  uses-material-design: true
  generate: true          # for gen_l10n
  assets:
    - assets/images/
    - assets/icons/
    - assets/lottie/
    - assets/mock/
  fonts: []                 # fonts loaded via google_fonts (bundle Noto Sans Indic files offline in assets/fonts for driver reliability)
```

> Note: for **offline-safe fonts** (drivers have poor network), download `PlusJakartaSans` and `NotoSans` + Noto Sans Devanagari/Tamil/Telugu/Kannada/Bengali/Gurmukhi and bundle them in `assets/fonts/`, then register them under `fonts:`. Do not rely on runtime download.

### 2.3 Commands
```bash
flutter create --org com.yourcompany --project-name roadops --platforms android,ios .
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
dart run flutter_native_splash:create
dart run flutter_launcher_icons
flutter run
```

### 2.4 Android setup (`android/app/src/main/AndroidManifest.xml`)
Permissions: `INTERNET`, `ACCESS_NETWORK_STATE`, `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION`, `ACCESS_BACKGROUND_LOCATION`, `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_LOCATION`, `CAMERA`, `RECORD_AUDIO`, `POST_NOTIFICATIONS`, `USE_BIOMETRIC`, `VIBRATE`, `REQUEST_IGNORE_BATTERY_OPTIMIZATIONS`, `CALL_PHONE`, `BLUETOOTH_CONNECT`, `BLUETOOTH_SCAN`.
Register the `flutter_foreground_task` service with `foregroundServiceType="location"`. Set `minSdkVersion 23`, `targetSdkVersion 34`, `compileSdkVersion 34`, `multiDexEnabled true`. Add the Google Maps API key placeholder `YOUR_MAPS_KEY`.

### 2.5 iOS setup (`Info.plist`)
Add usage strings: `NSLocationWhenInUseUsageDescription`, `NSLocationAlwaysAndWhenInUseUsageDescription`, `NSCameraUsageDescription`, `NSMicrophoneUsageDescription`, `NSSpeechRecognitionUsageDescription`, `NSFaceIDUsageDescription`, `NSPhotoLibraryUsageDescription`. Enable Background Modes: Location updates, Remote notifications.

---

## 3. FOLDER STRUCTURE (create exactly this)

```
roadops/
├── pubspec.yaml
├── l10n.yaml
├── analysis_options.yaml
├── README.md
├── assets/
│   ├── fonts/
│   ├── images/            # logo.svg, onboarding_*.svg, truck_*.png, empty_*.svg
│   ├── icons/
│   ├── lottie/            # success.json, loading_truck.json, offline.json, sos.json
│   └── mock/              # optional json fixtures
├── lib/
│   ├── main.dart                     # bootstrap: Hive init, ProviderScope, runApp
│   ├── app.dart                      # MaterialApp.router, theme, locale, router
│   ├── bootstrap.dart
│   │
│   ├── core/
│   │   ├── config/
│   │   │   ├── app_config.dart       # app name, env flags, useMockApi = true
│   │   │   └── constants.dart        # OTP length, timeouts, GPS interval, image max size
│   │   ├── theme/
│   │   │   ├── app_colors.dart       # tokens (Section 4)
│   │   │   ├── app_typography.dart
│   │   │   ├── app_spacing.dart      # spacing + radius + elevation tokens
│   │   │   ├── app_theme.dart        # light + dark ThemeData
│   │   │   └── driver_theme.dart     # oversized variant for driver mode
│   │   ├── router/
│   │   │   ├── app_router.dart       # GoRouter provider
│   │   │   ├── route_names.dart
│   │   │   └── role_guard.dart       # redirect logic by auth state + role
│   │   ├── l10n/
│   │   │   ├── app_en.arb  app_hi.arb  app_mr.arb  app_ta.arb
│   │   │   ├── app_te.arb  app_kn.arb  app_bn.arb  app_pa.arb
│   │   │   └── locale_provider.dart
│   │   ├── network/
│   │   │   ├── api_client.dart       # dio with interceptors (unused while mock)
│   │   │   ├── api_endpoints.dart
│   │   │   └── connectivity_provider.dart
│   │   ├── storage/
│   │   │   ├── hive_boxes.dart
│   │   │   ├── secure_store.dart     # tokens
│   │   │   └── session_store.dart
│   │   ├── offline/
│   │   │   ├── offline_action.dart   # model: id, type, payload, attachments, createdAt, retries, status
│   │   │   ├── offline_queue.dart    # Hive-backed FIFO queue
│   │   │   ├── sync_engine.dart      # runs on connectivity regain + app resume + manual
│   │   │   └── sync_status_provider.dart
│   │   ├── services/
│   │   │   ├── location_service.dart          # foreground + background GPS
│   │   │   ├── background_gps_service.dart    # foreground task handler
│   │   │   ├── permission_service.dart
│   │   │   ├── biometric_service.dart
│   │   │   ├── notification_service.dart
│   │   │   ├── image_service.dart             # capture + compress (max 1280px, q70, <300KB)
│   │   │   ├── voice_service.dart             # STT + recorder
│   │   │   ├── pdf_service.dart
│   │   │   └── share_service.dart
│   │   ├── utils/
│   │   │   ├── formatters.dart       # INR (₹ 1,23,456 Indian grouping), dates, distance, duration
│   │   │   ├── validators.dart       # phone, GSTIN, PAN, vehicle no., OTP
│   │   │   ├── extensions.dart
│   │   │   └── debouncer.dart
│   │   └── widgets/                  # SHARED design-system widgets (Section 5)
│   │       ├── app_button.dart        ├── app_text_field.dart
│   │       ├── app_card.dart          ├── status_chip.dart
│   │       ├── kpi_card.dart          ├── section_header.dart
│   │       ├── empty_state.dart       ├── error_state.dart
│   │       ├── skeleton_list.dart     ├── offline_banner.dart
│   │       ├── sync_pill.dart         ├── photo_capture_sheet.dart
│   │       ├── otp_input.dart         ├── search_bar.dart
│   │       ├── bottom_nav_bar.dart    ├── app_scaffold.dart
│   │       ├── confirm_dialog.dart    ├── slide_confirm.dart
│   │       ├── avatar.dart            ├── timeline_tile.dart
│   │       ├── map_placeholder.dart   └── amount_text.dart
│   │
│   ├── data/
│   │   ├── models/                   # freezed models (Section 7)
│   │   ├── mock/
│   │   │   ├── mock_data.dart        # all seed data (Section 8)
│   │   │   ├── mock_delay.dart
│   │   │   └── mock_users.dart       # demo credentials (Section 9)
│   │   └── repositories/
│   │       ├── auth_repository.dart          + mock_auth_repository.dart
│   │       ├── trip_repository.dart          + mock_trip_repository.dart
│   │       ├── order_repository.dart         + mock_order_repository.dart
│   │       ├── vehicle_repository.dart       + mock...
│   │       ├── driver_repository.dart        + mock...
│   │       ├── expense_repository.dart       + mock...
│   │       ├── advance_repository.dart       + mock...
│   │       ├── approval_repository.dart      + mock...
│   │       ├── lead_repository.dart          + mock...
│   │       ├── quote_repository.dart         + mock...
│   │       ├── customer_repository.dart      + mock...
│   │       ├── finance_repository.dart       + mock...
│   │       ├── hub_repository.dart           + mock...
│   │       ├── dashboard_repository.dart     + mock...
│   │       ├── notification_repository.dart  + mock...
│   │       └── repository_providers.dart     # single place to swap mock ↔ real
│   │
│   ├── features/
│   │   ├── splash/                   # splash_page.dart
│   │   ├── onboarding/               # language_select_page.dart
│   │   ├── auth/
│   │   │   ├── presentation/  login_page.dart, otp_page.dart, role_picker_page.dart,
│   │   │   │                  permissions_page.dart, biometric_setup_page.dart, lock_page.dart
│   │   │   └── application/   auth_controller.dart, session_provider.dart
│   │   ├── common/                   # shared across roles
│   │   │   ├── notifications/  notification_center_page.dart
│   │   │   ├── search/         global_search_page.dart
│   │   │   ├── profile/        profile_page.dart, settings_page.dart, language_settings_page.dart
│   │   │   ├── trip_detail/    trip_detail_page.dart (read-only variant, reused by roles)
│   │   │   └── pdf_viewer/     pdf_preview_page.dart
│   │   ├── driver/                   # DRIVER MODE
│   │   │   ├── shell/          driver_shell.dart (4 tabs)
│   │   │   ├── my_trip/        home (current trip card), trip_offer_page (accept/reject),
│   │   │   │                   status_flow_page, navigation launch helper
│   │   │   ├── pod/            pod_capture_page, e-signature, otp confirm, damage/shortage
│   │   │   ├── expenses/       add_expense_page, expense_list_page
│   │   │   ├── advances/       request_advance_page, advance_ledger_page
│   │   │   ├── earnings/       earnings_page, settlement_page, payslip_page
│   │   │   ├── documents/      driver_documents_page
│   │   │   ├── sos/            sos_page
│   │   │   ├── sync/           offline_queue_page
│   │   │   └── application/    driver_trip_controller.dart, gps_controller.dart
│   │   ├── owner/                    # OWNER MODE
│   │   │   ├── shell/ owner_shell.dart (5 tabs)
│   │   │   ├── dashboard/  owner_dashboard_page.dart (+ kpi widgets, charts)
│   │   │   ├── approvals/  approvals_inbox_page.dart, approval_detail_sheet.dart
│   │   │   ├── accounts/   accounts_home_page, ledger_page, ageing_page, pnl_page, daybook_page
│   │   │   ├── live_map/   live_map_page.dart
│   │   │   └── brief/      daily_brief_page.dart
│   │   ├── ops/                      # OPS / DISPATCHER MODE
│   │   │   ├── shell/ ops_shell.dart (5 tabs)
│   │   │   ├── orders/     order_list_page, create_order_page (stepper), order_detail_page
│   │   │   ├── planning/   plan_trip_page (order → vehicle → driver wizard)
│   │   │   ├── trips/      live_trips_page, trip_control_page (call driver, update status, advance, e-way, share link)
│   │   │   ├── exceptions/ exceptions_feed_page.dart
│   │   │   └── market/     hire_vehicle_page, hire_memo_page, pay_advance_page
│   │   ├── sales/                    # SALES MODE
│   │   │   ├── shell/ sales_shell.dart (5 tabs)
│   │   │   ├── leads/      lead_list_page (list+kanban toggle), add_lead_page (voice + card scan), lead_detail_page
│   │   │   ├── visits/     visit_plan_page, check_in_page
│   │   │   ├── quotes/     lane_rate_lookup_page, quick_quote_page, quote_preview_page
│   │   │   ├── customers/  customer_360_page (read-only)
│   │   │   └── targets/    targets_page.dart
│   │   ├── supervisor/               # LOADING / HUB SUPERVISOR MODE
│   │   │   ├── shell/ supervisor_shell.dart (4 tabs)
│   │   │   ├── today/      loadings_arrivals_page.dart
│   │   │   ├── gate/       gate_entry_page.dart (in/out)
│   │   │   ├── loading/    loading_flow_page.dart (start/end photos, seal no., weighment slip)
│   │   │   ├── scan/       scan_packages_page.dart, manifest_page.dart, shortage_damage_page.dart
│   │   │   └── lr_print/   lr_print_page.dart (PDF + optional Bluetooth)
│   │   └── accountant/               # ACCOUNTANT MODE
│   │       ├── shell/ accountant_shell.dart (4 tabs)
│   │       ├── home/       accounts_summary_page.dart
│   │       ├── ledgers/    customer_ledger, vendor_ledger, ageing, bank_balances, daybook, gst_summary
│   │       ├── invoices/   invoice_list_page, invoice_pdf_page
│   │       ├── approvals/  payments_expenses_approval_page.dart
│   │       ├── reminders/  send_reminder_page.dart
│   │       └── receipts/   record_receipt_page.dart (permission gated)
│   │
│   └── generated/            # build_runner output (gitignored optional)
│
├── test/
│   ├── unit/           validators_test, formatters_test, offline_queue_test, sync_engine_test
│   ├── widget/         login_flow_test, driver_status_flow_test, approvals_test
│   └── mocks/
└── integration_test/
    └── driver_happy_path_test.dart
```

---

## 4. DESIGN SYSTEM (TRENDY 2025 PALETTE)

**Design direction:** "Modern fintech-meets-logistics." Deep midnight base, electric indigo primary, neon lime accent for the single most important action per screen, soft glass-like cards, generous rounding, bold numerals for KPIs. Clean, high-contrast, works outdoors in sunlight for drivers.

### 4.1 Color tokens (`app_colors.dart`)

**Light theme**

| Token | Hex | Use |
|---|---|---|
| `primary` | `#5B5BF0` | Electric Indigo: brand, links, active nav |
| `primaryDark` | `#3D3DD1` | Pressed, gradients |
| `primaryContainer` | `#E8E8FF` | Tinted backgrounds, selected chips |
| `accent` | `#C6F432` | Neon Lime: primary CTA on dark surfaces, highlights |
| `onAccent` | `#0B1020` | Text on lime |
| `secondary` | `#00C2A8` | Teal: secondary actions, "on time" |
| `background` | `#F6F7FB` | App background |
| `surface` | `#FFFFFF` | Cards |
| `surfaceAlt` | `#EEF0F7` | Inputs, list striping |
| `ink` | `#0B1020` | Primary text (midnight) |
| `inkMuted` | `#5A6180` | Secondary text |
| `inkFaint` | `#9AA0BC` | Hints, disabled |
| `border` | `#E3E6F0` | Dividers |
| `success` | `#12B981` | Delivered, approved |
| `warning` | `#F59E0B` | Delay, pending |
| `danger` | `#F43F5E` | Overdue, SOS, rejected |
| `info` | `#3B82F6` | In transit, info |

**Dark theme**

| Token | Hex |
|---|---|
| `background` | `#0B1020` |
| `surface` | `#141A33` |
| `surfaceAlt` | `#1C2444` |
| `ink` | `#F4F6FF` |
| `inkMuted` | `#A5ACCB` |
| `border` | `#2A3358` |
| `primary` | `#8080FF` |
| `accent` | `#C6F432` (unchanged) |

**Gradients**
- `heroGradient`: `#5B5BF0 → #8E5BFF` (top-left → bottom-right) for owner dashboard header and login hero
- `darkHeroGradient`: `#0B1020 → #1E1B4B`
- `limeGlow`: `#C6F432 → #9BE21A` for the driver primary button

**Status colors (`StatusChip`)**

| Status | Color |
|---|---|
| Pending / Planned | `warning` |
| Assigned | `info` |
| Running / In Transit | `primary` |
| Delayed | `danger` |
| Delivered / Approved | `success` |
| POD Pending | `#F97316` orange |
| Closed / Draft | `inkFaint` |

**Role accent** (subtle tint on shell app-bar and avatar ring)

| Role | Accent |
|---|---|
| Driver | `#C6F432` lime |
| Owner | `#8E5BFF` violet |
| Ops | `#5B5BF0` indigo |
| Sales | `#FF7A59` coral |
| Supervisor | `#00C2A8` teal |
| Accountant | `#3B82F6` blue |

### 4.2 Typography (`app_typography.dart`)
- Headings and numerals: **Plus Jakarta Sans** (700/800)
- Body: **Inter** (400/500/600)
- Indic scripts fallback: **Noto Sans <script>**
- Scale (sp): Display 32/800, H1 24/700, H2 20/700, H3 18/600, Body 15/400, BodyStrong 15/600, Caption 12/500, KPI number 28/800 (tabular figures), Driver Button 20/800.
- Driver mode multiplies body sizes by 1.15 (`driver_theme.dart`).

### 4.3 Shape, spacing, elevation (`app_spacing.dart`)
- Spacing scale: 4, 8, 12, 16, 20, 24, 32, 40
- Radius: chips 999, buttons 16, cards 20, bottom sheets 28 (top), inputs 14
- Cards: no heavy shadows. Use 1 px `border` plus `0 8 24 rgba(11,16,32,0.06)` soft shadow (light); border only (dark)
- Screen padding 16 (20 on tablets)
- Motion: 200-300 ms `Curves.easeOutCubic`; page transitions fade+slide-up; use `flutter_animate` for KPI count-up and list stagger. Respect the "reduce motion" system setting.

### 4.4 Iconography
`iconsax_flutter` (linear style) for staff modes; filled Material icons plus text for driver buttons.

### 4.5 Component specs (`core/widgets`)
- **AppButton**: variants `primary` (indigo), `accent` (lime, on dark), `secondary` (outlined), `danger`, `text`. Sizes `md` 52 dp, `lg` 64 dp (driver). Loading spinner state. Full-width option.
- **AppTextField**: filled `surfaceAlt`, 14 radius, floating label, error text, prefix icon, `+91` prefix variant for phone.
- **KpiCard**: label (caption), animated big number, delta chip (▲ green / ▼ red), mini sparkline (`fl_chart`), tinted icon bubble.
- **StatusChip**: pill, tinted background at 12% of the status color, text in the status color.
- **SlideConfirm**: slide-to-act for critical driver status changes (Reached / Started / Delivered) to prevent accidental taps.
- **OfflineBanner**: appears under the app bar when no connectivity ("You're offline. Updates will sync automatically."). **SyncPill** shows the count of pending items and taps to open the queue page.
- **PhotoCaptureSheet**: bottom sheet, camera or gallery, preview, retake, compress, returns `File`.
- **TimelineTile**: vertical stepper for trip status with timestamp, photo thumbnail and GPS pin.
- **AmountText**: renders `₹1,23,456` (Indian grouping). Lakh/crore short form (`₹12.4 L`, `₹1.2 Cr`) for KPIs.

---

## 5. NAVIGATION AND ROLE ROUTING

- `go_router` with a `redirect` function evaluating in this order: `!onboardingDone → /language`, `!loggedIn → /login`, `needsRolePick → /role-picker`, `!permissionsDone → /permissions`, `staff && !biometricSetup → /biometric-setup`, `locked → /lock`, else `/{role}/home`.
- Each role has its own `ShellRoute` and bottom navigation. A route under `/driver/*` is inaccessible to other roles (guard returns `/403` page). **The router, not the UI, enforces this.**
- Deep links: `roadops://trip/{id}`, `roadops://approval/{id}`, `roadops://lead/{id}`, `roadops://invoice/{id}`.
- Bottom navigation per role:

| Role | Tabs |
|---|---|
| Driver | My Trip · Earnings · Documents · Profile (SOS as a persistent floating red button on My Trip) |
| Owner | Dashboard · Approvals (badge) · Accounts · Live Map · More |
| Ops | Orders · Plan · Live Trips · Exceptions (badge) · More |
| Sales | Leads · Visits · Quote · Customers · More |
| Supervisor | Today · Gate · Scan · Manifest · More |
| Accountant | Summary · Ledgers · Invoices · Approvals (badge) · More |

"More" (staff) → Notifications, Search, Profile, Settings, Language, Switch Role, Switch Company/Branch, Help, Logout.

---

## 6. END-TO-END FLOW (LOGIN → LOGOUT)

### 6.1 Common start
1. **Splash** (1.2 s, logo animation). Check the Hive session.
2. **Language select** (first launch only): 8 language cards with native script names (हिन्दी, मराठी, தமிழ், తెలుగు, ಕನ್ನಡ, বাংলা, ਪੰਜਾਬੀ, English). Saved. Changeable in Settings.
3. **Login**: phone field (+91, 10 digits, validated). CTA "Get OTP" → mock sends OTP.
4. **OTP page**: 6-digit `pinput`, 30 s resend timer, auto-submit on 6 digits, error shake on wrong OTP, max 5 attempts then a 5-minute lockout message.
5. **Role resolution**: one role → go to permissions. Multiple roles → **Role picker** (cards with role icons; the last used role is pre-selected).
6. **Permissions** (role-based, one card at a time with a "why we need this" line):
   - Driver: Notifications → Camera → Location (While in use → Always, with the disclosure screen: "RoadOps collects location data to track your trip even when the app is closed or not in use." with an **Accept / Deny** button. This satisfies Google Play's prominent-disclosure requirement) → Battery optimisation exemption → Microphone
   - Sales: Notifications, Camera, Microphone, Location (while in use)
   - Supervisor: Notifications, Camera (scanning)
   - Ops/Owner/Accountant: Notifications (camera optional)
7. **Biometric setup** (staff only): enable fingerprint/face or skip to a 4-digit app PIN. Drivers skip this.
8. **Role home** (Section 7).

### 6.2 During use
- App resume after > 2 min in background (staff) → **Lock page** (biometric/PIN). Accountant-side session timeout: 5 min idle, blurred content on the app switcher (`FLAG_SECURE` on Android for finance screens).
- Notification tap → deep link to the right screen (respecting the lock).
- Connectivity lost → OfflineBanner; driver actions go to the queue automatically.

### 6.3 Logout
- Profile → Logout → confirm dialog.
- **Driver blockers:** if a trip is running → "You have a running trip. Please complete or ask Ops to close it before logging out." (block). If unsynced items exist → "X items are not uploaded yet. Connect to the internet and sync before logging out." with **Sync now** and **View queue** buttons (block until 0 pending; long-press "Force logout" is only available in demo builds).
- Staff: confirm → clear secure storage, session, cached data, revoke the push token, stop the GPS service, return to `/login`.
- Keep language choice and the "onboarding done" flag.

---

## 7. SCREEN-BY-SCREEN SPEC

> Every screen: use `AppScaffold`, skeleton loading, empty/error states, pull-to-refresh where a list. All data via Riverpod providers → repositories → mock data.

### 7.1 DRIVER MODE (highest priority, build first)

Theme: `driver_theme.dart`. Dark hero header with lime accents, giant buttons, icon + text, Hindi-first if the language is chosen.

**D1. My Trip (home)**
- Header: greeting "Namaste, Ramesh 👋", vehicle no. chip, connectivity + SyncPill.
- **State A: No trip assigned:** Lottie truck, "No trip right now. We'll notify you." plus Refresh.
- **State B: New trip offered:** big card (pickup → drop, distance, freight allowance, pickup time). Buttons: **ACCEPT** (lime, 64 dp) and **REJECT** (opens reason sheet: Vehicle issue / Health / Personal / Route not known / Other + free text). Reason is required.
- **State C: Active trip card:** trip no., customer, route with a vertical dot line: Pickup (address, contact name with one-tap 📞), Drop (address, contact with 📞). Buttons: **Navigate** (opens Google Maps via `url_launcher` with the destination lat/lng), **LR / E-way bill** (opens the document viewer), **Add Expense**, **Request Advance**.
- **Big status action** at the bottom, sticky, showing only the NEXT step, as a slide-to-confirm: `Reached Pickup → Loading Done → Start Trip → Reached Drop → Unloaded`. Each step opens the **photo capture** (mandatory), then confirm. On confirm: write to the local trip state immediately (optimistic), queue the action with the photo + GPS + timestamp, show a success Lottie.
- Timeline of the completed steps with thumbnails and times.
- Floating **SOS** button (red, bottom-left) → SOS page.
- After "Unloaded" → **POD** prompt.

**D2. POD capture**
- Step 1: photo of the signed LR (camera, edge overlay guide).
- Step 2: consignee confirmation: **Option A:** enter the 4-digit OTP the consignee received (demo OTP `4321`) **or Option B:** consignee e-signature (`signature` package) plus name.
- Step 3 (optional toggle "Any damage or shortage?"): remark, quantity, up to 4 photos.
- Submit → queued → trip status "Delivered, POD submitted". Shows the earnings preview.

**D3. Add Expense**
- Type grid (big icon tiles): Diesel, Toll, Repair, Loading, Police/RTO, Food, Other.
- Amount (numeric keypad, ₹), litres + rate for Diesel (auto-calculates), bill photo (required for > ₹100), note, voice note button.
- Shows a running "Advance balance" chip. If the amount is above the route norm, show a soft warning ("Above usual for this route. Ops may review").
- Save → queue.

**D4. Request Advance**: amount, purpose (Fuel / Toll / Repair / Food / Other), note. Shows the advance history list with status (Requested/Approved/Paid/Rejected). Status changes arrive via mock notification.

**D5. Earnings tab**: this month total, trip allowance list, incentives, settlement balance card (advance − expenses = payable/recoverable), salary slips list (PDF preview via `pdf`), trips done count, on-time %.

**D6. Documents tab**: cards for Driving Licence, RC, Insurance, Fitness, Permit, PUC with an expiry countdown chip (green > 30 d, amber ≤ 30, red ≤ 7 or expired). Tap → full-screen zoomable image. Available offline (cached).

**D7. SOS**: 3-second press-and-hold (or slide) to trigger; select the type (Breakdown / Accident / Medical / Threat / Other); sends location and queues if offline; shows "Ops has been alerted" plus a call-Ops button. Pulsing red animation. (Mock: creates an exception in the ops feed.)

**D8. Offline queue page** (also reachable from the SyncPill): list of pending actions with type icon, time, size, retry count, status (Pending/Uploading/Failed/Done). "Sync now" button. Failed items show the reason and Retry.

**D9. Profile/Settings**: language switcher, text size, voice commands toggle, help & call Ops, app version, logout.

**Voice (driver):** a mic button on the status action and the expense screen. `speech_to_text` with the locale for the chosen language. Recognise a small phrase set per language: "reached pickup", "loading done", "start", "reached drop", "unloading done" (Hindi examples: "सामान लोड हो गया", "अनलोडिंग हो गई"). On a match, show a confirmation chip "Mark 'Unloaded'? Yes/No" before applying. Never auto-apply without confirmation.

**Background GPS (`background_gps_service.dart`):**
- Starts **only** when a trip is `Started` and stops on `Unloaded/Delivered`.
- Foreground service with a persistent notification "RoadOps: Trip in progress".
- Interval: every 60 s normally, 180 s when battery < 20%, 300 s when < 10% (`battery_plus`).
- Each point: lat, lng, speed, accuracy, battery, timestamp → appended to a local Hive box (offline safe) → mock upload batches. Discard points with accuracy > 100 m.
- In the demo, simulate movement along a predefined route polyline so the owner/ops map shows a moving truck.

**Offline rules (driver):**
- Every mutating action creates an `OfflineAction {id(uuid), type, tripId, payload, attachments[], createdAt, retryCount, status}`; the UI applies it optimistically.
- Sync engine triggers: connectivity regained, app resume, manual, every 60 s while online and pending > 0. FIFO, retry with exponential backoff (5 s, 15 s, 45 s, 2 m, 5 m; max 8 tries → Failed).
- Photos compressed to a max edge of 1280 px, JPEG q70, EXIF stripped except GPS/time, saved in the app documents dir until uploaded.
- **Conflict rule:** the server (Ops) wins for trip reassignment/cancellation. If the driver acts on a trip that was cancelled, mark the action `Rejected: trip changed`, show a dialog, and refresh the trip. Status steps can't be skipped (validate order on both sides).
- Mock a flaky network with a **"Simulate offline"** toggle in the demo settings.

### 7.2 OWNER MODE

**O1. Dashboard**
- Hero gradient header: company/branch switcher chip (All Branches ▾), date range chips (Today / 7D / Month), bell with a badge.
- KPI grid (2 columns): **Trips today** (Running / Delayed / Delivered split as a segmented bar), **Revenue billed** (today / month), **Collections**, **Outstanding**, **Cash & Bank**, **Fleet utilisation %** (radial gauge).
- **Trend chart:** revenue vs collection, last 30 days (`fl_chart` line, gradient fill).
- **Top lanes** by margin (horizontal bars), **Bottom customers** by margin (flag red).
- **Attention strip:** horizontally scrolling cards: "3 trips delayed", "5 approvals waiting", "2 documents expiring", "POD pending > 24h: 4".
- "AI brief" card with the 9 AM summary text and a "Read full brief" link.
- **Ask your data** bar at the bottom: text/mic input, e.g. "Which customer gave the lowest margin last month?". Mock: keyword-matches to 4 canned answers with a small chart and shows a typing animation.

**O2. Approvals inbox**
- Filter chips: All / Advances / Expenses / Rate exceptions / Credit override / Vendor payments / Purchase.
- Card: type icon, requester, amount (bold), reason, age, and a risk flag (e.g. "Above norm by 22%").
- Tap → bottom sheet with details, attachments, history, comment field. Buttons: **Approve** (green), **Reject** (needs a comment), **Ask for info**. Swipe right = approve, left = reject (`flutter_slidable`) with an undo toast for 5 s.
- Bulk select mode for approving small items.
- Empty: "You're all caught up 🎉".

**O3. Accounts (view-only):** cards → Customer ledger, Vendor ledger, Ageing (0-30, 31-60, 61-90, 90+ stacked bar), P&L (by branch/vehicle/customer/lane switcher), Day book, Bank balances, GST summary, Trip P&L. Each list has search + date filter + "Share PDF".

**O4. Live map:** `google_maps_flutter` with markers by status colour, an exceptions filter, a bottom carousel of the selected trip (vehicle, driver, ETA, last update, call button). Cluster markers when zoomed out. If no Maps key is present, fall back to `MapPlaceholder` with a static list, and never crash.

**O5. Daily brief page:** date pager, sections (Trips, Money, Risks, Wins), a share to WhatsApp button.

**O6. Notification settings:** per alert type toggles (push/WhatsApp/in-app): large payment received, big delay, doc expiring, credit limit crossed.

### 7.3 OPS / DISPATCHER MODE

**P1. Orders list:** tabs Pending / Planned / Running / Completed, search, filters (customer, lane, date), FAB "+ New order".
**P2. Create order (stepper, 4 steps):** (1) Customer (search, recent) and type FTL/PTL, (2) Pickup and drop points (multi-stop, date-time window), (3) Cargo: commodity, weight, declared value, vehicle type (32 ft MXL, 20 ft, Tata Ace, Container, Reefer, Trailer), (4) Rate (auto-filled from the contract with a "below contract rate" warning banner), review, submit. "Paste WhatsApp message" button → mock AI parse of "2 trucks 32 ft Pune to Chennai tomorrow" that pre-fills the form (show a "AI filled – please verify" chip on parsed fields).
**P3. Plan trip wizard (simplified, 3 steps):** pick order → **vehicle suggestions** (ranked cards: location, capacity fit, next availability, docs valid ✓/✗, driver hours) → pick driver (licence validity check and an "already on a trip" block) → summary with route km, toll, diesel estimate, ETA → advance amount (optional) → **Assign & notify driver**. Return-load suggestion card at the end ("2 loads near Chennai drop").
**P4. Live trips:** list + map toggle, status chips, ETA vs planned, tap → **Trip control page**: timeline, call driver (one tap), update status on the driver's behalf (reason required), raise advance, attach/enter e-way bill no., share tracking link (WhatsApp share sheet), documents.
**P5. Exceptions feed:** delay vs ETA, long halt, route deviation, overspeed, device off, e-way bill expiring, POD pending, SOS (pinned red at the top). Each has quick actions (Call driver, Extend e-way, Escalate, Resolve with a note).
**P6. Market vehicles:** add a broker vehicle (vehicle no., owner, PAN, driver name/phone, KYC photos), create a **hire memo** (freight agreed, advance, balance on POD, deductions), pay the advance (creates an approval request if above the limit), hire memo PDF share.

### 7.4 SALES MODE

**S1. Leads:** List ↔ Kanban toggle (New → Contacted → Quoted → Negotiation → Won/Lost). Filters by source (Website, WhatsApp, IndiaMART, Justdial, IVR, Email, Walk-in, Referral). SLA timer chip ("First response due in 12 min").
**S2. Add lead:** company, contact, phone (duplicate detection: warn if the phone/GSTIN exists), origin/destination lane, commodity, weight, vehicle type, frequency, expected monthly trips, target rate. **Voice note button** (record, then mock transcription fills the notes) and a **business card scan** (camera → mock OCR fills company/name/phone).
**S3. Visits:** day route list, **check-in** (GPS coordinates + photo + note), **check-out**, outcome selection.
**S4. Quote:** lane rate lookup (from, to, vehicle) → rate card result (per trip/per ton, diesel clause note) → quick quote form (rate, extra charges: detention, loading, toll, ODA...) → PDF preview (`pdf` package, branded) → **Send via WhatsApp** (`share_plus` / `url_launcher` `wa.me`). Margin is **not** shown to sales; if the rate is under the floor, show "Needs approval".
**S5. Customer 360 (read-only):** overview, outstanding (so sales can nudge), orders, rates, contacts, "Remind payment" button.
**S6. Targets:** ring charts for revenue, new customers and trips vs target, with a leaderboard.

### 7.5 SUPERVISOR MODE

**V1. Today:** two tabs, Loadings and Arrivals, for their hub/godown; cards with vehicle no., customer, ETA, status.
**V2. Gate:** vehicle **Gate-in** (vehicle no. or scan, driver, time auto) and **Gate-out**, reporting-time delta chip.
**V3. Loading flow:** start (photo) → end (photo) → seal number (text and scan) → weighment slip photo (+ weight entry, with a mismatch warning against declared) → complete.
**V4. Scan (PTL):** `mobile_scanner` continuous scanning, a scanned list with count vs expected, duplicate beep/vibrate, mark shortage/damage with photo. Works offline via the queue.
**V5. Manifest:** create a manifest from the scanned items, destination hub, summary, share PDF.
**V6. LR print:** LR preview (company format, QR for tracking) → share/print via the `printing` package; optional Bluetooth printer section shown as "coming soon" (feature-flagged).

### 7.6 ACCOUNTANT MODE

**A1. Summary:** receivables, payables, cash/bank, GST summary tiles, "ready to bill" count.
**A2. Ledgers:** customer/vendor ledger (search, date range, running balance), ageing, bank balances, day book, GST summary.
**A3. Invoices:** list with status (Draft/Sent/Part-paid/Paid/Overdue), PDF viewer/share, and an "e-invoice IRN" status chip.
**A4. Approvals:** payments and expenses, Approve/Reject with a comment. Amount-limit rule shown ("Above your ₹50,000 limit → forwards to Owner").
**A5. Reminders:** overdue customers sorted by priority (AI badge "Likely to pay in 3 days"), a WhatsApp reminder template preview → send (mock success).
**A6. Record receipt** (visible only if the `canRecordReceipt` permission is true): customer, invoice(s), amount, mode, UTR, TDS deducted, short-pay reason.
Security: `FLAG_SECURE`, 5-minute idle timeout → lock page.

### 7.7 COMMON SCREENS
- **Notification centre:** grouped Today/Earlier, unread dot, type icons, deep link on tap, mark all read.
- **Global search:** Trips, LRs, Vehicles, Customers tabs with recents; debounced 300 ms.
- **Profile:** photo, name, role(s), phone, branch, language, theme (System/Light/Dark), biometric toggle, switch role, switch company/branch, app version, **Demo tools** (only when `AppConfig.demo` is true): Simulate offline, Reset demo data, Trigger sample notification, Advance trip simulation.
- **PDF preview** page: zoom, share, save.

---

## 8. DATA MODELS AND MOCK DATA

### 8.1 Models (freezed; put in `data/models`)
`AppUser{id,name,phone,roles[],activeRole,branchIds,avatarUrl,language,permissions}`, `Company/Branch`, `Customer{id,name,gstin,pan,creditDays,creditLimit,outstanding,contacts[]}`, `Lane{from,to,distanceKm,transitHrs}`, `Order{id,no,customerId,type(FTL/PTL),stops[],vehicleType,commodity,weightKg,declaredValue,rate,status}`, `Trip{id,no,orderId,customer,lane,vehicleId,driverId,status,plannedEta,liveEta,startedAt,steps[],lr,ewayBill,podStatus,revenue,cost,margin,advanceGiven,expenses[]}`, `TripStep{type,at,lat,lng,photoPath,note}`, `Vehicle{id,regNo,type,capacityTons,ownership(own/market),docs[],status,lastLocation,mileage}`, `VehicleDoc{type,number,expiry}`, `Driver{id,name,phone,licenseNo,licenseExpiry,rating,onTime%,languages}`, `Expense{id,tripId,type,amount,litres?,rate?,photoPath,note,status,normFlag}`, `Advance{id,tripId,amount,purpose,status,requestedAt}`, `ApprovalItem{id,type,requester,amount,reason,riskFlag,attachments,status,createdAt}`, `Lead{id,company,contact,phone,source,lane,commodity,vehicleType,frequency,expectedTrips,targetRate,stage,slaDue,notes}`, `Quote{id,leadId,lane,vehicleType,rate,charges[],validTill,status}`, `Invoice{id,no,customerId,amount,gst,status,dueDate,irn?}`, `LedgerEntry`, `AgeingBucket`, `ExceptionItem{id,type,tripId,severity,message,at,resolved}`, `AppNotification{id,title,body,type,deeplink,read,at}`, `OfflineAction`, `HubTask{id,type(loading/arrival),vehicleNo,customer,eta,status}`, `ScanItem`, `Manifest`, `HireMemo`.

### 8.2 Seed data (in `mock_data.dart`; make it realistic, Indian context)
- **Company:** "Shree Ganesh Roadlines Pvt Ltd", branches: Mumbai HQ, Pune, Chennai, Delhi.
- **Customers (8):** Tata Agrico Ltd, Reliance Retail, Asian Paints, Godrej Consumer, Havells India, Parle Products, Bajaj Auto, Amul Dairy. Include GSTINs in a valid 15-character format and credit terms 30-60 days.
- **Lanes (10):** Pune–Chennai (1,180 km), Mumbai–Delhi (1,420 km), Mumbai–Bengaluru (985 km), Pune–Hyderabad (560 km), Delhi–Jaipur (280 km), Chennai–Bengaluru (350 km), Ahmedabad–Mumbai (530 km), Nagpur–Pune (720 km), Kolkata–Patna (600 km), Indore–Mumbai (590 km).
- **Vehicles (15):** MH12 AB 1234, MH14 CD 5678, MH04 EF 9012, KA01 GH 3456, TN09 JK 7890, etc. Mix of own (10) and market (5), types 32 ft MXL/20 ft/Tata Ace/Container/Reefer/Trailer. Give a few docs expiring within 7 / 15 / 30 days.
- **Drivers (10):** Ramesh Yadav (Hindi), Suresh Patil (Marathi), Murugan K (Tamil), Ravi Kumar (Telugu), Basavaraj (Kannada), Sukhdev Singh (Punjabi), Abdul Rahman (Bengali) ...
- **Trips (25):** 6 running (2 delayed), 5 delivered POD-pending, 8 delivered/closed, 4 planned, 2 cancelled. Include lat/lng route polylines for the 6 running trips.
- **Orders (20), Leads (18)** across all stages and sources, **Quotes (6)**, **Invoices (20)** with mixed statuses, **Approvals (12)** of mixed types, **Exceptions (10)** including one SOS, **Notifications (15)**, **Ledger entries** for 5 customers, **Ageing** buckets (e.g. 0-30: ₹42.5 L, 31-60: ₹18.2 L, 61-90: ₹9.6 L, 90+: ₹4.1 L), **Hub tasks (10)**.
- **Owner KPIs:** Trips today 34 (Running 18, Delayed 4, Delivered 12); Revenue today ₹8.4 L, month ₹1.96 Cr; Collections month ₹1.62 Cr; Outstanding ₹74.4 L; Cash+Bank ₹41.2 L; Fleet utilisation 78%. A 30-day trend series with realistic noise.
- **Rate cards:** per lane and vehicle type (e.g. Pune–Chennai 32 ft MXL ₹78,500/trip; Mumbai–Delhi 32 ft MXL ₹96,000/trip), a diesel escalation note, and extra charges (detention ₹2,000/day, loading ₹1,500, multi-drop ₹2,500/point).
- All mock API calls go through `mockDelay()` (random 300-900 ms), with a 3% chance of a simulated failure when "chaos mode" is enabled in demo tools.

---

## 9. DEMO CREDENTIALS

**OTP for every account in demo: `123456`** (accept it for any of the accounts below; a wrong OTP shows an error; `000000` simulates an expired OTP).
Consignee POD OTP in demo: **`4321`**.
Bluetooth/biometric are simulated in demo (a "Use demo PIN `1234`" option on the lock page).

| Role | Name | Phone (enter without +91) | Notes |
|---|---|---|---|
| Driver | Ramesh Yadav | `9000000001` | Language hi, vehicle MH12 AB 1234, has an active running trip (Pune→Chennai) |
| Driver | Suresh Patil | `9000000002` | Language mr, has a **new trip offer** (tests accept/reject) |
| Driver | Murugan K | `9000000003` | Language ta, **no trip** (empty state) |
| Owner | Anil Mehta | `9000000011` | Multi-branch, all data |
| Ops / Dispatcher | Priya Nair | `9000000021` | Mumbai HQ branch |
| Sales Executive | Karan Shah | `9000000031` | Has a target, 18 leads |
| Supervisor | Vijay Gaikwad | `9000000041` | Pune hub |
| Accountant | Neha Kulkarni | `9000000051` | `canRecordReceipt = true`, approval limit ₹50,000 |
| **Multi-role** | Rajesh Iyer | `9000000099` | Roles: Owner + Ops + Driver (tests the role picker and switcher) |

Invalid-phone test: `1234567890`. Blocked-user test: `9000000000` → "Your account is not active. Contact your admin."

Build the login page with a **"Demo accounts"** collapsible panel (visible only when `AppConfig.demo == true`) listing these roles as tappable chips that auto-fill the phone number.

---

## 10. STATE MANAGEMENT PATTERNS

- One `AsyncNotifier`/`Notifier` per feature (`@riverpod` generated). UI reads `AsyncValue` and uses `.when(loading: skeleton, error: ErrorState, data: ...)`.
- `sessionProvider` (current user, active role, permissions), `localeProvider`, `themeModeProvider`, `connectivityProvider`, `syncStatusProvider`, `offlineQueueProvider`, `activeTripProvider` (driver), `gpsControllerProvider`.
- **Optimistic updates** in driver flows; roll back with a toast if the sync is rejected.
- All repository providers live in `repository_providers.dart`, overridable in tests.
- Permissions helper: `ref.watch(canProvider(Permission.approveAdvance))` etc., used to show/hide actions.

---

## 11. SECURITY AND PRIVACY (frontend)

- Tokens only in `flutter_secure_storage`. Never log PII.
- Biometric/PIN lock for staff; `FLAG_SECURE` on finance screens; blur on the app switcher.
- Aadhaar/KYC images are never cached in the gallery; store in the app-private directory and delete after upload.
- Call/voice recording consent screen before the first voice note. Location disclosure per Section 6.
- Certificate pinning placeholder in `api_client.dart` (documented, disabled for mock).
- Obfuscate release builds: `flutter build apk --release --obfuscate --split-debug-info=build/symbols`.

---

## 12. PERFORMANCE AND LOW-END DEVICES

- Target smooth 60 fps on 2 GB RAM Android. Use `const` widgets, `ListView.builder`, image caching with size limits, and `RepaintBoundary` on charts and maps.
- Lazy-load role modules (`deferred as` imports on Android web-style splitting isn't available, so keep modules light and only construct the active role's shell).
- APK size target < 40 MB with `--split-per-abi`. No heavy libs in the driver path (charts, maps only where needed).
- Compress all images before storing. Limit the queue attachment size (max 10 MB per action).

---

## 13. TESTING AND ACCEPTANCE CRITERIA

**Unit tests:** validators (phone, GSTIN, PAN, vehicle no.), INR formatter (`1234567 → ₹12,34,567`), offline queue FIFO/retry/backoff, sync engine conflict handling, status-step order validation.
**Widget tests:** login → OTP → role home for each demo account; driver slide-to-confirm sequence; approvals approve/reject with undo; logout blocked with pending items.
**Integration test:** Driver happy path: login (9000000001) → active trip → Reached Pickup → Loading Done → Start (GPS starts) → Reached Drop → Unloaded → POD (OTP 4321) → add expense → go offline → repeat an action → go online → queue drains.

**Acceptance checklist (all must pass):**
1. All 9 demo accounts log in with OTP `123456` and land on the correct role home.
2. Multi-role user sees the role picker and can switch roles without re-login.
3. A driver cannot navigate to `/owner/*` (403 page), even via a deep link.
4. Driver actions work fully in airplane mode and sync when the network returns, with photos intact.
5. Logout is blocked for a driver with pending items or a running trip.
6. Every list screen shows skeleton → data, and handles empty and error states.
7. Light and dark themes both look correct; contrast ratio ≥ 4.5:1 for body text.
8. English and Hindi fully translated; switching language updates the UI instantly, with no restart.
9. All currency shows in Indian grouping; dates are `dd MMM yyyy`, times 12-hour with AM/PM.
10. Zero analyzer warnings, tests green, `flutter build apk --release` succeeds.

---

## 14. BUILD ORDER (do it in this sequence, committing after each phase)

1. **Foundation:** project, packages, theme tokens, shared widgets, l10n setup, Hive, router + guards, mock repositories skeleton, demo credentials.
2. **Auth flow:** splash, language, login, OTP, role picker, permissions, biometric, lock, logout.
3. **Driver mode (full)** including the offline queue, sync engine, GPS service, POD, expenses, advances, SOS, voice, earnings, documents.
4. **Owner mode:** dashboard, approvals, accounts (view-only), live map, brief, ask-your-data.
5. **Ops mode:** orders, plan trip, live trips, exceptions, market vehicles.
6. **Common:** notifications, search, profile/settings, PDF preview.
7. **Sales, Supervisor, Accountant modes** (phase 2).
8. Polish: animations, empty states, accessibility, translations, tests, README, release build.

---

## 15. DELIVERABLES EXPECTED FROM THE BUILDER

1. The complete Flutter project in the folder structure above.
2. `README.md`: setup, commands, demo accounts table, architecture diagram (text), how to swap mock → real API (which provider file to change), how to add a language, and known limitations.
3. A `CHANGELOG.md` and a `docs/screens.md` listing each route, its role and its status.
4. A signed-debug APK and instructions for the release keystore.

> **Out of scope for this build (leave stubs and TODOs):** real backend/API, real OTP/SMS, real FCM push, real e-way bill / e-invoice / GST calls, real WhatsApp Business API, real Bluetooth printer, payment gateway, Tally export, iOS-specific driver background tracking hardening.

**END OF PROMPT**
