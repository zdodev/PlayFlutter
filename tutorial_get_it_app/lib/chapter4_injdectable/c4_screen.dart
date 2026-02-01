import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'c4_injection.dart';
import 'c4_repo.dart';

class Chapter4Screen extends StatefulWidget {
  const Chapter4Screen({super.key});
  @override
  State<Chapter4Screen> createState() => _Chapter4ScreenState();
}

class _Chapter4ScreenState extends State<Chapter4Screen> {
  @override
  void initState() {
    configureChapter4(); // 자동 생성된 설정 호출
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // try-catch는 빌드 러너를 안 돌렸을 때 에러 방지용
    String message = "";
    try {
      message = GetIt.I<C4Repository>().getData();
    } catch (e) {
      message = "⚠️ 에러: 터미널에서 build_runner를 실행해주세요!";
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Chapter 4')),
      body: Center(child: Text(message)),
    );
  }
}
