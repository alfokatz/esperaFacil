import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/config/navigation/navigator.dart';
import 'package:template/domain/entities/waiting_group.dart';
import 'package:template/domain/repositories/profile_repository.dart';
import 'package:template/domain/use_cases/cancel_client_use_case.dart';
import 'package:template/domain/use_cases/get_all_clients_use_case.dart';
import 'package:template/domain/use_cases/notify_client_use_case.dart';
import 'package:template/domain/use_cases/serve_client_use_case.dart';
import 'package:template/infraestructure/repositories/profile_repository_impl.dart';
import 'package:template/presentation/base/providers/base_state_notifier.dart';
import 'package:template/presentation/flows/add_waiters/nav/add_waiters_nav.dart';
import 'package:template/presentation/flows/home/states/home_action.dart';
import 'package:template/presentation/flows/home/states/home_state.dart';
import 'package:template/presentation/flows/home/ui/widgets/waiters_filter.dart';

class HomeProvider extends BaseStateNotifier<HomeState, HomeAction> {
  final ProfileRepository profileRepository;
  final GetAllClientsUseCase getAllClientsUseCase;
  final CancelClientUseCase cancelClientUseCase;
  final NotifyClientUseCase notifyClientUseCase;
  final ServeClientUseCase serveClientUseCase;

  HomeProvider({
    required super.ref,
    required this.profileRepository,
    required this.getAllClientsUseCase,
    required this.cancelClientUseCase,
    required this.notifyClientUseCase,
    required this.serveClientUseCase,
  }) : super(state: HomeState()) {
    // Mantener el provider vivo durante la inicialización
    //ref.keepAlive();
    // Diferir la inicialización hasta después de que el provider esté completamente construido
    Future.microtask(() => init());
  }

  void init() async {
    showLoading();
    await loadHomeData();
  }

  Future<void> _loadClients({required String businessName}) async {
    showLoading();
    // Capturar el businessName antes de la llamada asíncrona
    final currentBusinessName = businessName;

    await callService<List<WaitingGroup>>(
      service: () => getAllClientsUseCase(params: () {}),
      onSuccess: (waitingGroups) {
        try {
          // Filtrar solo los que están esperando o notificados (no servidos ni cancelados)
          final activeGroups =
              waitingGroups
                  .where(
                    (wg) => wg.status == 'waiting' || wg.status == 'notified',
                  )
                  .toList();

          showContent();
          reducer(
            action: LoadHomeDataAction(
              businessName: currentBusinessName,
              waitingGroupsCount: activeGroups.length,
              waiters: activeGroups,
            ),
          );
        } catch (e) {
          // El provider fue desechado, ignorar el error
          return;
        }
      },
      onCustomError: (error) {
        try {
          showContent();
          showErrorAlert(
            title: 'Advertencia',
            message:
                (error.message?.isNotEmpty ?? false)
                    ? error.message!
                    : 'No se pudo cargar los clientes',
          );
        } catch (e) {
          // El provider fue desechado, ignorar el error
          return;
        }
      },
    );
  }

  Future<void> loadHomeData() async {
    // Cargar perfil primero
    final profileResult = await profileRepository.getProfile();

    profileResult.fold(
      (error) {
        try {
          showContent();
          showErrorAlert(
            title: 'Error',
            message:
                (error.message?.isNotEmpty ?? false)
                    ? error.message!
                    : 'No se pudo cargar la información del negocio',
          );
        } catch (e) {
          // El provider fue desechado, ignorar el error
          return;
        }
        return;
      },
      (profile) async {
        try {
          // Actualizar el businessName primero
          reducer(
            action: LoadHomeDataAction(
              businessName: profile.businessName,
              waitingGroupsCount: state.waitingGroupsCount,
              waiters: state.waiters,
            ),
          );
          // Luego cargar waiting groups usando el use case
          await _loadClients(businessName: profile.businessName);
        } catch (e) {
          // El provider fue desechado, ignorar el error
          return;
        }
      },
    );
  }

  void setFilter(WaitersFilterType filter) {
    state = state.copyWith(selectedFilter: filter);
  }

  void addWaiter(WaitingGroup waiter) {
    // Solo agregar si el status es 'waiting' o 'notified'
    if (waiter.status == 'waiting' || waiter.status == 'notified') {
      final updatedWaiters = [waiter, ...state.waiters];
      // Actualizar el estado con el nuevo waiter y el contador
      state = state.copyWith(
        waiters: updatedWaiters,
        waitingGroupsCount: updatedWaiters.length,
      );
    }
  }

  List<WaitingGroup> getFilteredWaiters() {
    switch (state.selectedFilter) {
      case WaitersFilterType.all:
        return state.waiters;
      case WaitersFilterType.waiting:
        return state.waiters.where((w) => w.status == 'waiting').toList();
      case WaitersFilterType.notified:
        return state.waiters.where((w) => w.status == 'notified').toList();
    }
  }

  Future<void> cancelWaiter(String id) async {
    showLoading();
    callService<void>(
      service: () => cancelClientUseCase(params: id),
      onSuccess: (_) {
        try {
          // Recargar los datos
          loadHomeData();
        } catch (e) {
          // El provider fue desechado, ignorar el error
          return;
        }
      },
      onCustomError: (error) {
        try {
          showContent();
          showErrorAlert(
            title: 'Error',
            message:
                (error.message?.isNotEmpty ?? false)
                    ? error.message!
                    : 'No se pudo cancelar el grupo',
          );
        } catch (e) {
          // El provider fue desechado, ignorar el error
          return;
        }
      },
    );
  }

  Future<void> notifyWaiter(String id) async {
    showLoading();
    callService<void>(
      service: () => notifyClientUseCase(params: id),
      onSuccess: (_) {
        try {
          // Recargar los datos
          loadHomeData();
        } catch (e) {
          // El provider fue desechado, ignorar el error
          return;
        }
      },
      onCustomError: (error) {
        try {
          showContent();
          showErrorAlert(
            title: 'Error',
            message:
                (error.message?.isNotEmpty ?? false)
                    ? error.message!
                    : 'No se pudo notificar al grupo',
          );
        } catch (e) {
          // El provider fue desechado, ignorar el error
          return;
        }
      },
    );
  }

  Future<void> serveWaiter(String id) async {
    showLoading();
    callService<void>(
      service: () => serveClientUseCase(params: id),
      onSuccess: (_) {
        try {
          // Recargar los datos
          loadHomeData();
        } catch (e) {
          // El provider fue desechado, ignorar el error
          return;
        }
      },
      onCustomError: (error) {
        try {
          showContent();
          showErrorAlert(
            title: 'Error',
            message:
                (error.message?.isNotEmpty ?? false)
                    ? error.message!
                    : 'No se pudo marcar como servido',
          );
        } catch (e) {
          // El provider fue desechado, ignorar el error
          return;
        }
      },
    );
  }

  void onSettingsPressed() {
    // TODO: Navigate to settings
  }

  void onAddWaiter() {
    final navigation = ref.read(navigationProvider.notifier);
    navigation.navigate(GotoAddWaiters());
  }

  @override
  void reducer({required HomeAction action}) {
    switch (action) {
      case LoadAction():
        state = state.copyWith(photos: action.photos);
      case LoadHomeDataAction():
        state = state.copyWith(
          businessName: action.businessName,
          waitingGroupsCount: action.waitingGroupsCount,
          waiters: action.waiters,
        );
      case AddWaiterAction():
        // La lógica de agregar waiter se maneja en addWaiter()
        break;
    }
  }
}

final homeProvider = StateNotifierProvider<HomeProvider, HomeState>(
  (ref) => HomeProvider(
    ref: ref,
    profileRepository: ref.watch(profileRepositoryProvider),
    getAllClientsUseCase: ref.watch(getAllClientsUseCase),
    cancelClientUseCase: ref.watch(cancelClientUseCase),
    notifyClientUseCase: ref.watch(notifyClientUseCase),
    serveClientUseCase: ref.watch(serveClientUseCase),
  ),
);
