import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/config/base/base_use_case.dart';
import 'package:template/config/networking/error/http_error.dart'
    show HttpError;
import 'package:template/domain/repositories/waiting_group_repository.dart';
import 'package:template/infraestructure/repositories/waiting_group_repository_impl.dart';

class NotifyClientUseCase extends BaseUseCase<void, String> {
  final WaitingGroupRepository waitingGroupRepository;

  NotifyClientUseCase({required this.waitingGroupRepository});

  @override
  Future<Either<HttpError, void>> call({required String params}) {
    return waitingGroupRepository.notifyWaitingGroup(id: params);
  }
}

final notifyClientUseCase = Provider(
  (ref) => NotifyClientUseCase(
    waitingGroupRepository: ref.watch(waitingGroupRepositoryProvider),
  ),
);
