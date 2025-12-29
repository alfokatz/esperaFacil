import 'package:flutter/material.dart';

import '../../../../base/theme/app_dimens.dart';

class RegisterTitleSection extends StatelessWidget {
  const RegisterTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          'Crea tu Cuenta',
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF333333),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimens.smallMargin),
        Text(
          'Completa los datos para comenzar a gestionar tu negocio.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF666666),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

