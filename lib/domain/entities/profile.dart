class Profile {
  final String id;
  final String? email;
  final String businessName;
  final String? createdAt;
  final String? updatedAt;

  Profile({
    required this.id,
    this.email,
    required this.businessName,
    this.createdAt,
    this.updatedAt,
  });
}

