import 'package:flutter/material.dart';

import '../../../../base/theme/app_dimens.dart';
import '../../../../shared/app_buttons.dart';

class RegisterNow extends StatelessWidget {
  const RegisterNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppDimens.smallMargin,
      children: [
        Text(
          '¿No tienes una cuenta?',
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF999999)),
        ),
        SizedBox(
          width: double.infinity,
          child: CustomOutlinedButton(
            height: 45,
            onPressed: () {},
            label: 'Registrarse',
            backgroundColor: Colors.white,
            borderColor: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.primary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
