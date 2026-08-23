import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/features/auth/domain/entities/request_entities/signup_request_entity.dart';
import 'package:ecommerce_app/features/auth/domain/entities/response_entities/signup_response_entity.dart';

abstract class SignupDataSource {
  Future<AppResult<SignupResponseEntity>> signup(SignupRequestEntity request);
}
