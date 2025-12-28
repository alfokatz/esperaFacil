import 'package:dartz/dartz.dart';
import 'package:template/config/networking/error/http_error.dart'
    show HttpError;
import 'package:template/shared/extensions/DynamicExtensions.dart';

abstract class BaseProvider {
  Future<void> callService<T>({
    required Future<Either<HttpError, T>> Function() service,
    required Function(T) onSuccess,
    Function? onCustomError,
  }) async {
    final result = await service.call();
    result.fold(
      (error) => {
        onCustomError.let(
          notNull: (value) {
            value.call();
          },
          isNull: () => {},
        ),
      },
      (successResponse) => {onSuccess.call(successResponse)},
    );
  }
}
