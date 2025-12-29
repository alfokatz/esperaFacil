class WaitingGroup {
  final String id;
  final String businessId;
  final String name;
  final int peopleCount;
  final String status; // 'waiting', 'notified', 'served', 'cancelled'
  final String? photoUrl;
  final String? createdAt;
  final String? notifiedAt;
  final String? servedAt;
  final String? cancelledAt;

  WaitingGroup({
    required this.id,
    required this.businessId,
    required this.name,
    required this.peopleCount,
    required this.status,
    this.photoUrl,
    this.createdAt,
    this.notifiedAt,
    this.servedAt,
    this.cancelledAt,
  });

  int get waitingMinutes {
    if (createdAt == null) return 0;
    final created = DateTime.parse(createdAt!);
    final now = DateTime.now();
    return now.difference(created).inMinutes;
  }
}

