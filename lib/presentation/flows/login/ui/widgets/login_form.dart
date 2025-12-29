import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../base/core/base_hook_widget.dart';
import '../../../../base/theme/app_dimens.dart';
import '../../../../shared/app_buttons.dart';
import '../../providers/login_provider.dart';

class LoginForm extends BaseHookWidget {
  LoginForm({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Email Field
        const SizedBox(height: AppDimens.mediumMargin),
        Text(
          'Correo Electrónico',
          style: theme.textTheme.labelLarge?.copyWith(
            color: const Color(0xFF333333),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppDimens.smallMargin),
        TextField(
          onChanged: (value) => loginNotifier.updateEmail(email: value),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'usuario@empresa.com',
            hintStyle: TextStyle(color: const Color(0xFF999999), fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2196F3), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            suffixIcon: const Icon(
              Icons.mail_outline,
              color: Color(0xFF999999),
              size: 20,
            ),
          ),
        ),

        // Password Field
        const SizedBox(height: AppDimens.mediumMargin),
        Text(
          'Contraseña',
          style: theme.textTheme.labelLarge?.copyWith(
            color: const Color(0xFF333333),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppDimens.smallMargin),
        TextField(
          onChanged: loginNotifier.updatePassword,
          obscureText: !loginState.isPasswordVisible,
          decoration: InputDecoration(
            hintText: '••••••••',
            hintStyle: TextStyle(color: const Color(0xFF999999), fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2196F3), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                loginState.isPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: const Color(0xFF999999),
                size: 20,
              ),
              onPressed: loginNotifier.togglePasswordVisibility,
            ),
          ),
        ),

        // Forgot Password Link
        const SizedBox(height: AppDimens.smallMargin),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: loginNotifier.onForgotPassword,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              '¿Olvidaste tu contraseña?',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF999999),
              ),
            ),
          ),
        ),

        // Login Button
        const SizedBox(height: AppDimens.largeMargin),
        CustomPrimaryButton(
          height: 50,
          onPressed: loginNotifier.onLogin,
          text: 'Ingresar',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
