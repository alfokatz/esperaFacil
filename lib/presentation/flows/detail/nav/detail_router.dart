import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/presentation/flows/detail/ui/detail_screen.dart';

class DetailRouter {
  static const String detailRouteName = 'Detail';
  static const String detailRoutePath = '/Detail/:id';

  static GoRoute getRoute() {
    return GoRoute(
      name: detailRouteName,
      path: detailRoutePath,
      pageBuilder: (context, state) {
        final String id = state.pathParameters['id'] ?? '';
        return MaterialPage<void>(
          key: state.pageKey,
          child: DetailScreen(waitingGroupId: id),
          name: detailRouteName,
        );
      },
    );
  }
}
