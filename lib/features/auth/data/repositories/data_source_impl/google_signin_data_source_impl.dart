import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/core/utils/google_password_deriver.dart';
import 'package:ecommerce_app/features/auth/data/api/google_identity_api.dart';
import 'package:ecommerce_app/features/auth/data/api/signin_api.dart';
import 'package:ecommerce_app/features/auth/data/api/signup_api.dart';
import 'package:ecommerce_app/features/auth/data/api/user_availability_api.dart';
import 'package:ecommerce_app/features/auth/data/models/request_dto/google_signin_request_model.dart';
import 'package:ecommerce_app/features/auth/data/models/request_dto/signin_request_dto.dart';
import 'package:ecommerce_app/features/auth/data/models/request_dto/signup_request_dto.dart';
import 'package:ecommerce_app/features/auth/domain/entities/response_entities/signin_response_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/data_source/google_signin_data_source.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GoogleSigninDataSource)
class GoogleSigninDataSourceImpl implements GoogleSigninDataSource {
  final GoogleIdentityApi _identityApi;
  final UserAvailabilityApi _availabilityApi;
  final SignupApi _signupApi;
  final SigninApi _signinApi;

  GoogleSigninDataSourceImpl(
    this._identityApi,
    this._availabilityApi,
    this._signupApi,
    this._signinApi,
  );

  @override
  Future<AppResult<SigninResponseEntity>> signinWithGoogle() async {
    final GoogleSignInAccount? account;
    try {
      account = await _identityApi.signIn();
    } on GoogleSignInException catch (e) {
      return Left(
        AuthFailure(message: e.description ?? 'Google sign-in failed'),
      );
    }

    if (account == null) {
      return const Left(CancelledFailure());
    }

    final request = GoogleSigninRequestDto(
      name: account.displayName ?? account.email.split('@').first,
      email: account.email,
      photoUrl: account.photoUrl,
      googleSub: account.id,
    );

    final syntheticPassword = GooglePasswordDeriver.derive(request.googleSub);

    final availabilityResult = await _availabilityApi.isAvailable(
      request.email,
    );
    if (availabilityResult.isLeft()) {
      return Left(
        availabilityResult.fold((failure) => failure, (_) => UnknownFailure()),
      );
    }
    final isNewUser = availabilityResult.fold((_) => false, (v) => v);

    if (isNewUser) {
      final registerResult = await _signupApi.signup(
        SignupRequestDto(
          name: request.name,
          email: request.email,
          password: syntheticPassword,
          avatar: request.photoUrl,
        ),
      );
      if (registerResult.isLeft()) {
        return Left(
          registerResult.fold((failure) => failure, (_) => UnknownFailure()),
        );
      }
    }

    final loginResult = await _signinApi.login(
      SigninRequestDto(email: request.email, password: syntheticPassword),
    );

    return loginResult.fold(
      (failure) => Left(failure),
      (responseDto) => Right(responseDto.toEntity()),
    );
  }
}
