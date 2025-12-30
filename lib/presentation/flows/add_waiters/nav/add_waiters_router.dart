import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../ui/add_waiters_screen.dart';

class AddWaitersRouter {
  static const String addWaitersRouteName = 'AddWaiters';

  static GoRoute getRoute() {
    return GoRoute(
      name: addWaitersRouteName,
      path: '/AddWaiters',
      pageBuilder:
          (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: AddWaitersScreen(),
            name: addWaitersRouteName,
          ),
    );
  }
}
