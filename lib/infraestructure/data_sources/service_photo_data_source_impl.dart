import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/domain/data_sources/photo_data_source.dart';
import 'package:template/domain/entities/photo.dart';
import 'package:template/infraestructure/services/photo_service.dart';

class PhotoDataSourceImpl implements PhotoDataSource {
  final PhotoService service;

  PhotoDataSourceImpl({required this.service});

  @override
  Future<Photo> getPhotoById({required int id}) async {
    final result = await service.getById(id);
    return result.toPhotoEntity();
  }

  @override
  Future<List<Photo>> getPhotos() async {
    final result = await service.getPhotos();
    return result.map((element) => element.toPhotoEntity()).toList();
  }
}

final photoDataSource = Provider<PhotoDataSource>(
  (ref) => PhotoDataSourceImpl(
    service: ref.watch(photoService),
  ),
);
