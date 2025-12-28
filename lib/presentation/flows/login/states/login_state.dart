class LoginState {
  final String email;
  final String password;
  final bool isPasswordVisible;

  LoginState({
    required this.email,
    required this.password,
    this.isPasswordVisible = false,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isPasswordVisible,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}
