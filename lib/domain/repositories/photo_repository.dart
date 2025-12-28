import 'package:dartz/dartz.dart';
import 'package:template/config/networking/error/http_error.dart';
import 'package:template/domain/entities/photo.dart';

abstract class PhotoRepository {
  Future<Either<HttpError, Photo>> getPhotoById({required int id});

  Future<Either<HttpError, List<Photo>>> getPhotos();
}
