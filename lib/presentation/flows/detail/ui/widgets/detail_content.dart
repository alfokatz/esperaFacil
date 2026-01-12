import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../base/core/base_hook_widget.dart';
import '../../../../base/theme/app_dimens.dart';
import '../../providers/detail_provider.dart';
import 'client_contact_details.dart';
import 'client_summary_card.dart';

class DetailContent extends BaseHookWidget {
  final String waitingGroupId;
  DetailContent({super.key, required this.waitingGroupId});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(detailProvider);
    final waitingGroup = detailState.waitingGroup;

    if (waitingGroup == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          // Tarjeta resumen del cliente (arriba)
          ClientSummaryCard(),
          const SizedBox(height: AppDimens.mediumMargin),
          // Información de contacto del cliente (medio)
          ClientContactDetails(),
          // Espacio adicional al final para que el contenido no quede pegado al bottom bar
          const SizedBox(height: AppDimens.mediumMargin),
        ],
      ),
    );
  }
}
