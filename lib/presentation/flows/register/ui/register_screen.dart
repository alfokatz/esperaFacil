import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/presentation/base/content_state/content_state_provider.dart';
import 'package:template/presentation/base/content_state/content_state_widget.dart';
import 'package:template/presentation/base/core/base_stateful_widget.dart';
import 'package:template/presentation/base/theme/app_dimens.dart';

import '../../../base/theme/app_images.dart';

class RegisterScreen extends StatefulHookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseStatefulWidget<RegisterScreen> {
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
            child: Placeholder(),
          ),
        ),
      ),
    );
  }
}
