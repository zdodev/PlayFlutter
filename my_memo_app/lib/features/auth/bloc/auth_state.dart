import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

enum AuthStatus { authenticated, unauthenticated }

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState({
    @Default('') String id,
    @Default('') String password,
    @Default(AuthStatus.unauthenticated) AuthStatus status,
  }) = _AuthState;
}
