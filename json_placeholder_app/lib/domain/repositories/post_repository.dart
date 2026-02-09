import '../entities/post_entity.dart';

// Domain
// - Repository: 인터페이스 구현
abstract class PostRepository {
  Future<List<PostEntity>> getPosts();
}
