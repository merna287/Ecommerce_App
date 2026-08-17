import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/features/auth/domain/entities/request_entities/signin_request_entity.dart';
import 'package:ecommerce_app/features/auth/domain/entities/response_entities/signin_response_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/repo/signin_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SigninUseCase {
  SigninUseCase(this._repo);

  final SigninRepo _repo;

  Future<AppResult<SigninResponseEntity>> call(SigninRequestEntity request) =>
      _repo.signin(request);
}
