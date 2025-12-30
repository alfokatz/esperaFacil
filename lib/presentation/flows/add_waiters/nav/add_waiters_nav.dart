import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/presentation/base/navigation/navigation_event.dart';
import 'package:template/presentation/flows/add_waiters/nav/add_waiters_router.dart';

class GotoAddWaiters extends NavigationEvent {
  @override
  void navigate({required BuildContext context}) {
    context.pushNamed(AddWaitersRouter.addWaitersRouteName);
  }
}
