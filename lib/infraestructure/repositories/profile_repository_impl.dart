import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/config/networking/error/http_error.dart';
import 'package:template/config/networking/supabase_client_manager.dart';
import 'package:template/domain/entities/profile.dart';
import 'package:template/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final SupabaseClient supabase;

  ProfileRepositoryImpl({required this.supabase});

  @override
  Future<Either<HttpError, Profile>> getProfile() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        return left(
          HttpError(code: 'no_user', message: 'No hay usuario autenticado'),
        );
      }

      final response = await supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      final profile = Profile(
        id: response['id'] as String,
        email: response['email'] as String?,
        businessName: response['business_name'] as String,
        createdAt: response['created_at'] as String?,
        updatedAt: response['updated_at'] as String?,
      );

      return right(profile);
    } catch (e) {
      return left(
        HttpError(code: 'get_profile_error', message: e.toString()),
      );
    }
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepositoryImpl(supabase: ref.watch(supabaseClientProvider)),
);



