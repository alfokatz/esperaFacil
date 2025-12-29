// lib/domain/repositories/auth_repository.dart
import 'package:dartz/dartz.dart';
import 'package:template/config/networking/error/http_error.dart';
import 'package:template/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<HttpError, void>> signUp({
    required String email,
    required String password,
  });

  Future<Either<HttpError, String>> signIn({
    required String email,
    required String password,
  });

  Future<Either<HttpError, void>> signOut();

  Future<Either<HttpError, void>> resetPassword({required String email});

  Future<Either<HttpError, void>> createProfile({required String businessName});

  User? getCurrentUser();
}
