import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

enum LoginStatus { initial, loading, success, failure }

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    @Default(LoginStatus.initial) LoginStatus status,
    @Default('') String errorMessage,
  }) = _LoginState;
}
