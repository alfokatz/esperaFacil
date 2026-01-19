import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/presentation/base/content_state/content_state_widget.dart';
import 'package:template/presentation/base/core/base_stateful_widget.dart';
import 'package:template/presentation/base/theme/app_dimens.dart';
import 'package:template/presentation/flows/detail/providers/detail_provider.dart';

import 'widgets/detail_bottom_bar.dart';
import 'widgets/detail_content.dart';

class DetailScreen extends StatefulHookConsumerWidget {
  final String waitingGroupId;

  const DetailScreen({super.key, required this.waitingGroupId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends BaseStatefulWidget<DetailScreen> {
  @override
  void initState() {
    super.initState();
    // Inicializar después del primer frame para asegurar que el provider esté montado
    runAfterPostFrameCallback(() {
      ref.read(detailProvider.notifier).init(id: widget.waitingGroupId);
    });
  }

  @override
  Widget buildView(BuildContext context) {
    // Observar el provider para mantenerlo vivo
    ref.watch(detailProvider);

    return Container(
      color: const Color(0xFFF5F5F5),
      child: SafeArea(
        child: ContentStateWidget(
          appBar: AppBar(
            backgroundColor: const Color(0xFFF5F5F5),
            title: Text(
              'detail_title'.tr(),
              style: TextTheme.of(context).titleLarge,
            ),
            elevation: AppDimens.elevationMin,
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              child: const Icon(Icons.arrow_back, color: Colors.black),
              onTap: () {
                GoRouter.of(context).pop();
              },
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: DetailContent(waitingGroupId: widget.waitingGroupId),
              ),
              DetailBottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
