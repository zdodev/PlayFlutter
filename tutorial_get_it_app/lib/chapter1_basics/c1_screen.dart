import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tutorial_get_it_app/chapter1_basics/c1_locator.dart';
import 'package:tutorial_get_it_app/chapter1_basics/c1_service.dart';

class Chapter1Screen extends StatefulWidget {
  const Chapter1Screen({super.key});

  @override
  State<StatefulWidget> createState() => _Chapter1ScreenState();
}

class _Chapter1ScreenState extends State<Chapter1Screen> {
  @override
  void initState() {
    super.initState();
    setupChapter1();
  }

  @override
  Widget build(BuildContext context) {
    final service = GetIt.I<C1Service>();

    return Scaffold(
      appBar: AppBar(title: const Text('Chapter 1')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            service.increment();
            print('Chapter 1: 값 증가함 -> ${service.count}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('콘솔 확인: 현재 값 ${service.count}')),
            );
          },
          child: const Text('값 증가시키기'),
        ),
      ),
    );
  }
}
