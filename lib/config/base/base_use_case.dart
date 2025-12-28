import 'package:dartz/dartz.dart';
import 'package:template/config/networking/error/http_error.dart'
    show HttpError;

abstract class BaseUseCase<Type, Params> {
  Future<Either<HttpError, Type>> call({required Params params});
}
