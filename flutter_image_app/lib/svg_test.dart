import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgTest extends StatelessWidget {
  const SvgTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter SVG 예제')),
        body: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Text('로컬 에셋'),
              SizedBox(
                width: 100,
                height: 100,
                child: SvgPicture.asset('assets/icons/smile.svg'),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: SvgPicture.asset('assets/icons/option.svg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
