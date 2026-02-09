import 'package:injectable/injectable.dart';

import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_rest_client.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  final PostRestClient _client;

  PostRepositoryImpl(this._client);

  @override
  Future<List<PostEntity>> getPosts() async {
    final models = await _client.getPosts();
    return models.map((e) => e.toEntity()).toList();
  }
}
