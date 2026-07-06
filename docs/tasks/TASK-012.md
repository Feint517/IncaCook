# TASK-012 — Dead-code cleanup (orphan modules + mocks)

Status: Ready
Priority: P2
Feature spec: multiple

## Purpose

Remove orphaned/dead code so the only remaining `MockData` references are
intentional and the codebase reflects reality.

## Scope (delete once confirmed unreferenced)

- `lib/features/home/` — old nav tabs (superseded by `client/.../client_nav_tabs.dart`).
- `lib/features/chat/presentation/screens/chat_list.dart` — mock chat list
  (superseded by `conversations_list.dart`; only referenced by dead `home/`).
- `lib/features/checkout/presentation/screens/checkout.dart` — `Placeholder()`
  stub, unreferenced (real flow lives in `orders/`).
- `lib/features/client/data/client_mock_data.dart` — no live references.
- `lib/features/map/data/map_mock_data.dart` — no live references.
- `lib/features/seller/data/{order_request_mock_data,accepted_order_mock_data,seller_product_mock_data}.dart`
  — confirm unused, then delete.

## Acceptance Criteria

- [ ] Listed files deleted; `flutter analyze` clean; app builds.
- [ ] `grep -rn MockData lib/features` returns only files actively used by an
      open task (TASK-004/005/007/008), which their tasks then remove.

## Technical Notes

- Do this **after** (or alongside) TASK-004/005/007/008 so the remaining mock
  references go to zero together.

## Edge Cases

- A "dead" file is actually imported somewhere unexpected — grep before delete.

## Dependencies

- TASK-004, TASK-005, TASK-007, TASK-008 (they remove the last live mock uses).

## Verification

- `flutter analyze` + app boots for buyer/seller/driver.
