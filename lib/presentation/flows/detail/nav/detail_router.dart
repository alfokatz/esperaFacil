import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/presentation/flows/detail/ui/detail_screen.dart';
import 'package:template/presentation/flows/error_page/nav/error_router.dart';

class DetailRouter {
  static const String detailRouteName = 'Detail';
  static const String detailRoutePath = '/Detail/:id';

  static GoRoute getRoute() {
    return GoRoute(
      name: detailRouteName,
      path: detailRoutePath,
      pageBuilder: (context, state) {
        final id = state.pathParameters['id'];
        if (id != null) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: DetailScreen(id: int.parse(id)),
            name: detailRouteName,
          );
        } else {
          return ErrorNav.getErrorPage(exception: null);
        }
      },
    );
  }
}
