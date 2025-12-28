import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/config/navigation/navigator.dart';
import 'package:template/presentation/base/providers/base_state_notifier.dart';
import 'package:template/presentation/flows/login/nav/login_nav.dart';
import 'package:template/presentation/flows/login/states/login_action.dart';
import 'package:template/presentation/flows/login/states/login_state.dart';

class LoginProvider extends BaseStateNotifier<LoginState, LoginAction> {
  LoginProvider({required super.ref})
    : super(state: LoginState(email: '', password: '')) {
    // Mostrar el contenido inmediatamente ya que no hay datos que cargar
    showContent();
  }

  void updateEmail({required String email}) {
    reducer(action: UpdateEmailAction(email: email));
  }

  void updatePassword(String password) {
    reducer(action: UpdatePasswordAction(password: password));
  }

  void togglePasswordVisibility() {
    reducer(action: TogglePasswordVisibilityAction());
  }

  void onLogin() {
    // Validar campos
    if (state.email.isEmpty) {
      showErrorAlert(
        title: 'Error de validación',
        message: 'El correo electrónico es requerido',
      );
      return;
    }

    if (!state.email.contains('@') || !state.email.contains('.')) {
      showErrorAlert(
        title: 'Error de validación',
        message: 'El correo electrónico no es válido',
      );
      return;
    }

    if (state.password.isEmpty) {
      showErrorAlert(
        title: 'Error de validación',
        message: 'La contraseña es requerida',
      );
      return;
    }

    if (state.password.length < 6) {
      showErrorAlert(
        title: 'Error de validación',
        message: 'La contraseña debe tener al menos 6 caracteres',
      );
      return;
    }

    // Si todo es válido, proceder con el login
    reducer(action: LoginActionButton());
    // TODO: Implementar lógica de login (guardar token, etc.)

    // Navegar a la pantalla de home
    ref.read(navigationProvider.notifier).navigate(GotoHome());
  }

  void onForgotPassword() {
    reducer(action: LoginActionForgotPassword());
    // TODO: Implementar lógica de recuperar contraseña
  }

  @override
  void reducer({required LoginAction action}) {
    switch (action) {
      case UpdateEmailAction():
        state = state.copyWith(email: action.email);
      case UpdatePasswordAction():
        state = state.copyWith(password: action.password);
      case TogglePasswordVisibilityAction():
        state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
      case LoginActionButton():
        // La lógica de login se maneja en onLogin()
        break;
      case LoginActionForgotPassword():
        // La lógica de recuperar contraseña se maneja en onForgotPassword()
        break;
    }
  }
}

final loginProvider =
    StateNotifierProvider.autoDispose<LoginProvider, LoginState>(
      (ref) => LoginProvider(ref: ref),
    );
