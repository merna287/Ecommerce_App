// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ecommerce_app/features/auth/data/api/signin_api.dart' as _i896;
import 'package:ecommerce_app/features/auth/data/api/signup_api.dart' as _i350;
import 'package:ecommerce_app/features/auth/data/repositories/data_source_impl/signin_data_source_impl.dart'
    as _i640;
import 'package:ecommerce_app/features/auth/data/repositories/data_source_impl/signup_data_source_impl.dart'
    as _i614;
import 'package:ecommerce_app/features/auth/data/repositories/repository_impl/signin_repository_impl.dart'
    as _i544;
import 'package:ecommerce_app/features/auth/data/repositories/repository_impl/signup_repository_impl.dart'
    as _i836;
import 'package:ecommerce_app/features/auth/domain/repositories/data_source/signin_data_source.dart'
    as _i648;
import 'package:ecommerce_app/features/auth/domain/repositories/data_source/signup_data_source.dart'
    as _i723;
import 'package:ecommerce_app/features/auth/domain/repositories/repo/signin_repo.dart'
    as _i1048;
import 'package:ecommerce_app/features/auth/domain/repositories/repo/signup_repo.dart'
    as _i523;
import 'package:ecommerce_app/features/auth/domain/usecases/signin_use_case.dart'
    as _i660;
import 'package:ecommerce_app/features/auth/domain/usecases/signup_use_case.dart'
    as _i413;
import 'package:ecommerce_app/features/auth/presentation/cubit/auth_cubit.dart'
    as _i118;
import 'package:ecommerce_app/features/auth/presentation/viewmodels/auth_view_model.dart'
    as _i298;
import 'package:get_it/get_it.dart' as _i174;
import 'package:get_storage/get_storage.dart' as _i792;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i896.SigninApi>(() => _i896.SigninApi());
    gh.lazySingleton<_i350.SignupApi>(() => _i350.SignupApi());
    gh.lazySingleton<_i648.SigninDataSource>(
      () => _i640.SigninDataSourceImpl(gh<_i896.SigninApi>()),
    );
    gh.lazySingleton<_i1048.SigninRepo>(
      () => _i544.SigninRepositoryImpl(gh<_i648.SigninDataSource>()),
    );
    gh.lazySingleton<_i723.SignupDataSource>(
      () => _i614.SignupDataSourceImpl(gh<_i350.SignupApi>()),
    );
    gh.lazySingleton<_i660.SigninUseCase>(
      () => _i660.SigninUseCase(gh<_i1048.SigninRepo>()),
    );
    gh.lazySingleton<_i523.SignupRepo>(
      () => _i836.SignupRepositoryImpl(gh<_i723.SignupDataSource>()),
    );
    gh.lazySingleton<_i413.SignupUseCase>(
      () => _i413.SignupUseCase(gh<_i523.SignupRepo>()),
    );
    gh.lazySingleton<_i118.AuthCubit>(
      () => _i118.AuthCubit(
        signinUseCase: gh<_i660.SigninUseCase>(),
        signupUseCase: gh<_i413.SignupUseCase>(),
      ),
    );
    gh.lazySingleton<_i298.AuthViewModel>(
      () => _i298.AuthViewModel(
        authCubit: gh<_i118.AuthCubit>(),
        storage: gh<_i792.GetStorage>(),
      ),
    );
    return this;
  }
}
