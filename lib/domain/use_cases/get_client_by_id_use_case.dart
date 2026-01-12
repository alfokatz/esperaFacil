import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/base/base_use_case.dart';
import '../../config/networking/error/http_error.dart';
import '../../infraestructure/repositories/waiting_group_repository_impl.dart';
import '../entities/waiting_group.dart';
import '../repositories/waiting_group_repository.dart';

class GetWaitingGroupByIdUseCase extends BaseUseCase<WaitingGroup, String> {
  final WaitingGroupRepository waitingGroupRepository;

  GetWaitingGroupByIdUseCase({required this.waitingGroupRepository});

  @override
  Future<Either<HttpError, WaitingGroup>> call({required String params}) {
    return waitingGroupRepository.getWaitingGroupById(waitingGroupId: params);
  }
}

final getWaitingGroupByIdUseCase = Provider(
  (ref) => GetWaitingGroupByIdUseCase(
    waitingGroupRepository: ref.watch(waitingGroupRepositoryProvider),
  ),
);
