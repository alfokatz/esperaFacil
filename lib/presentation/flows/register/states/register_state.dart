class RegisterState {
  final String email;
  final String password;

  RegisterState({required this.email, required this.password});

  RegisterState copyWith({String? email, String? password}) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
