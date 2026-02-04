import 'package:injectable/injectable.dart';
import 'package:my_memo_app/features/user_profile/data/datasources/user_remote_data_source.dart';
import 'package:my_memo_app/features/user_profile/domain/entities/user_entity.dart';
import 'package:my_memo_app/features/user_profile/domain/repositories/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<UserEntity> getUserProfile(int id) async {
    final userModel = await _remoteDataSource.fetchUserProfile(id);
    return userModel.toEntity();
  }
}
