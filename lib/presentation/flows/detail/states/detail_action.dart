import 'package:template/domain/entities/waiting_group.dart';

sealed class DetailAction {}

class Load extends DetailAction {
  final WaitingGroup waitingGroup;

  Load({required this.waitingGroup});
}
