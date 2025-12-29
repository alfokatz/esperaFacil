sealed class RegisterAction {}

class UpdateEmailAction extends RegisterAction {
  final String email;
  UpdateEmailAction({required this.email});
}

class UpdatePasswordAction extends RegisterAction {
  final String password;
  UpdatePasswordAction({required this.password});
}

class UpdateConfirmPasswordAction extends RegisterAction {
  final String confirmPassword;
  UpdateConfirmPasswordAction({required this.confirmPassword});
}

class UpdateBusinessNameAction extends RegisterAction {
  final String businessName;
  UpdateBusinessNameAction({required this.businessName});
}

class TogglePasswordVisibilityAction extends RegisterAction {}

class ToggleConfirmPasswordVisibilityAction extends RegisterAction {}

class RegisterActionButton extends RegisterAction {
  RegisterActionButton();
}
