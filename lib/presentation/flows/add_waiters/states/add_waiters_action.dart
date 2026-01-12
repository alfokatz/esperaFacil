sealed class AddWaitersAction {}

class UpdateNameAction extends AddWaitersAction {
  final String name;
  UpdateNameAction({required this.name});
}

class UpdatePeopleCountAction extends AddWaitersAction {
  final int peopleCount;
  UpdatePeopleCountAction({required this.peopleCount});
}

class UpdateEstimatedWaitMinutesAction extends AddWaitersAction {
  final int? estimatedWaitMinutes;
  UpdateEstimatedWaitMinutesAction({required this.estimatedWaitMinutes});
}

class UpdateNotesAction extends AddWaitersAction {
  final String notes;
  UpdateNotesAction({required this.notes});
}

class AddClientAction extends AddWaitersAction {
  AddClientAction();
}
