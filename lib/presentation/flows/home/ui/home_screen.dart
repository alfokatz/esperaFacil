import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/domain/entities/photo.dart';
import 'package:template/presentation/base/content_state/content_state_widget.dart';
import 'package:template/presentation/base/core/base_hook_widget.dart';
import 'package:template/presentation/base/core/base_stateful_widget.dart';
import 'package:template/presentation/flows/home/providers/home_provider.dart';
import 'package:template/presentation/shared/photo_card_widget.dart';
import 'package:template/presentation/base/theme/app_dimens.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseStatefulWidget<HomeScreen> {
  @override
  void initState() {
    runAfterPostFrameCallback(() {
      ref.read(homeProvider.notifier).init();
    });

    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    final photos = ref.watch(
      homeProvider.select((selector) => selector.photos),
    );
    final size = MediaQuery.of(context).size;
    return ContentStateWidget(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: _ListPhoto(photos: photos),
      ),
    );
  }
}

class _ListPhoto extends BaseHookWidget {
  final List<Photo> photos;

  _ListPhoto({required this.photos});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppDimens.smallMargin),
      itemCount: photos.length,
      itemBuilder: (BuildContext context, int index) {
        return ElasticIn(
          delay: const Duration(milliseconds: 150),
          child: PhotoCardWidget(
            photo: photos[index],
            onClick: (photo) {
              ref.read(homeProvider.notifier).onTapPhoto(photo: photo);
            },
          ),
        );
      },
    );
  }
}
