import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/config/navigation/navigator.dart';
import 'package:template/presentation/base/providers/base_state_notifier.dart';
import 'package:template/presentation/flows/login/nav/login_nav.dart';

import '../states/register_action.dart';
import '../states/register_state.dart';

class RegisterProvider
    extends BaseStateNotifier<RegisterState, RegisterAction> {
  RegisterProvider({required super.ref})
    : super(state: RegisterState(email: '', password: '')) {
    // Mostrar el contenido inmediatamente ya que no hay datos que cargar
    showContent();
  }

  void onRegister() {
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
    reducer(action: RegisterActionButton());
    // TODO: Implementar lógica de login (guardar token, etc.)

    // Navegar a la pantalla de home
    ref.read(navigationProvider.notifier).navigate(GotoHome());
  }

  @override
  void reducer({required RegisterAction action}) {
    switch (action) {
      case RegisterActionButton():
        // La lógica de registro se maneja en onRegister()
        break;
    }
  }
}

final registerProvider =
    StateNotifierProvider.autoDispose<RegisterProvider, RegisterState>(
      (ref) => RegisterProvider(ref: ref),
    );
