import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/features/auth/domain/entities/response_entities/signin_response_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/data_source/google_signin_data_source.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/repo/google_signin_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GoogleSigninRepo)
class GoogleSigninRepositoryImpl implements GoogleSigninRepo {
  final GoogleSigninDataSource _dataSource;

  GoogleSigninRepositoryImpl(this._dataSource);

  @override
  Future<AppResult<SigninResponseEntity>> signinWithGoogle() {
    return _dataSource.signinWithGoogle();
  }
}
