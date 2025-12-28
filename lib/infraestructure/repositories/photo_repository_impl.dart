import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/config/networking/error/http_error.dart'
    show HttpError;
import 'package:template/domain/data_sources/photo_data_source.dart';
import 'package:template/domain/entities/photo.dart';
import 'package:template/domain/repositories/photo_repository.dart';
import 'package:template/infraestructure/data_sources/service_photo_data_source_impl.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoDataSource photoDataSource;

  PhotoRepositoryImpl({required this.photoDataSource});

  @override
  Future<Either<HttpError, Photo>> getPhotoById({required int id}) async {
    try {
      final result = await photoDataSource.getPhotoById(id: id);
      return right(result);
    } on DioException catch (exception) {
      return left(HttpError.dioError(exception));
    } catch (exception) {
      return left(HttpError(code: "otro", message: "otro"));
    }
  }

  @override
  Future<Either<HttpError, List<Photo>>> getPhotos() async {
    try {
      final result = await photoDataSource.getPhotos();
      return right(result);
    } on DioException catch (exception) {
      return left(HttpError.dioError(exception));
    } catch (exception) {
      //TODO HANDLER ERROR
      return left(HttpError(code: "otro", message: "otro"));
    }
  }
}

final photoRepository = Provider<PhotoRepository>(
  (ref) => PhotoRepositoryImpl(photoDataSource: ref.watch(photoDataSource)),
);
