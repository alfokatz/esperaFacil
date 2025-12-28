import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/config/base/base_use_case.dart';
import 'package:template/config/networking/error/http_error.dart'
    show HttpError;
import 'package:template/domain/entities/photo.dart';
import 'package:template/domain/repositories/photo_repository.dart';
import 'package:template/infraestructure/repositories/photo_repository_impl.dart';

class GetPhotosUseCase extends BaseUseCase<List<Photo>, void> {
  final PhotoRepository photoRepository;

  GetPhotosUseCase({required this.photoRepository});

  @override
  Future<Either<HttpError, List<Photo>>> call({void params}) {
    return photoRepository.getPhotos();
  }
}

final getPhotosUseCase = Provider(
  (ref) => GetPhotosUseCase(photoRepository: ref.watch(photoRepository)),
);
