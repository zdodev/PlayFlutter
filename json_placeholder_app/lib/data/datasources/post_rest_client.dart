import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/post_model.dart';

part 'post_rest_client.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class PostRestClient {
  factory PostRestClient(Dio dio) = _PostRestClient;

  @GET('/posts')
  Future<List<PostModel>> getPosts();
}
