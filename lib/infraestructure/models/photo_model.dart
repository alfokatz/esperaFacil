import 'package:json_annotation/json_annotation.dart';
import 'package:template/domain/entities/photo.dart';

part 'photo_model.g.dart';

@JsonSerializable()
class PhotoModel {
  @JsonKey(name: 'albumId')
  late int albumId;
  @JsonKey(name: 'id')
  late int id;
  @JsonKey(name: 'title')
  late String title;
  @JsonKey(name: 'url')
  late String url;
  @JsonKey(name: 'thumbnailUrl')
  late String thumbnailUrl;

  PhotoModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoModelToJson(this);

  Photo toPhotoEntity() => Photo(
        albumId: albumId,
        id: id,
        title: title,
        url:
            "https://beecrowd.com/wp-content/uploads/2024/04/2022-06-23-Flutter.jpg",
        thumbnailUrl: thumbnailUrl,
      );
}
