import 'package:flutter/material.dart';

import '../../../../base/theme/app_dimens.dart';

class VersionText extends StatelessWidget {
  const VersionText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: AppDimens.mediumMargin),
      child: Text(
        'Versión 2.0.1 Enterprise',
        style: theme.textTheme.bodySmall?.copyWith(
          color: const Color(0xFF999999),
        ),
      ),
    );
  }
}
