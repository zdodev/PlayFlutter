import 'package:injectable/injectable.dart';

import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

@lazySingleton
class GetPostsUseCase {
  final PostRepository _repository;

  GetPostsUseCase(this._repository);

  // 여기에 추가 비즈니스 로직이 들어갈 수 있음
  Future<List<PostEntity>> call() async => _repository.getPosts();
}
