import 'package:template/domain/entities/photo.dart';

sealed class HomeAction {}

class LoadAction extends HomeAction {
  final List<Photo> photos;

  LoadAction({this.photos = const []});
}

class LoadHomeDataAction extends HomeAction {
  final String businessName;
  final int waitingGroupsCount;
  final List<Map<String, dynamic>> waiters;

  LoadHomeDataAction({
    required this.businessName,
    required this.waitingGroupsCount,
    required this.waiters,
  });
}
