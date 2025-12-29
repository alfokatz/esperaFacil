import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/config/navigation/navigator.dart';
import 'package:template/infraestructure/managers/preferences_manager_impl.dart';
import 'package:template/infraestructure/repositories/auth_repository_impl.dart';
import 'package:template/presentation/base/providers/base_state_notifier.dart';
import 'package:template/presentation/flows/login/nav/login_nav.dart';

import '../states/register_action.dart';
import '../states/register_state.dart';

class RegisterProvider
    extends BaseStateNotifier<RegisterState, RegisterAction> {
  RegisterProvider({required super.ref})
    : super(
        state: RegisterState(
          email: '',
          password: '',
          confirmPassword: '',
          businessName: '',
        ),
      ) {
    // Mostrar el contenido inmediatamente ya que no hay datos que cargar
    showContent();
  }

  void updateEmail({required String email}) {
    reducer(action: UpdateEmailAction(email: email));
  }

  void updatePassword(String password) {
    reducer(action: UpdatePasswordAction(password: password));
  }

  void updateConfirmPassword(String confirmPassword) {
    reducer(
      action: UpdateConfirmPasswordAction(confirmPassword: confirmPassword),
    );
  }

  void updateBusinessName(String businessName) {
    reducer(action: UpdateBusinessNameAction(businessName: businessName));
  }

  void togglePasswordVisibility() {
    reducer(action: TogglePasswordVisibilityAction());
  }

  void toggleConfirmPasswordVisibility() {
    reducer(action: ToggleConfirmPasswordVisibilityAction());
  }

  Future<void> onRegister() async {
    // Validar campos
    if (state.businessName.isEmpty) {
      showErrorAlert(
        title: 'Error de validación',
        message: 'El nombre del negocio es requerido',
      );
      return;
    }

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

    if (state.confirmPassword.isEmpty) {
      showErrorAlert(
        title: 'Error de validación',
        message: 'Debes confirmar tu contraseña',
      );
      return;
    }

    if (state.password != state.confirmPassword) {
      showErrorAlert(
        title: 'Error de validación',
        message: 'Las contraseñas no coinciden',
      );
      return;
    }

    // Si todo es válido, proceder con el registro
    // Guardar valores locales para evitar acceder a state después del dispose
    final email = state.email;
    final password = state.password;
    final businessName = state.businessName;

    reducer(action: RegisterActionButton());
    showLoading();

    final authRepository = ref.read(authRepositoryProvider);
    final preferencesManager = ref.read(preferenceManagerProvider);
    final navigation = ref.read(navigationProvider.notifier);

    // Registrar el usuario
    final signUpResult = await authRepository.signUp(
      email: email,
      password: password,
    );

    signUpResult.fold(
      (error) {
        showContent();
        showErrorAlert(
          title: 'Error de registro',
          message:
              (error.message?.isNotEmpty ?? false)
                  ? error.message!
                  : 'No se pudo crear la cuenta. Por favor, intenta nuevamente.',
        );
      },
      (_) async {
        // Después del registro exitoso, hacer login automático
        final signInResult = await authRepository.signIn(
          email: email,
          password: password,
        );

        signInResult.fold(
          (error) {
            showContent();
            showErrorAlert(
              title: 'Cuenta creada',
              message:
                  'Tu cuenta fue creada exitosamente, pero hubo un error al iniciar sesión. Por favor, inicia sesión manualmente.',
            );
            // Navegar a login para que el usuario inicie sesión manualmente
            // (opcional, puedes comentar esta línea si prefieres mantenerlo en register)
          },
          (token) async {
            // Crear el perfil con el nombre del negocio (después del login)
            final profileResult = await authRepository.createProfile(
              businessName: businessName,
            );

            profileResult.fold(
              (error) {
                // Si hay error al crear el perfil, pero el login fue exitoso,
                // guardamos el token de todas formas y mostramos advertencia
                showContent();
                showWarningAlert(
                  title: 'Registro parcial',
                  message:
                      'Tu cuenta fue creada, pero hubo un problema al guardar los datos del negocio. Por favor, completa tu perfil más tarde.',
                );
              },
              (_) {
                // Todo bien, continuar normalmente
              },
            );

            // Guardar el token
            await preferencesManager.saveToken(token: token);
            showContent();

            showSuccessAlert(
              title: 'Registro exitoso',
              message:
                  'Tu cuenta ha sido creada e iniciado sesión correctamente',
            );

            // Navegar a la pantalla de home
            navigation.navigate(GotoHome());
          },
        );
      },
    );
  }

  @override
  void reducer({required RegisterAction action}) {
    switch (action) {
      case UpdateEmailAction():
        state = state.copyWith(email: action.email);
      case UpdatePasswordAction():
        state = state.copyWith(password: action.password);
      case UpdateConfirmPasswordAction():
        state = state.copyWith(confirmPassword: action.confirmPassword);
      case UpdateBusinessNameAction():
        state = state.copyWith(businessName: action.businessName);
      case TogglePasswordVisibilityAction():
        state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
      case ToggleConfirmPasswordVisibilityAction():
        state = state.copyWith(
          isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
        );
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
