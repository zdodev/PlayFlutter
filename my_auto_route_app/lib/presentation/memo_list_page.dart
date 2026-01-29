import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_auto_route_app/data/repositories/memo_repository.dart';
import 'package:my_auto_route_app/di/service_locator.dart';
import 'package:my_auto_route_app/logic/memo/memo_bloc.dart';
import 'package:my_auto_route_app/router/app_router.gr.dart';

@RoutePage()
class MemoListPage extends StatelessWidget {
  const MemoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MemoBloc(repository: getIt<MemoRepository>())..add(LoadMemos()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Memos')),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () async {
                final result = await context.router.push(
                  const MemoCreateRoute(),
                );
                if (result == true && context.mounted) {
                  context.read<MemoBloc>().add(LoadMemos());
                }
              },
              child: const Icon(Icons.add),
            );
          },
        ),
        body: BlocBuilder<MemoBloc, MemoState>(
          builder: (context, state) {
            if (state is MemoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MemoLoaded) {
              if (state.memos.isEmpty) {
                return const Center(child: Text('No memos yet'));
              }
              return ListView.builder(
                itemCount: state.memos.length,
                itemBuilder: (context, index) {
                  final memo = state.memos[index];
                  return ListTile(
                    title: Text(memo.title),
                    subtitle: Text(memo.content),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
