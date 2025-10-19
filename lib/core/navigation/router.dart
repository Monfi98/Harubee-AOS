import 'package:go_router/go_router.dart';
import 'package:harubee/core/navigation/app_route.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoute.onBoarding.path,
  routes: [
    GoRoute(
      path: AppRoute.onBoarding.path,
      pageBuilder: (_, _) => AppRoute.onBoarding.buildPage(),
    ),
    GoRoute(
      path: AppRoute.today.path,
      pageBuilder: (_, _) => AppRoute.today.buildPage(),
    ),
    GoRoute(
      path: AppRoute.transactionInput.path,
      pageBuilder: (_, state) =>
          AppRoute.transactionInput.buildPage(extra: state.extra),
    ),
    GoRoute(
      path: AppRoute.calendar.path,
      pageBuilder: (_, _) => AppRoute.calendar.buildPage(),
    ),
    GoRoute(
      path: AppRoute.dayDetail.path,
      pageBuilder: (_, state) =>
          AppRoute.dayDetail.buildPage(extra: state.extra),
    ),
    GoRoute(
      path: AppRoute.memoEdit.path,
      pageBuilder: (_, _) => AppRoute.memoEdit.buildPage(),
    ),
  ],
);
