import '../../../../domain/entities/waiting_group.dart';

class DetailState {
  final WaitingGroup? waitingGroup;

  DetailState({this.waitingGroup});

  DetailState copyWith({WaitingGroup? waitingGroup}) {
    return DetailState(waitingGroup: waitingGroup ?? this.waitingGroup);
  }
}
