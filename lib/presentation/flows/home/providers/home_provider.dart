import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/domain/repositories/profile_repository.dart';
import 'package:template/domain/repositories/waiting_group_repository.dart';
import 'package:template/infraestructure/repositories/profile_repository_impl.dart';
import 'package:template/infraestructure/repositories/waiting_group_repository_impl.dart';
import 'package:template/presentation/base/providers/base_state_notifier.dart';
import 'package:template/presentation/flows/home/states/home_action.dart';
import 'package:template/presentation/flows/home/states/home_state.dart';
import 'package:template/presentation/flows/home/ui/widgets/waiters_filter.dart';

class HomeProvider extends BaseStateNotifier<HomeState, HomeAction> {
  final ProfileRepository profileRepository;
  final WaitingGroupRepository waitingGroupRepository;

  HomeProvider({
    required super.ref,
    required this.profileRepository,
    required this.waitingGroupRepository,
  }) : super(state: HomeState()) {
    init();
  }

  void init() async {
    showLoading();
    await loadHomeData();
  }

  Future<void> loadHomeData() async {
    // Cargar perfil primero
    final profileResult = await profileRepository.getProfile();

    profileResult.fold(
      (error) {
        showContent();
        showErrorAlert(
          title: 'Error',
          message:
              (error.message?.isNotEmpty ?? false)
                  ? error.message!
                  : 'No se pudo cargar la información del negocio',
        );
        return;
      },
      (profile) async {
        // Luego cargar waiting groups
        final waitingGroupsResult =
            await waitingGroupRepository.getWaitingGroups();

        waitingGroupsResult.fold(
          (error) {
            // Si falla cargar waiting groups, mostrar el perfil pero con lista vacía
            reducer(
              action: LoadHomeDataAction(
                businessName: profile.businessName,
                waitingGroupsCount: 0,
                waiters: [],
              ),
            );
            showContent();
            showErrorAlert(
              title: 'Advertencia',
              message:
                  (error.message?.isNotEmpty ?? false)
                      ? error.message!
                      : 'No se pudo cargar los grupos en espera',
            );
          },
          (waitingGroups) {
            // Filtrar solo los que están esperando o notificados (no servidos ni cancelados)
            final activeGroups =
                waitingGroups
                    .where(
                      (wg) => wg.status == 'waiting' || wg.status == 'notified',
                    )
                    .toList();

            // Convertir WaitingGroup a Map para mantener compatibilidad con el estado actual
            final waiters =
                activeGroups
                    .map(
                      (wg) => {
                        'id': wg.id,
                        'name': wg.name,
                        'photoUrl': wg.photoUrl,
                        'peopleCount': wg.peopleCount,
                        'waitingMinutes': wg.waitingMinutes,
                        'status': wg.status,
                      },
                    )
                    .toList();

            reducer(
              action: LoadHomeDataAction(
                businessName: profile.businessName,
                waitingGroupsCount: activeGroups.length,
                waiters: waiters,
              ),
            );
            showContent();
          },
        );
      },
    );
  }

  void setFilter(WaitersFilterType filter) {
    state = state.copyWith(selectedFilter: filter);
  }

  Future<void> cancelWaiter(String id) async {
    showLoading();
    final result = await waitingGroupRepository.cancelWaitingGroup(id: id);

    result.fold(
      (error) {
        showContent();
        showErrorAlert(
          title: 'Error',
          message:
              (error.message?.isNotEmpty ?? false)
                  ? error.message!
                  : 'No se pudo cancelar el grupo',
        );
      },
      (_) {
        // Recargar los datos
        loadHomeData();
      },
    );
  }

  Future<void> notifyWaiter(String id) async {
    showLoading();
    final result = await waitingGroupRepository.notifyWaitingGroup(id: id);

    result.fold(
      (error) {
        showContent();
        showErrorAlert(
          title: 'Error',
          message:
              (error.message?.isNotEmpty ?? false)
                  ? error.message!
                  : 'No se pudo notificar al grupo',
        );
      },
      (_) {
        // Recargar los datos
        loadHomeData();
      },
    );
  }

  Future<void> serveWaiter(String id) async {
    showLoading();
    final result = await waitingGroupRepository.serveWaitingGroup(id: id);

    result.fold(
      (error) {
        showContent();
        showErrorAlert(
          title: 'Error',
          message:
              (error.message?.isNotEmpty ?? false)
                  ? error.message!
                  : 'No se pudo marcar como servido',
        );
      },
      (_) {
        // Recargar los datos
        loadHomeData();
      },
    );
  }

  void onSettingsPressed() {
    // TODO: Navigate to settings
  }

  void onAddWaiter() {
    // TODO: Navigate to add waiter screen
  }

  List<Map<String, dynamic>> getFilteredWaiters() {
    switch (state.selectedFilter) {
      case WaitersFilterType.all:
        return state.waiters;
      case WaitersFilterType.waiting:
        return state.waiters.where((w) => w['status'] == 'waiting').toList();
      case WaitersFilterType.notified:
        return state.waiters.where((w) => w['status'] == 'notified').toList();
    }
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
    }
  }
}

final homeProvider = StateNotifierProvider.autoDispose<HomeProvider, HomeState>(
  (ref) => HomeProvider(
    ref: ref,
    profileRepository: ref.watch(profileRepositoryProvider),
    waitingGroupRepository: ref.watch(waitingGroupRepositoryProvider),
  ),
);
