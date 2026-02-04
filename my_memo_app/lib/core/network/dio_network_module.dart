import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio();

    dio.options.baseUrl = 'https://reqres.in/api';
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('[Request]\n${options.uri}');
        },
        onResponse: (response, handler) {
          print('[Response]\n$response');
        },
        onError: (error, handler) {
          print('[Error]\n$error');
        },
      ),
    );

    return dio;
  }
}
