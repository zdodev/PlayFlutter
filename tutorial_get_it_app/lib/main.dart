import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_get_it_app/chapter1_basics/c1_screen.dart';
import 'package:tutorial_get_it_app/chapter2_lifecycle/c2_screen.dart';
import 'package:tutorial_get_it_app/chapter4_injdectable/c4_screen.dart';

void main(List<String> args) {
  runApp(const MaterialApp(home: MenuScreen()));
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Get_It proejct')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _menuBtn(context, 'Chapter 1: 기초 (Basics)', const Chapter1Screen()),
          _menuBtn(
            context,
            'Chapter 2: 생명주기 (Factory)',
            const Chapter2Screen(),
          ),
          _menuBtn(
            context,
            'Chapter 4: 자동 생성 (Injectable)',
            const Chapter4Screen(),
          ),
        ],
      ),
    );
  }

  Widget _menuBtn(BuildContext context, String title, Widget page) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => page),
        ),
        child: Text(title),
      ),
    );
  }
}
