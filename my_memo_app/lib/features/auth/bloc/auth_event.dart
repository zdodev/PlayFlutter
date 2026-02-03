import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.loginRequested() = LoginRequested;
  const factory AuthEvent.logoutRequested() = LogoutRequested;
}
