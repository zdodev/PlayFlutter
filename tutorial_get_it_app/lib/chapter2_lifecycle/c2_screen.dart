import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'c2_locator.dart';
import 'c2_services.dart';

class Chapter2Screen extends StatefulWidget {
  const Chapter2Screen({super.key});
  @override
  State<Chapter2Screen> createState() => _Chapter2ScreenState();
}

class _Chapter2ScreenState extends State<Chapter2Screen> {
  @override
  void initState() {
    setupChapter2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chapter 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Singleton ID (고정):\n${GetIt.I<SingletonObj>().id}"),
            const SizedBox(height: 20),
            Text("Factory ID (매번 변경):\n${GetIt.I<FactoryObj>().id}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => setState(() {}),
              child: const Text('화면 갱신 (setState)'),
            ),
            const Text("버튼을 누르면 Factory만 시간이 바뀝니다."),
          ],
        ),
      ),
    );
  }
}
