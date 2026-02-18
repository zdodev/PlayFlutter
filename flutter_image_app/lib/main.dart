import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Bloc 패키지 import 필수

import 'nail_editor/bloc/nail_editor_bloc.dart'; // Bloc 클래스 import
import 'nail_editor/view/nail_custom_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nail Custom App',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.white,
      ),
      // [수정] BlocProvider를 여기서 감싸줍니다.
      home: BlocProvider(
        create: (_) => NailEditorBloc(),
        child: const NailCustomScreen(),
      ),
    );
  }
}
