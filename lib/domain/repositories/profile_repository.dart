import 'package:dartz/dartz.dart';
import 'package:template/config/networking/error/http_error.dart';
import 'package:template/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Either<HttpError, Profile>> getProfile();
}



