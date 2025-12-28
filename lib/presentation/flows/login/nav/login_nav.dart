import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/presentation/base/navigation/navigation_event.dart';
import 'package:template/presentation/flows/home/nav/home_router.dart';

class GotoHome extends NavigationEvent {
  @override
  void navigate({required BuildContext context}) {
    context.pushReplacementNamed(HomeRouter.homeRouteName);
  }
}
