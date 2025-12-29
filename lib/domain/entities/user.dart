class User {
  final String id;
  final String? email;
  final String? createdAt;
  final String? updatedAt;

  User({
    required this.id,
    this.email,
    this.createdAt,
    this.updatedAt,
  });
}

