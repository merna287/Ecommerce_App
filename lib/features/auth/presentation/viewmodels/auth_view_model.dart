import 'package:ecommerce_app/core/validators/validator_app.dart';
import 'package:ecommerce_app/features/auth/domain/entities/request_entities/signin_request_entity.dart';
import 'package:ecommerce_app/features/auth/domain/entities/request_entities/signup_request_entity.dart';
import 'package:ecommerce_app/features/auth/domain/entities/response_entities/signin_response_entity.dart';
import 'package:ecommerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ecommerce_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthViewModel {
  final AuthCubit _authCubit;
  final GetStorage _storage;

  SigninResponseEntity? _session;

  AuthViewModel({required AuthCubit authCubit, required GetStorage storage})
    : _authCubit = authCubit,
      _storage = storage {
    _authCubit.stream.listen(_onAuthStateChanged);
  }

  AuthCubit get cubit => _authCubit;
  SigninResponseEntity? get session => _session;
  bool get isLoggedIn => _storage.read('isLoggedIn') ?? false;
  bool get isFirstTime => _storage.read('isFirstTime') ?? true;

  void _onAuthStateChanged(AuthState state) {
    if (state is AuthSuccess) {
      _session = state.session;
      _storage.write('isLoggedIn', true);
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    final emailError = ValidatorApp.validateEmail(email);
    final passwordError = ValidatorApp.validatePassword(password);

    if (emailError != null || passwordError != null) {
      _authCubit.validationFailed(emailError ?? passwordError!);
      return;
    }

    await _authCubit.signIn(
      SigninRequestEntity(email: email.trim(), password: password),
    );
  }

  Future<void> signInWithGoogle() async {
    await _authCubit.signInWithGoogle();
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final nameError = ValidatorApp.validateName(name);
    final emailError = ValidatorApp.validateEmail(email);
    final passwordError = ValidatorApp.validatePassword(password);

    String? error;
    if (nameError != null) {
      error = nameError;
    } else if (emailError != null) {
      error = emailError;
    } else if (passwordError != null) {
      error = passwordError;
    }

    if (error != null) {
      _authCubit.validationFailed(error);
      return;
    }

    await _authCubit.signUp(
      SignupRequestEntity(
        name: name.trim(),
        email: email.trim(),
        password: password,
      ),
    );
  }

  void setFirstTimeDone() {
    _storage.write('isFirstTime', false);
  }

  void logout() {
    _session = null;
    _storage.write('isLoggedIn', false);
  }
}
