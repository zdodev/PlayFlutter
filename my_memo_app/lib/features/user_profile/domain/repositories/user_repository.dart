import 'package:my_memo_app/features/user_profile/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUserProfile(int id);
}
