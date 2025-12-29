// lib/infraestructure/repositories/auth_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/config/networking/error/http_error.dart';
import 'package:template/domain/entities/user.dart' as domain;
import 'package:template/domain/repositories/auth_repository.dart';

import '../../config/networking/supabase_client_manager.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient supabase;

  AuthRepositoryImpl({required this.supabase});

  @override
  Future<Either<HttpError, void>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await supabase.auth.signUp(email: email, password: password);
      return right(null);
    } catch (e) {
      return left(HttpError(code: 'signup_error', message: e.toString()));
    }
  }

  @override
  Future<Either<HttpError, String>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session?.accessToken != null) {
        return right(response.session!.accessToken);
      }

      return left(
        HttpError(code: 'signin_error', message: 'No se pudo obtener el token'),
      );
    } catch (e) {
      return left(HttpError(code: 'signin_error', message: e.toString()));
    }
  }

  @override
  Future<Either<HttpError, void>> signOut() async {
    try {
      await supabase.auth.signOut();
      return right(null);
    } catch (e) {
      return left(HttpError(code: 'signout_error', message: e.toString()));
    }
  }

  @override
  Future<Either<HttpError, void>> resetPassword({required String email}) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
      return right(null);
    } catch (e) {
      return left(
        HttpError(code: 'reset_password_error', message: e.toString()),
      );
    }
  }

  @override
  Future<Either<HttpError, void>> createProfile({
    required String businessName,
  }) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        return left(
          HttpError(code: 'no_user', message: 'No hay usuario autenticado'),
        );
      }

      // Usar UPSERT para crear o actualizar el perfil
      await supabase.from('profiles').upsert({
        'id': user.id,
        'email': user.email,
        'business_name': businessName,
      });

      return right(null);
    } catch (e) {
      return left(
        HttpError(code: 'create_profile_error', message: e.toString()),
      );
    }
  }

  @override
  domain.User? getCurrentUser() {
    final supabaseUser = supabase.auth.currentUser;
    if (supabaseUser == null) return null;

    return domain.User(
      id: supabaseUser.id,
      email: supabaseUser.email,
      createdAt: supabaseUser.createdAt,
      updatedAt: supabaseUser.updatedAt,
    );
  }
}

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(supabase: ref.watch(supabaseClientProvider)),
);
