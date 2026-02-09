// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:json_placeholder_app/%20presentation/bloc/post_bloc.dart'
    as _i715;
import 'package:json_placeholder_app/core/di/register_module.dart' as _i624;
import 'package:json_placeholder_app/data/datasources/post_rest_client.dart'
    as _i246;
import 'package:json_placeholder_app/data/repositories/post_repository_impl.dart'
    as _i216;
import 'package:json_placeholder_app/domain/repositories/post_repository.dart'
    as _i651;
import 'package:json_placeholder_app/domain/usecases/get_posts_usecase.dart'
    as _i551;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i246.PostRestClient>(
      () => registerModule.getClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i651.PostRepository>(
      () => _i216.PostRepositoryImpl(gh<_i246.PostRestClient>()),
    );
    gh.lazySingleton<_i551.GetPostsUseCase>(
      () => _i551.GetPostsUseCase(gh<_i651.PostRepository>()),
    );
    gh.factory<_i715.PostBloc>(
      () => _i715.PostBloc(gh<_i551.GetPostsUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i624.RegisterModule {}
