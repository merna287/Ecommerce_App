import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/features/auth/domain/entities/request_entities/signup_request_entity.dart';
import 'package:ecommerce_app/features/auth/domain/entities/response_entities/signup_response_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/data_source/signup_data_source.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/repo/signup_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SignupRepo)
class SignupRepositoryImpl implements SignupRepo {
  final SignupDataSource _dataSource;

  SignupRepositoryImpl(this._dataSource);

  @override
  Future<AppResult<SignupResponseEntity>> signup(SignupRequestEntity request) {
    return _dataSource.signup(request);
  }
}
