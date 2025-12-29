import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../base/core/base_hook_widget.dart';
import '../../../../base/theme/app_dimens.dart';
import '../../../../shared/app_buttons.dart';
import '../../providers/register_provider.dart';

class RegisterForm extends BaseHookWidget {
  RegisterForm({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final registerState = ref.watch(registerProvider);
    final registerNotifier = ref.read(registerProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Business Name Field
        Text(
          'Nombre del Negocio',
          style: theme.textTheme.labelLarge?.copyWith(
            color: const Color(0xFF333333),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppDimens.smallMargin),
        TextField(
          onChanged: registerNotifier.updateBusinessName,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            hintText: 'Ej: Restaurante El Valle',
            hintStyle: const TextStyle(color: Color(0xFF999999), fontSize: 14),
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
              Icons.store_outlined,
              color: Color(0xFF999999),
              size: 20,
            ),
          ),
        ),

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
          onChanged: (value) => registerNotifier.updateEmail(email: value),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'usuario@empresa.com',
            hintStyle: const TextStyle(color: Color(0xFF999999), fontSize: 14),
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
          onChanged: registerNotifier.updatePassword,
          obscureText: !registerState.isPasswordVisible,
          decoration: InputDecoration(
            hintText: '••••••••',
            hintStyle: const TextStyle(color: Color(0xFF999999), fontSize: 14),
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
                registerState.isPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: const Color(0xFF999999),
                size: 20,
              ),
              onPressed: registerNotifier.togglePasswordVisibility,
            ),
          ),
        ),

        // Confirm Password Field
        const SizedBox(height: AppDimens.mediumMargin),
        Text(
          'Confirmar Contraseña',
          style: theme.textTheme.labelLarge?.copyWith(
            color: const Color(0xFF333333),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppDimens.smallMargin),
        TextField(
          onChanged: registerNotifier.updateConfirmPassword,
          obscureText: !registerState.isConfirmPasswordVisible,
          decoration: InputDecoration(
            hintText: '••••••••',
            hintStyle: const TextStyle(color: Color(0xFF999999), fontSize: 14),
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
                registerState.isConfirmPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: const Color(0xFF999999),
                size: 20,
              ),
              onPressed: registerNotifier.toggleConfirmPasswordVisibility,
            ),
          ),
        ),

        // Register Button
        const SizedBox(height: AppDimens.largeMargin),
        CustomPrimaryButton(
          height: 50,
          onPressed: registerNotifier.onRegister,
          text: 'Registrarse',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
