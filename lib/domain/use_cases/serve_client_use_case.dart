import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/config/base/base_use_case.dart';
import 'package:template/config/networking/error/http_error.dart'
    show HttpError;
import 'package:template/domain/repositories/waiting_group_repository.dart';
import 'package:template/infraestructure/repositories/waiting_group_repository_impl.dart';

class ServeClientUseCase extends BaseUseCase<void, String> {
  final WaitingGroupRepository waitingGroupRepository;

  ServeClientUseCase({required this.waitingGroupRepository});

  @override
  Future<Either<HttpError, void>> call({required String params}) {
    return waitingGroupRepository.serveWaitingGroup(id: params);
  }
}

final serveClientUseCase = Provider(
  (ref) => ServeClientUseCase(
    waitingGroupRepository: ref.watch(waitingGroupRepositoryProvider),
  ),
);

