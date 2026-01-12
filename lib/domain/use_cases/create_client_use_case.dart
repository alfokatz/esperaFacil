import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/config/base/base_use_case.dart';
import 'package:template/config/networking/error/http_error.dart'
    show HttpError;
import 'package:template/domain/entities/waiting_group.dart';
import 'package:template/domain/repositories/waiting_group_repository.dart';
import 'package:template/infraestructure/repositories/waiting_group_repository_impl.dart';

class CreateClientParams {
  final String name;
  final int peopleCount;
  final String? photoUrl;
  final int? estimatedWaitMinutes;
  final String? notes;
  final String? phoneNumber;
  CreateClientParams({
    required this.name,
    required this.peopleCount,
    this.photoUrl,
    this.estimatedWaitMinutes,
    this.notes,
    this.phoneNumber,
  });
}

class CreateClientUseCase
    extends BaseUseCase<WaitingGroup, CreateClientParams> {
  final WaitingGroupRepository waitingGroupRepository;

  CreateClientUseCase({required this.waitingGroupRepository});

  @override
  Future<Either<HttpError, WaitingGroup>> call({
    required CreateClientParams params,
  }) {
    return waitingGroupRepository.createWaitingGroup(
      name: params.name,
      peopleCount: params.peopleCount,
      photoUrl: params.photoUrl,
      estimatedWaitMinutes: params.estimatedWaitMinutes,
      notes: params.notes,
      phoneNumber: params.phoneNumber,
    );
  }
}

final createClientUseCase = Provider(
  (ref) => CreateClientUseCase(
    waitingGroupRepository: ref.watch(waitingGroupRepositoryProvider),
  ),
);
