import 'dart:convert';

import 'package:crypto/crypto.dart';

/// Derives the deterministic synthetic password used by the Google-assisted
/// authentication flow.
///
/// IMPORTANT: This is a client-side workaround ONLY — NOT real backend
/// verified Google SSO/OAuth. The backend exposes no Google endpoint; accounts
/// are still created and authenticated through the normal email/password APIs
/// (/users, /auth/login), so a stable password value is required.
///
/// Guarantees:
/// - Deterministic: the same Google account (`googleSub`) always yields the
///   same password, so auto-login succeeds on every subsequent sign-in.
/// - Algorithm: SHA-256 of the UTF-8 encoded `sub` claim, hex-encoded.
/// - Ephemeral: this class never stores, logs, or caches the derived value;
///   it exists only long enough to be sent inside the signup/login requests.
class GooglePasswordDeriver {
  static String derive(String googleSub) {
    final bytes = utf8.encode(googleSub);
    final digest = sha256.convert(bytes);

    return digest.toString();
  }
}
