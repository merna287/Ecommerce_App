import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/features/auth/domain/entities/request_entities/signup_request_entity.dart';
import 'package:ecommerce_app/features/auth/domain/entities/response_entities/signup_response_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/repo/signup_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignupUseCase {
  SignupUseCase(this._repo);
  final SignupRepo _repo;
  Future<AppResult<SignupResponseEntity>> call(SignupRequestEntity request) =>
      _repo.signup(request);
}
