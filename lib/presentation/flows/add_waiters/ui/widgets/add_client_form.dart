import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../base/core/base_hook_widget.dart';
import '../../../../base/theme/app_dimens.dart';
import '../../../../shared/app_buttons.dart';
import '../../../../shared/form_field/app_form_field_with_label.dart';
import '../../../../shared/app_text_box_field.dart';
import '../../providers/add_waiters_provider.dart';
import 'people_count_field.dart';

class AddClientForm extends BaseHookWidget {
  AddClientForm({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final addWaitersNotifier = ref.read(addWaitersProvider.notifier);
    final nameController = addWaitersNotifier.nameController;
    final estimatedWaitMinutesController =
        addWaitersNotifier.estimatedWaitMinutesController;
    final phoneNumberController = addWaitersNotifier.phoneNumberController;
    final notesController = addWaitersNotifier.notesController;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppFormFieldWithLabel(
          shake: false,
          textInputType: TextInputType.text,
          title: 'Nombre del Cliente',
          hintText: 'Ej: Juan Pérez',
          controller: nameController,
          onChanged: (value) {
            addWaitersNotifier.updateName(value);
          },
        ),
        const SizedBox(height: AppDimens.mediumMargin),
        AppFormFieldWithLabel(
          shake: false,
          textInputType: TextInputType.number,
          title: 'Teléfono móvil',
          hintText: 'Ej: 099123456',
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: phoneNumberController,
          onChanged: (value) {
            addWaitersNotifier.updatePhoneNumber(value);
            if (value.isEmpty) {
              addWaitersNotifier.updatePhoneNumber(null);
            } else {
              addWaitersNotifier.updatePhoneNumber(value);
            }
          },
          required: false,
        ),
        const SizedBox(height: AppDimens.mediumMargin),
        PeopleCountField(),
        const SizedBox(height: AppDimens.mediumMargin),
        AppFormFieldWithLabel(
          shake: false,
          textInputType: TextInputType.number,
          title: 'Minutos de espera estimados',
          hintText: 'Ej: 10',
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: estimatedWaitMinutesController,
          onChanged: (value) {
            if (value.isEmpty) {
              addWaitersNotifier.updateEstimatedWaitMinutes(null);
            } else {
              final minutes = int.tryParse(value);
              if (minutes != null && minutes > 0) {
                addWaitersNotifier.updateEstimatedWaitMinutes(minutes);
              }
            }
          },
          required: false,
        ),
        AppTextBox(
          label: 'Notas del cliente',
          hintText: 'Ej: Lugar prferido, alergias, restricciones,  etc.',
          controller: notesController,
          onChanged: (value) {
            addWaitersNotifier.updateNotes(value);
          },
        ),
        const SizedBox(height: AppDimens.largeMargin),
        CustomPrimaryButton(
          height: 50,
          onPressed: addWaitersNotifier.onAddClient,
          text: 'Agregar Cliente',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: AppDimens.smallMargin),
      ],
    );
  }
}
