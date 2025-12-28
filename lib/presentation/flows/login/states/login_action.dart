sealed class LoginAction {}

class UpdateEmailAction extends LoginAction {
  final String email;

  UpdateEmailAction({required this.email});
}

class UpdatePasswordAction extends LoginAction {
  final String password;

  UpdatePasswordAction({required this.password});
}

class TogglePasswordVisibilityAction extends LoginAction {}

class LoginActionButton extends LoginAction {
  LoginActionButton();
}

class LoginActionForgotPassword extends LoginAction {}
