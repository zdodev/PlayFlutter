import 'package:flutter/material.dart';
import 'package:my_auto_route_app/di/service_locator.dart';
import 'package:my_auto_route_app/router/app_router.dart';

void main() {
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Advanced Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      routerConfig: _appRouter.config(),
    );
  }
}
