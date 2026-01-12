import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/presentation/base/navigation/navigation_event.dart';
import 'package:template/presentation/flows/detail/nav/detail_router.dart';

class GotoDetail extends NavigationEvent {
  final String waitingGroupId;

  GotoDetail({required this.waitingGroupId});

  @override
  void navigate({required BuildContext context}) {
    context.pushNamed(
      DetailRouter.detailRouteName,
      pathParameters: {'id': waitingGroupId},
    );
  }
}
