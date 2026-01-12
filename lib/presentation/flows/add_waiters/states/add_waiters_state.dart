class AddWaitersState {
  final String name;
  final int peopleCount;
  final int? estimatedWaitMinutes;
  final String? notes;
  final String? phoneNumber;
  AddWaitersState({
    required this.name,
    required this.peopleCount,
    this.estimatedWaitMinutes,
    this.notes,
    this.phoneNumber,
  });

  AddWaitersState copyWith({
    String? name,
    int? peopleCount,
    int? estimatedWaitMinutes,
    String? notes,
    String? phoneNumber,
  }) {
    return AddWaitersState(
      name: name ?? this.name,
      peopleCount: peopleCount ?? this.peopleCount,
      estimatedWaitMinutes: estimatedWaitMinutes ?? this.estimatedWaitMinutes,
      notes: notes ?? this.notes,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
