import 'package:template/domain/entities/photo.dart';

class HomeState {
  final List<Photo> photos;

  HomeState({
    this.photos = const [],
  }) : super();

  HomeState copyWith({
    List<Photo>? photos,
    String? showError,
  }) {
    return HomeState(
      photos: photos ?? this.photos,
    );
  }
}
