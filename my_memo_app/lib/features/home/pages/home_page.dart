import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_memo_app/features/home/bloc/home_bloc.dart';
import 'package:my_memo_app/features/home/bloc/home_event.dart';
import 'package:my_memo_app/features/home/bloc/home_state.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: const _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatelessWidget {
  const _HomePageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Column(
            children: [
              _buildButton(
                context: context,
                title: 'First Button',
                buttonType: ButtonType.first,
                isSelected: state.buttonType == ButtonType.first,
              ),
              _buildButton(
                context: context,
                title: 'Second Button',
                buttonType: ButtonType.second,
                isSelected: state.buttonType == ButtonType.second,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String title,
    required ButtonType buttonType,
    required bool isSelected,
  }) {
    return ElevatedButton(
      onPressed: () {
        context.read<HomeBloc>().add(SelectedButton(buttonType: buttonType));
      },
      child: Text(
        title,
        style: TextStyle(color: isSelected ? Colors.red : Colors.blue),
      ),
    );
  }
}
