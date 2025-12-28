import 'package:template/domain/entities/photo.dart';

abstract class PhotoDataSource {
  Future<Photo> getPhotoById({required int id});

  Future<List<Photo>> getPhotos();
}
