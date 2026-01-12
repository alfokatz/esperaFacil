import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../base/core/base_hook_widget.dart';
import '../../../../base/theme/app_dimens.dart';
import '../../providers/detail_provider.dart';

class ClientSummaryCard extends BaseHookWidget {
  ClientSummaryCard({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(detailProvider);
    final waitingGroup = detailState.waitingGroup;

    if (waitingGroup == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final statusText = ref
        .read(detailProvider.notifier)
        .getStatusText(waitingGroup.status);

    final statusColor = ref
        .read(detailProvider.notifier)
        .getStatusColor(waitingGroup.status);

    final shortId = ref
        .read(detailProvider.notifier)
        .getShortId(waitingGroup.id);

    return Padding(
      padding: const EdgeInsets.all(AppDimens.mediumMargin),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Badge de estado en la esquina superior derecha
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Avatar circular
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFB3E5FC), // Azul claro
                  shape: BoxShape.circle,
                ),
                child:
                    waitingGroup.photoUrl != null &&
                            waitingGroup.photoUrl!.isNotEmpty
                        ? ClipOval(
                          child: Image.network(
                            waitingGroup.photoUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.person,
                                size: 50,
                                color: const Color(0xFF0277BD), // Azul oscuro
                              );
                            },
                          ),
                        )
                        : Icon(
                          Icons.person,
                          size: 50,
                          color: const Color(0xFF0277BD), // Azul oscuro
                        ),
              ),
              const SizedBox(height: 20),
              // Nombre
              Text(
                waitingGroup.name,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              // ID
              Text(
                'ID #$shortId',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              // Paneles de información
              Row(
                children: [
                  // Panel de personas
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PERSONAS',
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.people,
                                size: 24,
                                color: const Color(0xFF2196F3),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${waitingGroup.peopleCount}',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Panel de tiempo
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TIEMPO',
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 24,
                                color: const Color(0xFFFFA726),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${waitingGroup.waitingMinutes}m',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
