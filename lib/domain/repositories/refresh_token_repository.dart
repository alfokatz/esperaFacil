import 'package:dartz/dartz.dart';
import 'package:template/config/networking/error/http_error.dart';

abstract class RefreshTokenRepository {
  Future<Either<HttpError, String>> refreshToken();
}
