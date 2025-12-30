import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/config/base/base_use_case.dart';
import 'package:template/config/networking/error/http_error.dart'
    show HttpError;
import 'package:template/domain/entities/waiting_group.dart';
import 'package:template/domain/repositories/waiting_group_repository.dart';
import 'package:template/infraestructure/repositories/waiting_group_repository_impl.dart';

class GetAllClientsUseCase extends BaseUseCase<List<WaitingGroup>, void> {
  final WaitingGroupRepository waitingGroupRepository;

  GetAllClientsUseCase({required this.waitingGroupRepository});

  @override
  Future<Either<HttpError, List<WaitingGroup>>> call({required void params}) {
    return waitingGroupRepository.getWaitingGroups();
  }
}

final getAllClientsUseCase = Provider(
  (ref) => GetAllClientsUseCase(
    waitingGroupRepository: ref.watch(waitingGroupRepositoryProvider),
  ),
);
