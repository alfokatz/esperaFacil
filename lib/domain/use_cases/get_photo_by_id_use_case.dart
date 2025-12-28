import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/config/base/base_use_case.dart';
import 'package:template/config/networking/error/http_error.dart'
    show HttpError;
import 'package:template/domain/entities/photo.dart';
import 'package:template/domain/repositories/photo_repository.dart';
import 'package:template/infraestructure/repositories/photo_repository_impl.dart';

class GetPhotoByIdUseCase extends BaseUseCase<Photo, int> {
  final PhotoRepository photoRepository;

  GetPhotoByIdUseCase({required this.photoRepository});

  @override
  Future<Either<HttpError, Photo>> call({required int params}) {
    return photoRepository.getPhotoById(id: params);
  }
}

final getPhotoByIdUseCase = Provider(
  (ref) => GetPhotoByIdUseCase(photoRepository: ref.watch(photoRepository)),
);
