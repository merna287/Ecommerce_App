import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/features/auth/domain/entities/response_entities/signin_response_entity.dart';

abstract class GoogleSigninDataSource {
  Future<AppResult<SigninResponseEntity>> signinWithGoogle();
}
