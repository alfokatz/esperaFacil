import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/presentation/base/content_state/content_state_provider.dart';
import 'package:template/presentation/base/content_state/content_state_widget.dart';
import 'package:template/presentation/base/core/base_stateful_widget.dart';
import 'package:template/presentation/base/theme/app_dimens.dart';
import 'package:template/presentation/flows/add_waiters/ui/widgets/add_client_form.dart';

class AddWaitersScreen extends StatefulHookConsumerWidget {
  const AddWaitersScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddWaitersScreenState();
}

class _AddWaitersScreenState extends BaseStatefulWidget<AddWaitersScreen> {
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
    return ContentStateWidget(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: false,
        title: Text(
          'Agregar Cliente',
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: AppDimens.elevationMin,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back, color: Colors.white),
          onTap: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.mediumMargin,
              vertical: AppDimens.mediumMargin,
            ),
            child: AddClientForm(),
          ),
        ),
      ),
    );
  }
}
