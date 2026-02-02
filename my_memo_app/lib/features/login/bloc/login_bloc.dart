import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<Started>(_onStarted);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  Future<void> _onStarted(Started event, Emitter<LoginState> emit) async {}

  Future<void> _onEmailChanged(
    EmailChanged event,
    Emitter<LoginState> emit,
  ) async {
    debugPrint('emailChanged: ${event.email}');
    emit(state.copyWith(email: event.email, status: LoginStatus.initial));
  }

  Future<void> _onPasswordChanged(
    PasswordChanged event,
    Emitter<LoginState> emit,
  ) async {
    debugPrint('passwordChanged: ${event.password}');
    emit(state.copyWith(password: event.password, status: LoginStatus.initial));
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

    // Mock login logic
    await Future.delayed(const Duration(milliseconds: 300));

    if (state.email == 'test' && state.password == '1234') {
      emit(state.copyWith(status: LoginStatus.success));
    } else {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: '이메일 또는 비밀번호가 올바르지 않습니다.',
        ),
      );
    }
  }
}
