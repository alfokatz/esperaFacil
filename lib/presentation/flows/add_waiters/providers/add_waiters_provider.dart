import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/config/navigation/navigator.dart';
import 'package:template/domain/use_cases/create_client_use_case.dart';
import 'package:template/presentation/base/providers/base_state_notifier.dart';
import 'package:template/presentation/flows/home/providers/home_provider.dart';
import 'package:template/presentation/flows/login/nav/login_nav.dart';

import '../states/add_waiters_action.dart';
import '../states/add_waiters_state.dart';

class AddWaitersProvider
    extends BaseStateNotifier<AddWaitersState, AddWaitersAction> {
  final CreateClientUseCase createClientUseCase;

  TextEditingController nameController = TextEditingController();
  TextEditingController estimatedWaitMinutesController =
      TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  AddWaitersProvider({required super.ref, required this.createClientUseCase})
    : super(state: AddWaitersState(name: '', peopleCount: 1)) {
    // Mostrar el contenido inmediatamente ya que no hay datos que cargar
    showContent();
  }

  void updateName(String name) {
    reducer(action: UpdateNameAction(name: name));
  }

  void updatePeopleCount(int peopleCount) {
    reducer(action: UpdatePeopleCountAction(peopleCount: peopleCount));
  }

  void updateEstimatedWaitMinutes(int? estimatedWaitMinutes) {
    reducer(
      action: UpdateEstimatedWaitMinutesAction(
        estimatedWaitMinutes: estimatedWaitMinutes,
      ),
    );
  }

  void updateNotes(String notes) {
    reducer(action: UpdateNotesAction(notes: notes));
  }

  Future<void> onAddClient() async {
    // Validar campos
    if (state.name.isEmpty) {
      showErrorAlert(
        title: 'Error de validación',
        message: 'El nombre del cliente es requerido',
      );
      return;
    }

    if (state.peopleCount < 1) {
      showErrorAlert(
        title: 'Error de validación',
        message: 'La cantidad de personas debe ser al menos 1',
      );
      return;
    }

    // Guardar valores locales para evitar acceder a state después del dispose
    final name = state.name;
    final peopleCount = state.peopleCount;
    final estimatedWaitMinutes = state.estimatedWaitMinutes;
    final notes = state.notes;
    final phoneNumber = state.phoneNumber;
    reducer(action: AddClientAction());
    showLoading();

    final navigation = ref.read(navigationProvider.notifier);

    // Crear el cliente usando el use case
    callService(
      service:
          () => createClientUseCase(
            params: CreateClientParams(
              name: name,
              peopleCount: peopleCount,
              estimatedWaitMinutes: estimatedWaitMinutes,
              notes: notes,
              phoneNumber: phoneNumber,
            ),
          ),
      onSuccess: (waitingGroup) {
        showContent();
        showSuccessAlert(
          title: 'Cliente agregado',
          message:
              'El cliente ha sido agregado exitosamente a la lista de espera',
        );

        // Agregar el nuevo cliente a la lista de waiters en HomeProvider
        try {
          final homeNotifier = ref.read(homeProvider.notifier);
          homeNotifier.addWaiter(waitingGroup);
        } catch (e) {
          // Si el provider no está disponible, no hacer nada
          // Se recargará cuando se navegue a home
        }

        // Navegar de vuelta a la pantalla de home
        navigation.navigate(GotoHome());
      },
      onCustomError: (error) {
        showContent();
        showErrorAlert(
          title: 'Error al agregar cliente',
          message:
              (error.message?.isNotEmpty ?? false)
                  ? error.message!
                  : 'No se pudo agregar el cliente. Por favor, intenta nuevamente.',
        );
      },
    );
  }

  @override
  void reducer({required AddWaitersAction action}) {
    switch (action) {
      case UpdateNameAction():
        state = state.copyWith(name: action.name);
      case UpdatePeopleCountAction():
        state = state.copyWith(peopleCount: action.peopleCount);
      case UpdateEstimatedWaitMinutesAction():
        state = state.copyWith(
          estimatedWaitMinutes: action.estimatedWaitMinutes,
        );
      case UpdateNotesAction():
        state = state.copyWith(notes: action.notes);
      case AddClientAction():
        // La lógica de agregar cliente se maneja en onAddClient()
        break;
    }
  }
}

final addWaitersProvider =
    StateNotifierProvider.autoDispose<AddWaitersProvider, AddWaitersState>(
      (ref) => AddWaitersProvider(
        ref: ref,
        createClientUseCase: ref.watch(createClientUseCase),
      ),
    );
