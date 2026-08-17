import 'package:ecommerce_app/core/errors/failure.dart' as failure;
import 'package:ecommerce_app/features/auth/domain/entities/request_entities/signin_request_entity.dart';
import 'package:ecommerce_app/features/auth/domain/entities/request_entities/signup_request_entity.dart';
import 'package:ecommerce_app/features/auth/domain/entities/response_entities/signin_response_entity.dart';
import 'package:ecommerce_app/features/auth/domain/entities/response_entities/signup_response_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/repo/signin_repo.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/repo/signup_repo.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/signin_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/signup_use_case.dart';
import 'package:ecommerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ecommerce_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeSigninRepo implements SigninRepo {
  final failure.AppResult<SigninResponseEntity> result;

  FakeSigninRepo(this.result);

  @override
  Future<failure.AppResult<SigninResponseEntity>> signin(
    SigninRequestEntity request,
  ) async {
    return result;
  }
}

class FakeSignupRepo implements SignupRepo {
  final failure.AppResult<SignupResponseEntity> result;

  FakeSignupRepo(this.result);

  @override
  Future<failure.AppResult<SignupResponseEntity>> signup(
    SignupRequestEntity request,
  ) async {
    return result;
  }
}

AuthCubit buildCubit({
  failure.AppResult<SigninResponseEntity> signinResult =
      const Right(SigninResponseEntity(accessToken: 'token')),
  failure.AppResult<SignupResponseEntity> signupResult =
      const Right(SignupResponseEntity()),
}) {
  return AuthCubit(
    signinUseCase: SigninUseCase(FakeSigninRepo(signinResult)),
    signupUseCase: SignupUseCase(FakeSignupRepo(signupResult)),
  );
}

void main() {
  group('AuthCubit', () {
    test('starts in the initial state', () {
      final cubit = buildCubit();
      expect(cubit.state, isA<AuthInitial>());
      cubit.close();
    });

    test('emits loading then success on a successful sign in', () async {
      final cubit = buildCubit();

      final expectedStates = expectLater(
        cubit.stream,
        emitsInOrder([isA<AuthLoading>(), isA<AuthSuccess>()]),
      );

      await cubit.signIn(
        const SigninRequestEntity(
          email: 'user@example.com',
          password: 'Password1',
        ),
      );
      await expectedStates;
      await cubit.close();
    });

    test('emits loading then failure on a failed sign in', () async {
      final cubit = buildCubit(
        signinResult: const Left(
          failure.AuthFailure(message: 'Email or password is incorrect'),
        ),
      );

      final expectedStates = expectLater(
        cubit.stream,
        emitsInOrder([
          isA<AuthLoading>(),
          isA<AuthFailure>().having(
            (state) => state.message,
            'message',
            'Email or password is incorrect',
          ),
        ]),
      );

      await cubit.signIn(
        const SigninRequestEntity(
          email: 'user@example.com',
          password: 'Password1',
        ),
      );
      await expectedStates;
      await cubit.close();
    });

    test('emits loading then success on a successful sign up', () async {
      final cubit = buildCubit();

      final expectedStates = expectLater(
        cubit.stream,
        emitsInOrder([isA<AuthLoading>(), isA<AuthSuccess>()]),
      );

      await cubit.signUp(
        const SignupRequestEntity(
          name: 'John Doe',
          email: 'user@example.com',
          password: 'Password1',
        ),
      );
      await expectedStates;
      await cubit.close();
    });

    test('emits loading then failure on a failed sign up', () async {
      final cubit = buildCubit(
        signupResult: const Left(
          failure.AuthFailure(message: 'Email already exists'),
        ),
      );

      final expectedStates = expectLater(
        cubit.stream,
        emitsInOrder([
          isA<AuthLoading>(),
          isA<AuthFailure>().having(
            (state) => state.message,
            'message',
            'Email already exists',
          ),
        ]),
      );

      await cubit.signUp(
        const SignupRequestEntity(
          name: 'John Doe',
          email: 'user@example.com',
          password: 'Password1',
        ),
      );
      await expectedStates;
      await cubit.close();
    });

    test('emits a failure state for a validation error', () {
      final cubit = buildCubit();

      cubit.validationFailed('Enter a valid email address');

      expect(cubit.state, isA<AuthFailure>());
      expect(
        (cubit.state as AuthFailure).message,
        'Enter a valid email address',
      );
      cubit.close();
    });
  });
}