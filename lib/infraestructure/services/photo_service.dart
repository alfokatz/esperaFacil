import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:template/config/networking/http_client.dart';
import 'package:template/infraestructure/models/photo_model.dart';


part 'photo_service.g.dart';

@RestApi()
abstract class PhotoService {
  factory PhotoService(Dio dio, {String baseUrl}) = _PhotoService;

  @GET('/photos')
  Future<List<PhotoModel>> getPhotos();

  @GET('/photos/{id}')
  Future<PhotoModel> getById(@Path('id') int id);
}

final photoService = Provider<PhotoService>(
      (ref) => PhotoService(
    ref.watch(httpClientProvider).dio,
  ),
);