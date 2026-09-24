# AGENTS.md

- Read Logistics_Flutter_App_Build_Prompt.md before any task; it is the source of truth.
- Stack: Flutter + Riverpod (codegen) + go_router + freezed + Hive. Feature-first folder structure.
- All data goes through repository interfaces with Mock implementations. Never call a real backend.
- Colors, spacing and text styles come only from core/theme tokens. Strings come only from ARB files. No hard-coded values in widgets.
- Driver mode: minimum tap target 56dp, offline-first, no staff code loaded.
- Every screen needs loading (skeleton), empty and error states.
- Run `flutter analyze` and `flutter test` before saying any task is done.
- Never skip a screen listed in the doc. If something is deferred, add a clear TODO and tell me.
