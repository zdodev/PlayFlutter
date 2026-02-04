import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';

@RoutePage()
class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<UserBloc>()..add(const UserEvent.started(1)),
      child: Scaffold(
        appBar: AppBar(title: const Text('User Profile')),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (user) => Center(child: Text('Hello, ${user.name}!')),
              error: (msg) => Center(child: Text(msg)),
            );
          },
        ),
      ),
    );
  }
}
