import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/features/auth/data/api/signin_api.dart';
import 'package:ecommerce_app/features/auth/data/models/request_dto/signin_request_dto.dart';
import 'package:ecommerce_app/features/auth/domain/entities/request_entities/signin_request_entity.dart';
import 'package:ecommerce_app/features/auth/domain/entities/response_entities/signin_response_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/data_source/signin_data_source.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SigninDataSource)
class SigninDataSourceImpl implements SigninDataSource {
  final SigninApi _api;

  SigninDataSourceImpl(this._api);

  @override
  Future<AppResult<SigninResponseEntity>> signin(
    SigninRequestEntity request,
  ) async {
    final requestDto = SigninRequestDto(
      email: request.email,
      password: request.password,
    );

    final result = await _api.login(requestDto);

    return result.fold(
      (failure) => Left(failure),
      (responseDto) => Right(responseDto.toEntity()),
    );
  }
}
