import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Input
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// Input - 로그인 요청
class LoginRequested extends AuthEvent {
  final String username;
  final String password;

  const LoginRequested(this.username, this.password);
}

// State
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

// State - 인증 전
class AuthInitial extends AuthState {}

// State - 인증 중
class AuthLoading extends AuthState {}

// State - 인증 성공
class AuthSuccess extends AuthState {}

// State - 인증 실패
class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);
}

// ViewModel?
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const .new(seconds: 1));

      if (event.username == 'admin' && event.password == '1234') {
        emit(AuthSuccess());
      } else {
        emit(const AuthFailure("아이디 또는 비밀번호가 틀렸습니다."));
      }
    });
  }
}
