import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/presentation/base/providers/base_state_notifier.dart';
import 'package:template/presentation/flows/detail/states/detail_action.dart';
import 'package:template/presentation/flows/detail/states/detail_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../domain/entities/waiting_group.dart';
import '../../../../domain/use_cases/get_client_by_id_use_case.dart';

class DetailProvider extends BaseStateNotifier<DetailState, DetailAction> {
  final GetWaitingGroupByIdUseCase getWaitingGroupByIdUseCase;

  DetailProvider({required super.ref, required this.getWaitingGroupByIdUseCase})
    : super(state: DetailState());

  void init({required String id}) async {
    _callGetWaitingGroupByIdUseCase(id: id);
  }

  void _callGetWaitingGroupByIdUseCase({required String id}) {
    showLoading();
    super.callService<WaitingGroup>(
      service: () => getWaitingGroupByIdUseCase(params: id),
      onSuccess: (waitingGroup) {
        try {
          reducer(action: Load(waitingGroup: waitingGroup));
        } catch (e) {
          // El provider fue desechado, ignorar el error
          return;
        }
        try {
          showContent();
        } catch (e) {
          // El provider fue desechado, ignorar el error
        }
      },
      onCustomError: (error) {
        try {
          showContent();
          showErrorAlert(title: 'Error', message: error.message);
        } catch (e) {
          // El provider fue desechado, ignorar el error
        }
      },
    );
  }

  String getStatusText(String status) {
    switch (status) {
      case 'waiting':
        return 'Esperando';
      case 'notified':
        return 'Avisado';
      case 'served':
        return 'Atendido';
      case 'cancelled':
        return 'Cancelado';
      default:
        return 'Esperando';
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'waiting':
        return const Color(0xFFFFF9C4); // Amarillo claro
      case 'notified':
        return const Color(0xFFFFE0B2); // Naranja claro
      default:
        return const Color(0xFFFFF9C4);
    }
  }

  String getShortId(String id) {
    if (id.length <= 3) return id;
    return id.substring(id.length - 3);
  }

  Future<void> makePhoneCall({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No se puede realizar la llamada a $phoneNumber'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void reducer({required DetailAction action}) {
    switch (action) {
      case Load():
        state = state.copyWith(waitingGroup: action.waitingGroup);
    }
  }
}

final detailProvider =
    StateNotifierProvider.autoDispose<DetailProvider, DetailState>((ref) {
      final notifier = DetailProvider(
        getWaitingGroupByIdUseCase: ref.watch(getWaitingGroupByIdUseCase),
        ref: ref,
      );
      return notifier;
    });
