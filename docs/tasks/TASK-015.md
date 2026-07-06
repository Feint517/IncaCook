# TASK-015 — Onboarding copy rewrite (value prop)

Status: Blocked (needs client-supplied texts)
Priority: P2
Feature spec: `012-settings-legal-theming`
Source: `docs/client-feedback.md` §4

## Purpose

The 4 onboarding strings the client previously sent were never applied, and the
onboarding must clearly communicate "plats faits maison à prix très bas".

## Scope

- Re-request the 4 specific texts from the client.
- Update the matching keys in `lib/core/constants/text_strings.dart` used by
  `lib/features/onboarding/`.
- If no screen states the low-price home-made value prop, rewrite top-down.

## Acceptance Criteria

- [ ] Onboarding copy matches the client's supplied texts.
- [ ] At least one screen explicitly conveys the affordable home-made value prop.

## Dependencies

- Client must re-send the 4 strings.

## Verification

- Manual: walk onboarding; copy matches the approved texts.
