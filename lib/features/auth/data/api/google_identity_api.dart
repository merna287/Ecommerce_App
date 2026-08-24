import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GoogleIdentityApi {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  bool _initialized = false;

  /// Returns the signed-in [GoogleSignInAccount], or `null` when the user
  /// cancels the account picker. Any other failure is rethrown.
  Future<GoogleSignInAccount?> signIn() async {
    if (!_initialized) {
      await _googleSignIn.initialize(
      serverClientId: const String.fromEnvironment(
        'GOOGLE_SERVER_CLIENT_ID',
      ),
    );
      _initialized = true;
    }

    try {
      // v7: authenticate() never returns null; cancellation throws.
      return await _googleSignIn.authenticate();
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
