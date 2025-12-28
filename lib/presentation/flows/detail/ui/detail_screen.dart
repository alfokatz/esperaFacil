import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/domain/entities/photo.dart';
import 'package:template/presentation/base/content_state/content_state_widget.dart';
import 'package:template/presentation/base/core/base_hook_widget.dart';
import 'package:template/presentation/base/core/base_stateful_widget.dart';
import 'package:template/presentation/flows/detail/providers/detail_provider.dart';
import 'package:template/presentation/shared/photo_card_widget.dart';
import 'package:template/presentation/base/theme/app_dimens.dart';

class DetailScreen extends StatefulHookConsumerWidget {
  late int id;

  DetailScreen({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends BaseStatefulWidget<DetailScreen> {
  @override
  void initState() {
    runAfterPostFrameCallback(() {
      ref.read(detailProvider.notifier).init(id: widget.id);
    });
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    final photo = ref.watch(
      detailProvider.select((selector) => selector.photo),
    );

    return SafeArea(
      child: ContentStateWidget(
        appBar: AppBar(
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
        child: photo != null ? _DetailContent(photo: photo) : SizedBox.shrink(),
      ),
    );
  }
}

class _DetailContent extends BaseHookWidget {
  final Photo photo;

  _DetailContent({required this.photo});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [PhotoCardWidget(photo: photo)],
    );
  }
}
