# Changelog

## 1.0.0+1 — Phase 8: release candidate (all six roles, mock data)

### Added
- Phase 1: foundation — theme tokens, 8-locale ARBs, Hive + secure storage,
  role-guarded router, mock auth, 22 shared widgets.
- Phase 2: full auth flow — splash, language, login + demo panel, OTP
  (resend/lockout/shake), role picker, role permissions + location disclosure,
  biometric/PIN setup, lock page + lock-on-resume, profile + logout blockers.
  Android `com.yourcompany.roadops` identity, manifest permissions, GPS
  foreground-service declaration; iOS bundle id, name, usage strings.
- Phase 3: driver mode — trip state machine (offer/active/empty), slide-to-
  confirm with mandatory photo, offline queue + sync drain, GPS tracking,
  POD (OTP/signature/damage), expenses, advances, earnings + payslip PDFs,
  documents, SOS, voice commands, driver settings.
- Phases 4–5: owner (dashboard, approvals, accounts, live map, brief, alert
  settings) and ops (orders, create wizard, plan-trip wizard, live control,
  exceptions, market hire + memos).
- Phases 6–7: notification centre, global search, settings, PDF viewer;
  sales (leads/visits/quotes/customers/targets), supervisor (today/gate/
  loading/scan/manifest/LR print), accountant (summary/ledgers/invoices/
  approvals/reminders/receipts).
- Phase 8: zero analyzer issues, 75 green tests, docs, release build.

### Fixed (found by the test pass)
- Lock page trap: unlocked sessions never left `/lock` (guard gap).
- `ref.read` inside `State.dispose` crashed teardown (cached service instead).
- Riverpod 3 migration: `valueOrNull` → nullable `.value`; keep-alive
  providers; refreshed share_plus/speech_to_text/Radio APIs.
- Test-only: injectable key-value boxes (Hive file writes deadlock FakeAsync
  and poison later tests); dialog-tap races; lazy-list visibility taps.
