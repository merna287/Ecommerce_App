import 'package:ecommerce_app/core/validators/validetor_app.dart';
import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthViewModel extends GetxController {
  final LoginUseCase loginUseCase;
  final GetStorage storage;

  AuthViewModel({required this.loginUseCase, required this.storage});

  final RxBool _isLoading = false.obs;
  final RxBool _isLoggedIn = false.obs;
  final RxBool _isFirstTime = true.obs;
  final RxString _errorMessage = ''.obs;
  final Rxn<UserEntity> _user = Rxn<UserEntity>();

  bool get isLoading => _isLoading.value;
  bool get isLoggedIn => _isLoggedIn.value;
  bool get isFirstTime => _isFirstTime.value;
  String get errorMessage => _errorMessage.value;
  UserEntity? get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    _loadInitialState();
  }

  void _loadInitialState() {
    _isFirstTime.value = storage.read('isFirstTime') ?? true;
    _isLoggedIn.value = storage.read('isLoggedIn') ?? false;
  }

  Future<void> login({required String email, required String password}) async {
    final emailError = ValidatorApp.validateEmail(email);
    final passwordError = ValidatorApp.validatePassword(password);

    if (emailError != null || passwordError != null) {
      _errorMessage.value = emailError ?? passwordError ?? 'Validation failed';
      return;
    }

    _isLoading.value = true;
    _errorMessage.value = '';

    final result = await loginUseCase(email: email, password: password);
    final user = result.$1;
    final failure = result.$2;

    _isLoading.value = false;

    if (failure != null) {
      _errorMessage.value = failure.message;
      return;
    }

    _user.value = user;
    _isLoggedIn.value = true;
    storage.write('isLoggedIn', true);
  }

  void setFirstTimeDone() {
    _isFirstTime.value = false;
    storage.write('isFirstTime', false);
  }

  void logout() {
    _isLoggedIn.value = false;
    storage.write('isLoggedIn', false);
  }
}
