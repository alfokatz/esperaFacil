import 'package:template/domain/entities/photo.dart';
import 'package:template/domain/entities/waiting_group.dart';

sealed class HomeAction {}

class LoadAction extends HomeAction {
  final List<Photo> photos;

  LoadAction({this.photos = const []});
}

class LoadHomeDataAction extends HomeAction {
  final String businessName;
  final int waitingGroupsCount;
  final List<WaitingGroup> waiters;

  LoadHomeDataAction({
    required this.businessName,
    required this.waitingGroupsCount,
    required this.waiters,
  });
}

class AddWaiterAction extends HomeAction {
  final WaitingGroup waiter;

  AddWaiterAction({required this.waiter});
}
