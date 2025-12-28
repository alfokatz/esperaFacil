import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/presentation/base/providers/base_state_notifier.dart';
import 'package:template/presentation/flows/home/states/home_action.dart';
import 'package:template/presentation/flows/home/states/home_state.dart';
import 'package:template/presentation/flows/home/ui/widgets/waiters_filter.dart';

class HomeProvider extends BaseStateNotifier<HomeState, HomeAction> {
  HomeProvider({required super.ref}) : super(state: HomeState()) {
    init();
  }

  void init() async {
    showContent();
    // TODO: Load waiters from repository
  }

  void setFilter(WaitersFilterType filter) {
    state = state.copyWith(selectedFilter: filter);
  }

  void cancelWaiter(String id) {
    // TODO: Implement cancel waiter logic
  }

  void notifyWaiter(String id) {
    // TODO: Implement notify waiter logic
  }

  void serveWaiter(String id) {
    // TODO: Implement serve waiter logic
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
    }
  }
}

final homeProvider = StateNotifierProvider.autoDispose<HomeProvider, HomeState>(
  (ref) => HomeProvider(ref: ref),
);
