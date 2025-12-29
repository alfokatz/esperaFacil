import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../ui/register_screen.dart';

class RegisterRouter {
  static const String registerRouteName = 'Register';

  static GoRoute getRoute() {
    return GoRoute(
      name: registerRouteName,
      path: '/Register',
      pageBuilder:
          (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: RegisterScreen(),
            name: registerRouteName,
          ),
    );
  }
}
