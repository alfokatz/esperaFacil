import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/config/navigation/tracking_navigation_observer.dart';
import 'package:template/presentation/flows/detail/nav/detail_router.dart';
import 'package:template/presentation/flows/error_page/nav/error_router.dart';
import 'package:template/presentation/flows/home/nav/home_router.dart';
import 'package:template/presentation/flows/login/nav/login_router.dart';
import 'package:template/presentation/flows/register/nav/register_router.dart';

import '../../presentation/flows/add_waiters/nav/add_waiters_router.dart';

class AppRouter {
  final Ref ref;

  AppRouter({required this.ref});

  GoRouter getRouter() => GoRouter(
    debugLogDiagnostics: true,
    observers: [TrackingNavigatorObserver(ref: ref)],
    routes: [
      GoRoute(
        path: '/',
        redirect:
            (context, state) => state.namedLocation(LoginRouter.loginRouteName),
      ),
      LoginRouter.getRoute(),
      RegisterRouter.getRoute(),
      HomeRouter.getRoute(),
      DetailRouter.getRoute(),
      AddWaitersRouter.getRoute(),
    ],
    errorPageBuilder:
        (context, state) => ErrorNav.getErrorPage(exception: state.error),
  );
}

final appRouterProvider = Provider((ref) => AppRouter(ref: ref));
