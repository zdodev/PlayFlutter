import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../data/datasources/post_rest_client.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const .new(seconds: 10),
        contentType: 'application/json',
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          logPrint: (object) {
            debugPrint('DioLog: $object');
          },
        ),
      );
    }
    return dio;
  }

  @lazySingleton
  PostRestClient getClient(Dio dio) => PostRestClient(dio);
}
