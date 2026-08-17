import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/features/auth/data/api/signup_api.dart';
import 'package:ecommerce_app/features/auth/data/models/request_dto/signup_request_dto.dart';
import 'package:ecommerce_app/features/auth/domain/entities/request_entities/signup_request_entity.dart';
import 'package:ecommerce_app/features/auth/domain/entities/response_entities/signup_response_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/data_source/signup_data_source.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SignupDataSource)
class SignupDataSourceImpl implements SignupDataSource {
  final SignupApi _api;

  SignupDataSourceImpl(this._api);

  @override
  Future<AppResult<SignupResponseEntity>> signup(
    SignupRequestEntity request,
  ) async {
    final requestDto = SignupRequestDto(
      name: request.name,
      email: request.email,
      password: request.password,
    );

    final result = await _api.signup(requestDto);

    return result.fold(
      (failure) => Left(failure),
      (response) => Right(response.toEntity()),
    );
  }
}
