// import 'package:injectable/injectable.dart';

// abstract class TokenStorage {
//   Future<String?> getAccessToken();
//   Future<void> saveAccessToken(String token);
//   Future<void> clear();
// }

// @LazySingleton(as: TokenStorage)
// class TokenStorageImpl implements TokenStorage {
//   final _storage = const Storage();
//   static const _key = 'ACCESS_TOKEN';

//   @override
//   Future<String?> getAccessToken() => 'token';

//   @override
//   Future<void> saveAccessToken(String token) {
//     return;
//   }

//   @override
//   Future<void> clear() {}
// }
