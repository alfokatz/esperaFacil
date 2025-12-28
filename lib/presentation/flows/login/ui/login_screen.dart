import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/presentation/base/content_state/content_state_provider.dart';
import 'package:template/presentation/base/content_state/content_state_widget.dart';
import 'package:template/presentation/base/core/base_stateful_widget.dart';
import 'package:template/presentation/base/theme/app_dimens.dart';

import '../../../base/theme/app_images.dart';
import 'widgets/login_form.dart';
import 'widgets/title_section.dart';
import 'widgets/version_text.dart';

class LoginScreen extends StatefulHookConsumerWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseStatefulWidget<LoginScreen> {
  @override
  void initState() {
    super.initState();
    runAfterPostFrameCallback(() {
      // Mostrar el contenido inmediatamente, ya que no hay datos que cargar
      ref.read(contentStateNotifierProvider.notifier).setShowContent();
    });
  }

  @override
  Widget buildView(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ContentStateWidget(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.mediumMargin,
            ),
            child: SizedBox(
              width: size.width,
              child: Column(
                children: [
                  const SizedBox(height: AppDimens.largeMargin),
                  AppImages.appLogo(width: 100, height: 100),
                  const SizedBox(height: AppDimens.mediumMargin),
                  TitleSection(),
                  const SizedBox(height: AppDimens.mediumMargin),
                  LoginForm(),
                  const SizedBox(height: AppDimens.mediumMargin),
                  const VersionText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
