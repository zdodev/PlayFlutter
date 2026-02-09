import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:your_app/data/datasources/local/token_storage.dart';

@injectable
class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;

  AuthInterceptor(this._tokenStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 1. 헤더가 필요 없는 요청인지 확인 (옵션)
    // 예: 로그인, 회원가입 등은 토큰이 필요 없음
    if (options.headers.containsKey('requiresToken') &&
        options.headers['requiresToken'] == false) {
      options.headers.remove('requiresToken'); // 마킹용 헤더 제거
      return handler.next(options);
    }

    // 2. 토큰 가져오기
    final token = await _tokenStorage.getAccessToken();

    // 3. 토큰이 있으면 헤더에 주입
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      // 필요한 경우 추가 헤더
      // options.headers['X-User-ID'] = ...;
    }

    // 4. 요청 계속 진행
    return handler.next(options);
  }

  // (선택) 401 에러 발생 시 토큰 갱신 로직을 onError에 구현 가능
}
