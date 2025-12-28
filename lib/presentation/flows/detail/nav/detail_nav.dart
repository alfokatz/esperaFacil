import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/domain/entities/photo.dart';
import 'package:template/presentation/base/navigation/navigation_event.dart';
import 'package:template/presentation/flows/detail/nav/detail_router.dart';

class GotoDetail extends NavigationEvent {
  final String photoId;

  GotoDetail({required this.photoId});

  @override
  void navigate({required BuildContext context}) {
    context.pushNamed(
      DetailRouter.detailRouteName,
      pathParameters: {
        'id': photoId,
      },
    );
  }
}
