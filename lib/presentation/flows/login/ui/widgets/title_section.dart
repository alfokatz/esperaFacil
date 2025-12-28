import 'package:flutter/material.dart';

import '../../../../base/theme/app_dimens.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          'Gestiona tu Negocio',
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF333333),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimens.smallMargin),
        Text(
          'Ingresa tus credenciales para acceder al sistema.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF666666),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
