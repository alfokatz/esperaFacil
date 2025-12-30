import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../base/core/base_hook_widget.dart';
import '../../../../base/theme/app_dimens.dart';
import '../../providers/add_waiters_provider.dart';

class ClientNameField extends BaseHookWidget {
  ClientNameField({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final addWaitersNotifier = ref.read(addWaitersProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nombre del Cliente',
          style: theme.textTheme.labelLarge?.copyWith(
            color: const Color(0xFF333333),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppDimens.smallMargin),
        TextField(
          onChanged: addWaitersNotifier.updateName,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            hintText: 'Ej: Juan Pérez',
            hintStyle: const TextStyle(color: Color(0xFF999999), fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2196F3), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            suffixIcon: const Icon(
              Icons.person_outline,
              color: Color(0xFF999999),
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
