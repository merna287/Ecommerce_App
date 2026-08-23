import 'package:ecommerce_app/core/di/injection.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/signin_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/signup_use_case.dart';
import 'package:ecommerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ecommerce_app/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dependency injection resolves the auth graph', () {
    configureDependencies();

    final signinUseCase = getIt<SigninUseCase>();
    final signupUseCase = getIt<SignupUseCase>();
    final authCubit = getIt<AuthCubit>();
    final authViewModel = getIt<AuthViewModel>();

    expect(signinUseCase, isNotNull);
    expect(signupUseCase, isNotNull);
    expect(authCubit, isNotNull);
    expect(authViewModel, isNotNull);
    expect(authViewModel.cubit, same(authCubit));
  });
}
