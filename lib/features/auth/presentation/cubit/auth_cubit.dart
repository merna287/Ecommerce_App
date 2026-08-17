import 'package:ecommerce_app/features/auth/domain/entities/request_entities/signin_request_entity.dart';
import 'package:ecommerce_app/features/auth/domain/entities/request_entities/signup_request_entity.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/signin_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/signup_use_case.dart';
import 'package:ecommerce_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  final SigninUseCase _signinUseCase;
  final SignupUseCase _signupUseCase;

  AuthCubit({
    required SigninUseCase signinUseCase,
    required SignupUseCase signupUseCase,
  }) : _signinUseCase = signinUseCase,
      _signupUseCase = signupUseCase,
      super(const AuthInitial());

  Future<void> signIn(SigninRequestEntity request) async {
    emit(const AuthLoading());

    final result = await _signinUseCase(request);

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (session) => emit(AuthSuccess(session: session)),
    );
  }

  Future<void> signUp(SignupRequestEntity request) async {
    emit(const AuthLoading());

    final result = await _signupUseCase(request);

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(const AuthSuccess()),
    );
  }

  void validationFailed(String message) {
    emit(AuthFailure(message));
  }
}
