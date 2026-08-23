import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/features/auth/domain/entities/request_entities/signin_request_entity.dart';
import 'package:ecommerce_app/features/auth/domain/entities/response_entities/signin_response_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/data_source/signin_data_source.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/repo/signin_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SigninRepo)
class SigninRepositoryImpl implements SigninRepo {
  final SigninDataSource _dataSource;

  SigninRepositoryImpl(this._dataSource);

  @override
  Future<AppResult<SigninResponseEntity>> signin(
    SigninRequestEntity request,
  ) {
    return _dataSource.signin(request);
  }
}