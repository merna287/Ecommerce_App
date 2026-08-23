import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/features/auth/domain/entities/response_entities/signin_response_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/repo/google_signin_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GoogleSigninUseCase {
  GoogleSigninUseCase(this._repo);

  final GoogleSigninRepo _repo;

  Future<AppResult<SigninResponseEntity>> call() => _repo.signinWithGoogle();
}
