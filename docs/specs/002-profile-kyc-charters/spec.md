# Feature Spec: Profile, Addresses, KYC, Charters & Uploads

**Feature ID**: `002-profile-kyc-charters`
**Created**: 2026-06-30
**Status**: Implemented
**Mobile module**: `lib/features/authentication` (repositories), `settings`, `legal`
**Wire contract**: `docs/backend-communication.md` §7, `docs/signup-flow.md` §3

## User Story

As a buyer/seller/driver, I want to complete the role-specific data the
platform requires — addresses, preferences, business info, cuisines,
vehicle/zones, KYC documents, and legal charters — so my account is
trusted and able to transact.

## Current Behavior

- Registered repositories cover the per-concept endpoints:
  `UsersRepository` (me, onboarding, addresses, charters),
  `BuyersRepository` (preferences), `SellersRepository`
  (profile/business/cuisines), `DriversRepository` (vehicle/zones),
  `KycRepository` (documents), `ChartersRepository` (`/v1/charters/active`),
  `UploadsRepository` (two-step signed-URL upload).
- KYC + profile photos + facade photos use the two-step upload
  (`POST /v1/uploads` → `PUT` signed URL → store `path`).
- Fait-maison sellers auto-approve KYC; non-fait-maison + drivers go through
  document review. Charter versions are checked against `GET /v1/charters/active`.

## Gaps

- CGU/CGV charter **content** still says the wrong product name and lacks the
  cuisinier-responsibility / allergen clauses the client requested
  (`docs/client-feedback.md` §2) — a **backend charter-content** change plus a
  version bump to force re-acceptance.
- Seller "extras" pantry (bread/drinks/sauces) is requested but the backend
  table + `GET/PUT /v1/sellers/me/extras` and the seller UI don't exist yet
  (§3).

## Acceptance Criteria

1. **Given** each role's required concepts, **When** the user submits them,
   **Then** the matching endpoint upserts and `GET /v1/users/me/onboarding`
   advances `next`.
2. **Given** a photo/document, **When** uploaded, **Then** the two-step flow
   stores a server-namespaced `path` referenced by the owning resource.
3. **Given** the active charter version, **When** the user accepts, **Then**
   `(userId, charter, version)` is recorded; a version bump re-prompts.

## Minimal Data Contract

`Address` (by `AddressKind`), `BuyerProfile`, `SellerProfile` +
`SellerBusiness` + `SellerCuisine` + `SellerOpeningHours`, `DriverProfile` +
`DriverZone`, `KycDocument`, `UserCharter`, `LegalDocument`.

## Execution Tasks

- [x] Wire all per-concept profile/KYC/charter/upload repositories.
- [ ] Backend: rewrite CGU/CGV content + add responsibility clauses; bump versions.
- [ ] Backend + mobile: seller "extras" pantry (`/v1/sellers/me/extras` + UI).

## Risks

- Role/kind mismatches must 400 server-side (already enforced).
- Charter version drift must force re-acceptance, not silently pass.
