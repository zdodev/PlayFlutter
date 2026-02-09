import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../ presentation/bloc/post_bloc.dart';

@RoutePage()
class PostListPage extends StatelessWidget {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    // DI를 통해 Bloc 주입 및 이벤트 트리거
    create: (context) => GetIt.I<PostBloc>()..add(const PostEvent.fetched()),
    child: Scaffold(
      appBar: AppBar(title: const Text('Clean Architecture Posts')),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) => state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: CircularProgressIndicator()),
          failure: (msg) => Center(child: Text('Error: $msg')),
          success: (posts) => ListView.separated(
            itemCount: posts.length,
            separatorBuilder: (_, _) => const Divider(),
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                title: Text(
                  post.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  post.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          ),
        ),
      ),
    ),
  );
}
