import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../base/core/base_hook_widget.dart';
import '../../../../base/theme/app_dimens.dart';
import '../../providers/add_waiters_provider.dart';

class PeopleCountField extends BaseHookWidget {
  PeopleCountField({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final addWaitersState = ref.watch(addWaitersProvider);
    final addWaitersNotifier = ref.read(addWaitersProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cantidad de Personas',
          style: theme.textTheme.labelLarge?.copyWith(
            color: const Color(0xFF333333),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppDimens.smallMargin),
        Row(
          children: [
            // Botón para disminuir
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
              ),
              child: IconButton(
                icon: const Icon(Icons.remove, color: Color(0xFF666666)),
                onPressed:
                    addWaitersState.peopleCount > 1
                        ? () => addWaitersNotifier.updatePeopleCount(
                          addWaitersState.peopleCount - 1,
                        )
                        : null,
                style: IconButton.styleFrom(padding: EdgeInsets.zero),
              ),
            ),
            const SizedBox(width: AppDimens.smallMargin),
            // Campo de texto con el número
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                ),
                child: Center(
                  child: Text(
                    '${addWaitersState.peopleCount}',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: const Color(0xFF333333),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppDimens.smallMargin),
            // Botón para aumentar
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Color(0xFF666666)),
                onPressed:
                    () => addWaitersNotifier.updatePeopleCount(
                      addWaitersState.peopleCount + 1,
                    ),
                style: IconButton.styleFrom(padding: EdgeInsets.zero),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
