import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/presentation/base/alert/alert_provider.dart';
import 'package:template/presentation/base/content_state/content_state_provider.dart';
import 'package:template/shared/extensions/DynamicExtensions.dart';
import 'package:template/config/networking/error/http_error.dart'
    show HttpError;

abstract class BaseStateNotifier<S, A> extends StateNotifier<S> {
  late Ref ref;

  BaseStateNotifier({required S state, required this.ref}) : super(state);

  Future<void> callService<T>({
    required Future<Either<HttpError, T>> Function() service,
    required Function(T) onSuccess,
    Function(HttpError)? onCustomError,
  }) async {
    final result = await service.call();
    result.fold(
      (error) => {
        onCustomError.let(
          notNull: (value) {
            value.call(error);
          },
          isNull: () => {},
        ),
      },
      (successResponse) => {onSuccess.call(successResponse)},
    );
  }

  void showLoading() {
    print('📊 [BaseStateNotifier] showLoading() llamado');
    ref.read(contentStateNotifierProvider.notifier).setLoading();
    print('📊 [BaseStateNotifier] setLoading() ejecutado');
  }

  void showContent() {
    print('📊 [BaseStateNotifier] showContent() llamado');
    ref.read(contentStateNotifierProvider.notifier).setShowContent();
    print('📊 [BaseStateNotifier] setShowContent() ejecutado');
  }

  void showErrorAlert({String? title, String? message}) {
    ref.read(alertProvider.notifier).showError(title: title, message: message);
  }

  void showSuccessAlert({String? title, String? message}) {
    ref
        .read(alertProvider.notifier)
        .showSuccess(title: title, message: message);
  }

  void showWarningAlert({String? title, String? message}) {
    ref
        .read(alertProvider.notifier)
        .showWarning(title: title, message: message);
  }

  void reducer({required A action});
}
