import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/domain/entities/photo.dart';
import 'package:template/domain/use_cases/get_photo_by_id_use_case.dart';
import 'package:template/presentation/base/providers/base_state_notifier.dart';
import 'package:template/presentation/flows/detail/states/detail_action.dart';
import 'package:template/presentation/flows/detail/states/detail_state.dart';

class DetailProvider extends BaseStateNotifier<DetailState, DetailAction> {
  final GetPhotoByIdUseCase getPhotoByIdUseCase;

  DetailProvider({
    required super.ref,
    required this.getPhotoByIdUseCase,
  }) : super(state: DetailState());

  void init({required int id}) async {
    _callGetPhotoByIdUseCase(id: id);
  }

  void _callGetPhotoByIdUseCase({required int id}) {
    showLoading();
    super.callService<Photo>(
      service: () => getPhotoByIdUseCase(params: id),
      onSuccess: (photo) {
        reducer(
          action: Load(photo: photo),
        );
        showContent();
      },
      onCustomError: (error) {},
    );
  }

  void like() {
    reducer(
      action: Like(like: state.like + 1),
    );
  }

  void dislike() {
    reducer(
      action: Dislike(dislike: state.dislike + 1),
    );
  }

  @override
  void reducer({required DetailAction action}) {
    switch (action) {
      case Load():
        state = state.copyWith(photo: action.photo);
      case Like():
        state = state.copyWith(like: action.like);
      case Dislike():
        state = state.copyWith(dislike: action.dislike);
    }
  }
}

final detailProvider =
    StateNotifierProvider.autoDispose<DetailProvider, DetailState>(
  (ref) {
    final notifier = DetailProvider(
      getPhotoByIdUseCase: ref.watch(getPhotoByIdUseCase),
      ref: ref,
    );
    return notifier;
  },
);
