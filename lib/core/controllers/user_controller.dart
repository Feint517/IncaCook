import 'package:get/get.dart';

import 'package:incacook/core/models/auth/user.dart';
import 'package:incacook/core/network/api_response.dart';
import 'package:incacook/core/network/token_storage.dart';
import 'package:incacook/features/authentication/data/repositories/users_repository.dart';

/// Holds the currently signed-in user across the app.
///
/// Single permanent singleton registered in `main.dart`. Widgets read it
/// reactively via [Obx] — when the user signs in / out / updates their
/// profile, every screen that observes [user] repaints automatically.
///
/// **Hydration is driven by callers, not by this controller.** The
/// `PostAuthRouter` already calls `/users/me` to decide routing; it
/// writes the result here via [setUser]. The signup wizard calls
/// [setUser] with the response from `POST /v1/users` (Gate 2). Future
/// per-resource PUTs can call [refresh] when they need fresh aggregate
/// data. Keeping all fetches in the caller (instead of having the
/// controller auto-fetch on construct) means we never accidentally
/// double-fetch on cold start.
class UserController extends GetxController {
  UserController({
    UsersRepository? usersRepository,
    TokenStorage? tokenStorage,
  })  : _usersRepository = usersRepository ?? Get.find<UsersRepository>(),
        _tokenStorage = tokenStorage ?? Get.find<TokenStorage>();

  static UserController get instance => Get.find();

  final UsersRepository _usersRepository;
  final TokenStorage _tokenStorage;

  /// Current user. `null` when signed out OR before the post-auth flow
  /// has hydrated. Reactive — bind via [Obx].
  final Rxn<User> user = Rxn<User>();

  /// Email on the Supabase auth identity (`Session.user.email`).
  ///
  /// Distinct from [user.email] because it's available *before* Gate 2
  /// runs — i.e. for the `PostAuthNoProfile` path where the user signed
  /// in (or up via Google) but has no IncaCook `User` row yet. Hydrated
  /// by `AuthRepository._persistSession` after every successful auth
  /// call, so any screen reading it (e.g. the OTP page's "we sent a
  /// code to …" copy) shows the address the backend will actually
  /// resolve from the JWT.
  final RxnString authEmail = RxnString();

  /// Name claims pulled from the access-token JWT's `user_metadata`.
  /// Populated for OAuth sign-ins (Google sends `given_name` /
  /// `family_name`) so the signup wizard can pre-fill Gate 2's body
  /// for first-time NoProfile users — without this, the wizard reaches
  /// role selection with empty strings and POST `/v1/users` returns
  /// 400 from the length-≥2 validators. Stays null for email-password
  /// signups (Supabase emits empty user_metadata).
  final RxnString authFirstName = RxnString();
  final RxnString authLastName = RxnString();

  /// Convenience getters so widgets don't have to null-check repeatedly.
  /// Empty strings (not `null`) so they can drop into `Text(...)` directly.
  String get displayName {
    final u = user.value;
    if (u == null) return '';
    return '${u.firstName} ${u.lastName}'.trim();
  }

  String get email => user.value?.email ?? '';

  bool get isSignedIn => user.value != null;

  /// Replaces the cached user. Called by:
  ///   * `PostAuthRouter.decide()` after `/users/me`,
  ///   * `SignupFlowController._submitCompleteProfile()` after Gate 2,
  ///   * [refreshFromServer] after a successful re-fetch.
  void setUser(User u) {
    user.value = u;
    // /users/me's email is always the same as the auth email — keep
    // them in sync so the two views can't drift.
    authEmail.value = u.email;
  }

  /// Stores the Supabase auth identity's email after any successful
  /// auth call. Called from `AuthRepository._persistSession`.
  void setAuthEmail(String email) => authEmail.value = email;

  /// Stores the OAuth-provider name claims (when present). Null /
  /// empty values are normalized to `null` so callers can use a single
  /// `value != null && value.isNotEmpty`-style check.
  void setAuthName({String? firstName, String? lastName}) {
    authFirstName.value =
        (firstName != null && firstName.isNotEmpty) ? firstName : null;
    authLastName.value =
        (lastName != null && lastName.isNotEmpty) ? lastName : null;
  }

  /// Reads the persisted auth email from [TokenStorage] and seeds
  /// [authEmail]. Called once on cold start from `BootstrapController`
  /// so the value survives hot restart / app relaunch — without this,
  /// the OTP page falls back to the wizard's debug seed because the
  /// in-memory cache is fresh.
  ///
  /// No-op if [authEmail] is already populated (means a live auth call
  /// beat us to it).
  Future<void> hydrateFromStorage() async {
    if (authEmail.value != null) return;
    final stored = await _tokenStorage.readAuthIdentity();
    if (stored.email != null && stored.email!.isNotEmpty) {
      authEmail.value = stored.email;
    }
    if (stored.firstName != null && stored.firstName!.isNotEmpty) {
      authFirstName.value = stored.firstName;
    }
    if (stored.lastName != null && stored.lastName!.isNotEmpty) {
      authLastName.value = stored.lastName;
    }
  }

  /// Re-fetches `/users/me` and updates the cache.
  ///
  /// Throws [ApiFailure] on failure — callers decide whether to surface
  /// it. Typical use: after a profile-update PUT, call this so the
  /// settings screen reflects the new name/avatar immediately. Named
  /// distinctly from [GetxController.refresh] (which is a local
  /// notify) to avoid surprises.
  Future<User> refreshFromServer() async {
    final fresh = await _usersRepository.getMe();
    setUser(fresh);
    return fresh;
  }

  /// Drops the cached user. Called by `SignOutService` so the next
  /// screen sees `null` before navigation lands on Welcome.
  void clear() {
    user.value = null;
    authEmail.value = null;
    authFirstName.value = null;
    authLastName.value = null;
  }
}
