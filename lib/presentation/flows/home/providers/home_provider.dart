import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/config/navigation/navigator.dart';
import 'package:template/domain/entities/photo.dart';
import 'package:template/domain/use_cases/get_photos_use_case.dart';
import 'package:template/presentation/base/providers/base_state_notifier.dart';
import 'package:template/presentation/flows/detail/nav/detail_nav.dart';
import 'package:template/presentation/flows/home/states/home_action.dart';
import 'package:template/presentation/flows/home/states/home_state.dart';

class HomeProvider extends BaseStateNotifier<HomeState, HomeAction> {
  final GetPhotosUseCase getPhotosUseCase;

  HomeProvider({
    required super.ref,
    required this.getPhotosUseCase,
  }) : super(state: HomeState()) {
    init();
  }

  void init() async {
    showLoading();
    super.callService<List<Photo>>(
      service: () => getPhotosUseCase(),
      onSuccess: (photos) {
        reducer(
          action: LoadAction(photos: photos),
        );
        showContent();
      },
      onCustomError: (error) {

        },
    );
  }

  void onTapPhoto({required Photo photo}) {
    ref.read(navigationProvider.notifier).navigate(
          GotoDetail(
            photoId: photo.id.toString(),
          ),
        );
  }

  @override
  void reducer({required HomeAction action}) {
    switch (action) {
      case LoadAction():
        state = state.copyWith(
          photos: action.photos,
        );
    }
  }
}

final homeProvider = StateNotifierProvider.autoDispose<HomeProvider, HomeState>(
  (ref) => HomeProvider(
    ref: ref,
    getPhotosUseCase: ref.watch(getPhotosUseCase),
  ),
);
