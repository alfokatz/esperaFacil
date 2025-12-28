import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../ui/login_screen.dart';

class LoginRouter {
  static const String loginRouteName = 'Login';

  static GoRoute getRoute() {
    return GoRoute(
      name: loginRouteName,
      path: '/Login',
      pageBuilder:
          (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: LoginScreen(),
            name: loginRouteName,
          ),
    );
  }
}
