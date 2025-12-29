class RegisterState {
  final String email;
  final String password;
  final String confirmPassword;
  final String businessName;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  RegisterState({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.businessName,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
  });

  RegisterState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? businessName,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      businessName: businessName ?? this.businessName,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
    );
  }
}
