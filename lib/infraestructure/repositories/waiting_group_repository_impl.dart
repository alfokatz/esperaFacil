import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/config/networking/error/http_error.dart';
import 'package:template/config/networking/supabase_client_manager.dart';
import 'package:template/domain/entities/waiting_group.dart';
import 'package:template/domain/repositories/waiting_group_repository.dart';

class WaitingGroupRepositoryImpl implements WaitingGroupRepository {
  final SupabaseClient supabase;

  WaitingGroupRepositoryImpl({required this.supabase});

  @override
  Future<Either<HttpError, List<WaitingGroup>>> getWaitingGroups() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        return left(
          HttpError(code: 'no_user', message: 'No hay usuario autenticado'),
        );
      }

      final response = await supabase
          .from('waiting_groups')
          .select()
          .eq('business_id', user.id)
          .order('created_at', ascending: false);

      final waitingGroups =
          (response as List)
              .map(
                (item) => WaitingGroup(
                  id: item['id'] as String,
                  businessId: item['business_id'] as String,
                  name: item['name'] as String,
                  peopleCount: item['people_count'] as int,
                  status: item['status'] as String,
                  photoUrl: item['photo_url'] as String?,
                  createdAt: item['created_at'] as String?,
                  notifiedAt: item['notified_at'] as String?,
                  servedAt: item['served_at'] as String?,
                  cancelledAt: item['cancelled_at'] as String?,
                ),
              )
              .toList();

      return right(waitingGroups);
    } catch (e) {
      return left(
        HttpError(code: 'get_waiting_groups_error', message: e.toString()),
      );
    }
  }

  @override
  Future<Either<HttpError, void>> cancelWaitingGroup({
    required String id,
  }) async {
    try {
      await supabase
          .from('waiting_groups')
          .update({
            'status': 'cancelled',
            'cancelled_at': DateTime.now().toIso8601String(),
          })
          .eq('id', id);

      return right(null);
    } catch (e) {
      return left(
        HttpError(code: 'cancel_waiting_group_error', message: e.toString()),
      );
    }
  }

  @override
  Future<Either<HttpError, void>> notifyWaitingGroup({
    required String id,
  }) async {
    try {
      await supabase
          .from('waiting_groups')
          .update({
            'status': 'notified',
            'notified_at': DateTime.now().toIso8601String(),
          })
          .eq('id', id);

      return right(null);
    } catch (e) {
      return left(
        HttpError(code: 'notify_waiting_group_error', message: e.toString()),
      );
    }
  }

  @override
  Future<Either<HttpError, void>> serveWaitingGroup({
    required String id,
  }) async {
    try {
      await supabase
          .from('waiting_groups')
          .update({
            'status': 'served',
            'served_at': DateTime.now().toIso8601String(),
          })
          .eq('id', id);

      return right(null);
    } catch (e) {
      return left(
        HttpError(code: 'serve_waiting_group_error', message: e.toString()),
      );
    }
  }

  @override
  Future<Either<HttpError, WaitingGroup>> createWaitingGroup({
    required String name,
    required int peopleCount,
    String? photoUrl,
  }) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        return left(
          HttpError(code: 'no_user', message: 'No hay usuario autenticado'),
        );
      }

      final response =
          await supabase
              .from('waiting_groups')
              .insert({
                'business_id': user.id,
                'name': name,
                'people_count': peopleCount,
                'status': 'waiting',
                'photo_url': photoUrl,
              })
              .select()
              .single();

      final waitingGroup = WaitingGroup(
        id: response['id'] as String,
        businessId: response['business_id'] as String,
        name: response['name'] as String,
        peopleCount: response['people_count'] as int,
        status: response['status'] as String,
        photoUrl: response['photo_url'] as String?,
        createdAt: response['created_at'] as String?,
        notifiedAt: response['notified_at'] as String?,
        servedAt: response['served_at'] as String?,
        cancelledAt: response['cancelled_at'] as String?,
      );

      return right(waitingGroup);
    } catch (e) {
      return left(
        HttpError(code: 'create_waiting_group_error', message: e.toString()),
      );
    }
  }
}

final waitingGroupRepositoryProvider = Provider<WaitingGroupRepository>(
  (ref) =>
      WaitingGroupRepositoryImpl(supabase: ref.watch(supabaseClientProvider)),
);
