import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/features/auth/domain/entities/request_entities/signin_request_entity.dart';
import 'package:ecommerce_app/features/auth/domain/entities/response_entities/signin_response_entity.dart';

abstract class SigninRepo {
  Future<AppResult<SigninResponseEntity>> signin(
    SigninRequestEntity request
  );
}
