import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/presentation/base/content_state/content_state_widget.dart';
import 'package:template/presentation/base/core/base_stateful_widget.dart';
import 'package:template/presentation/flows/home/providers/home_provider.dart';
import 'package:template/presentation/flows/home/ui/widgets/home_content.dart';

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
    return ContentStateWidget(child: const HomeContent());
  }
}
