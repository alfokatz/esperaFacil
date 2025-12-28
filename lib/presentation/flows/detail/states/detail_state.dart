import 'package:template/domain/entities/photo.dart';

class DetailState {
  Photo? photo;
  int like = 0;
  int dislike = 0;

  DetailState({
    this.photo,
    this.like = 0,
    this.dislike = 0,
  });

  DetailState copyWith({
    int? like,
    int? dislike,
    Photo? photo,
  }) {
    return DetailState(
      photo: photo ?? this.photo,
      like: like ?? this.like,
      dislike: dislike ?? this.dislike,
    );
  }
}
