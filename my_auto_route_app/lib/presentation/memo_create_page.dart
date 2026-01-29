import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_auto_route_app/data/repositories/memo_repository.dart';
import 'package:my_auto_route_app/di/service_locator.dart';
import 'package:my_auto_route_app/logic/memo/memo_bloc.dart';

@RoutePage()
class MemoCreatePage extends StatefulWidget {
  const MemoCreatePage({super.key});

  @override
  State<MemoCreatePage> createState() => _MemoCreatePageState();
}

class _MemoCreatePageState extends State<MemoCreatePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MemoBloc(repository: getIt<MemoRepository>()),
      child: BlocConsumer<MemoBloc, MemoState>(
        listener: (context, state) {
          if (state is MemoOperationSuccess) {
            context.router.maybePop(true);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text("Write Memo")),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _contentController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Content',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state is MemoLoading
                          ? null
                          : () {
                              context.read<MemoBloc>().add(
                                AddMemo(
                                  _titleController.text,
                                  _contentController.text,
                                ),
                              );
                            },
                      child: state is MemoLoading
                          ? const CircularProgressIndicator()
                          : const Text("Save"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
