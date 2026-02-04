import 'package:injectable/injectable.dart';
import 'package:my_memo_app/features/user_profile/domain/entities/user_entity.dart';
import 'package:my_memo_app/features/user_profile/domain/repositories/user_repository.dart';

@injectable
class GetUserProfileUsecase {
  final UserRepository _repository;

  GetUserProfileUsecase(this._repository);

  Future<UserEntity> call(int id) {
    return _repository.getUserProfile(id);
  }
}
