import 'package:injectable/injectable.dart';
import 'package:my_memo_app/features/user_profile/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> fetchUserProfile(int userId);
}

@LazySingleton(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  // final Dio _dio;
  // UserRemoteDataSourceImple(this._dio);

  @override
  Future<UserModel> fetchUserProfile(int userId) async {
    final mockJson = {
      'id': userId,
      'username': 'FlutterGuru_GDE',
      'email_address': 'expert@flutter.dev',
    };
    return UserModel.fromJson(mockJson);
  }
}
