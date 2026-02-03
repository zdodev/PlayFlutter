import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page),
    AutoRoute(
      page: DashboardRoute.page,
      children: [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ],
      initial: true,
    ),
  ];
}
