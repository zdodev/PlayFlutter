import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:my_memo_app/core/router/app_router.gr.dart';
import 'package:my_memo_app/features/auth/bloc/auth_bloc.dart';
import 'package:my_memo_app/features/auth/bloc/auth_state.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthBloc authBloc;

  AuthGuard(this.authBloc);

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    if (authBloc.state.status == AuthStatus.authenticated) {
      resolver.next(true);
    } else {
      router.push(const LoginRoute());
      resolver.next(false);
    }
  }
}
