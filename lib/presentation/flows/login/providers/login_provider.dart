import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/config/navigation/navigator.dart';
import 'package:template/infraestructure/managers/preferences_manager_impl.dart';
import 'package:template/infraestructure/repositories/auth_repository_impl.dart';
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

  Future<void> onLogin() async {
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
    // Guardar valores locales para evitar acceder a state después del dispose
    final email = state.email;
    final password = state.password;

    reducer(action: LoginActionButton());
    showLoading();

    final authRepository = ref.read(authRepositoryProvider);
    final preferencesManager = ref.read(preferenceManagerProvider);
    final navigation = ref.read(navigationProvider.notifier);

    final result = await authRepository.signIn(
      email: email,
      password: password,
    );

    result.fold(
      (error) {
        showContent();
        showErrorAlert(
          title: 'Error de autenticación',
          message:
              (error.message?.isNotEmpty ?? false)
                  ? error.message!
                  : 'No se pudo iniciar sesión. Por favor, intenta nuevamente.',
        );
      },
      (token) async {
        // Guardar el token (PreferencesManager lo sincronizará con Supabase)
        await preferencesManager.saveToken(token: token);
        showContent();

        // Navegar a la pantalla de home
        navigation.navigate(GotoHome());
      },
    );
  }

  Future<void> onForgotPassword() async {
    reducer(action: LoginActionForgotPassword());

    // Guardar valor local para evitar acceder a state después del dispose
    final email = state.email;

    // Validar que haya un email
    if (email.isEmpty) {
      showErrorAlert(
        title: 'Error de validación',
        message: 'Por favor ingresa tu correo electrónico',
      );
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      showErrorAlert(
        title: 'Error de validación',
        message: 'El correo electrónico no es válido',
      );
      return;
    }

    showLoading();

    final authRepository = ref.read(authRepositoryProvider);

    final result = await authRepository.resetPassword(email: email);

    result.fold(
      (error) {
        showContent();
        showErrorAlert(
          title: 'Error',
          message:
              (error.message?.isNotEmpty ?? false)
                  ? error.message!
                  : 'No se pudo enviar el correo de recuperación. Por favor, intenta nuevamente.',
        );
      },
      (_) {
        showContent();
        showSuccessAlert(
          title: 'Correo enviado',
          message: 'Se ha enviado un correo de recuperación a $email',
        );
      },
    );
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
