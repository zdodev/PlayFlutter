import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_memo_app/features/user_profile/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> fetchUserProfile(int userId);
}

@LazySingleton(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio _dio;
  UserRemoteDataSourceImpl(this._dio);

  @override
  Future<UserModel> fetchUserProfile(int userId) async {
    // final mockJson = {
    //   'id': userId,
    //   'username': 'FlutterGuru_GDE',
    //   'email_address': 'expert@flutter.dev',
    // };
    // return UserModel.fromJson(mockJson);
    try {
      final response = await _dio.get('/users/$userId');
      final data = response.data['data'];
      return UserModel.fromJson(data);
    } on DioException catch (e) {
      print(e);
      return UserModel(id: 0, username: 'null', email: 'null');
    } catch (e) {
      print(e);
      return UserModel(id: 0, username: 'null', email: 'null');
    }
  }
}
