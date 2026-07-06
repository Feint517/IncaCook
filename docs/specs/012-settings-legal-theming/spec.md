# Feature Spec: Settings, Legal & Theming

**Feature ID**: `012-settings-legal-theming`
**Created**: 2026-06-30
**Status**: Implemented
**Mobile module**: `lib/features/settings`, `lib/features/legal`,
`lib/features/bootstrap`, `lib/core/utils/theme`

## User Story

As any user, I want a profile/settings area with appearance (light/dark),
saved addresses, order history, and access to the legal documents, so I can
manage my account and understand the terms.

## Current Behavior

- `settings.dart` is the Profil tab for all roles (opens `OrdersHistoryScreen`,
  appearance/theme, saved addresses); `edit_profile.dart` for profile edits.
- Theming: full light/dark via `ThemeController` + `ThemeMode` persisted with
  `GetStorage`; brand/palette/Material-token layering per `CLAUDE.md`.
- Legal: `legal_documents_repository.dart` → `GET /v1/legal-documents/active`;
  `legal_terms_screen.dart`. Charters via `GET /v1/charters/active`.
- Bootstrap: `bootstrap_controller.dart` cold-start (token check →
  `PostAuthRouter.decide()`), `splash_screen.dart`.

## Gaps

- **Onboarding copy** (`docs/client-feedback.md` §4): the 4 client-supplied
  onboarding strings were never applied; copy must communicate "plats faits
  maison à prix très bas". Re-request the texts, update `text_strings.dart`.
- **CGU/CGV content** (§2): wrong product name + missing responsibility
  clauses — fix in backend charter content + bump versions (see spec `002`).

## Acceptance Criteria

1. **Given** the settings screen, **When** the user switches theme, **Then**
   the choice persists across restarts.
2. **Given** the legal screen, **When** opened, **Then** it shows the active
   server-served documents.
3. **Given** onboarding, **When** shown, **Then** copy clearly states the
   low-price home-made value proposition.

## Minimal Data Contract

`LegalDocument`, `UserCharter`, local theme preference (GetStorage).

## Execution Tasks

- [x] Settings, theming, legal screens, cold-start routing.
- [ ] Apply the client's onboarding copy (re-request the 4 strings).
- [ ] Backend CGU/CGV content rewrite + version bump (tracked in spec `002`).

## Risks

- Charter version bump must force re-acceptance for existing users.
