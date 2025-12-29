import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../base/core/base_hook_widget.dart';
import '../../../../base/theme/app_dimens.dart';
import 'package:template/config/navigation/navigator.dart';
import '../../../../shared/app_buttons.dart';
import '../../../register/nav/register_nav.dart';

class RegisterNow extends BaseHookWidget {
  RegisterNow({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
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
            onPressed: () {
              ref.read(navigationProvider.notifier).navigate(GotoRegister());
            },
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
