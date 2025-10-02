import 'package:go_router/go_router.dart';
import 'package:harubee/core/navigation/app_route.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoute.today.path,
      pageBuilder: (_, _) => AppRoute.today.buildPage(),
      routes: [
        GoRoute(
          path: AppRoute.transactionInput.path,
          pageBuilder: (_, _) => AppRoute.transactionInput.buildPage(),
        ),
        GoRoute(
          path: AppRoute.calendar.path,
          pageBuilder: (_, _) => AppRoute.calendar.buildPage(),
        ),
      ],
    ),
  ],
);
