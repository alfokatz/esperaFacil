class AddWaitersState {
  final String name;
  final int peopleCount;
  final int? estimatedWaitMinutes;

  AddWaitersState({
    required this.name,
    required this.peopleCount,
    this.estimatedWaitMinutes,
  });

  AddWaitersState copyWith({
    String? name,
    int? peopleCount,
    int? estimatedWaitMinutes,
  }) {
    return AddWaitersState(
      name: name ?? this.name,
      peopleCount: peopleCount ?? this.peopleCount,
      estimatedWaitMinutes: estimatedWaitMinutes ?? this.estimatedWaitMinutes,
    );
  }
}
