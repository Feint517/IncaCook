# TASK-011 — Verify empty-filter shows everything (live feed)

Status: Ready
Priority: P2
Feature spec: `004-discovery-feed-map`
Source: `docs/client-feedback.md` §1.3

## Purpose

When a buyer selects no dietary regime or cuisine, all dishes must appear. The
client-side filter already does this (`filter_controller.dart`:
`if (f.isEmpty) return source`); verify it holds end-to-end on the live
`GET /v1/listings` feed.

## Scope

- `lib/features/client/controllers/filter_controller.dart` and the feed query.
- Ensure absent/empty filter params mean "no filter on that dimension", not
  "narrow to empty", in the request to `/v1/listings`.

## Acceptance Criteria

- [ ] With no cuisine and no dietary filter selected, the feed shows all
      eligible dishes.
- [ ] Selecting a filter narrows correctly; clearing it restores all.

## Technical Notes

- Confirm the repository omits empty filter query params rather than sending
  empty arrays the backend might interpret as "match none".

## Edge Cases

- One filter set, the other empty; rapidly toggling filters.

## Dependencies

- None.

## Verification

- Manual: clear all filters → full feed; apply HALAL → only halal; clear → full.
