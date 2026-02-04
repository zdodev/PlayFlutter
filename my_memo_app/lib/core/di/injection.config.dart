// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/user_profile/data/datasources/user_remote_data_source.dart'
    as _i326;
import '../../features/user_profile/data/repositories/user_repository_impl.dart'
    as _i943;
import '../../features/user_profile/domain/repositories/user_repository.dart'
    as _i830;
import '../../features/user_profile/domain/usercases/get_user_profile_usecase.dart'
    as _i892;
import '../../features/user_profile/presentation/bloc/user_bloc.dart' as _i12;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i326.UserRemoteDataSource>(
      () => _i326.UserRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i830.UserRepository>(
      () => _i943.UserRepositoryImpl(gh<_i326.UserRemoteDataSource>()),
    );
    gh.factory<_i892.GetUserProfileUsecase>(
      () => _i892.GetUserProfileUsecase(gh<_i830.UserRepository>()),
    );
    gh.factory<_i12.UserBloc>(
      () => _i12.UserBloc(gh<_i892.GetUserProfileUsecase>()),
    );
    return this;
  }
}
