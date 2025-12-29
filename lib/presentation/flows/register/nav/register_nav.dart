import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/presentation/base/navigation/navigation_event.dart';
import 'package:template/presentation/flows/register/nav/register_router.dart';

class GotoRegister extends NavigationEvent {
  @override
  void navigate({required BuildContext context}) {
    context.pushNamed(RegisterRouter.registerRouteName);
  }
}
