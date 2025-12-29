import 'package:dartz/dartz.dart';
import 'package:template/config/networking/error/http_error.dart';
import 'package:template/domain/entities/waiting_group.dart';

abstract class WaitingGroupRepository {
  Future<Either<HttpError, List<WaitingGroup>>> getWaitingGroups();
  
  Future<Either<HttpError, void>> cancelWaitingGroup({required String id});
  
  Future<Either<HttpError, void>> notifyWaitingGroup({required String id});
  
  Future<Either<HttpError, void>> serveWaitingGroup({required String id});
  
  Future<Either<HttpError, WaitingGroup>> createWaitingGroup({
    required String name,
    required int peopleCount,
    String? photoUrl,
  });
}

