import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../base/core/base_hook_widget.dart';
import '../../../../base/theme/app_dimens.dart';
import '../../../home/providers/home_provider.dart';
import '../../providers/detail_provider.dart';

class DetailBottomBar extends BaseHookWidget {
  DetailBottomBar({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(detailProvider);
    final waitingGroup = detailState.waitingGroup;
    final homeNotifier = ref.read(homeProvider.notifier);

    if (waitingGroup == null) {
      return const SizedBox.shrink();
    }

    final isServed = waitingGroup.status == 'served';
    final isNotified = waitingGroup.status == 'notified';
    final isCancelled = waitingGroup.status == 'cancelled';

    return Container(
      padding: const EdgeInsets.all(AppDimens.mediumMargin),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Botón "Marcar como atendido" / "Atendido" - Azul o Verde
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed:
                    (isServed || isCancelled)
                        ? null
                        : () {
                          homeNotifier.serveWaiter(waitingGroup.id);
                        },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isServed
                          ? const Color(
                            0xFF4CAF50,
                          ) // Verde cuando está atendido
                          : const Color(
                            0xFF2196F3,
                          ), // Azul cuando no está atendido
                  foregroundColor: Colors.white,
                  elevation: 0,
                  disabledBackgroundColor: const Color(0xFF4CAF50),
                  disabledForegroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      isServed ? 'Atendido' : 'Marcar como atendido',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimens.smallMargin),
            // Fila de botones "Avisar" y "Cancelar"
            Row(
              children: [
                // Botón "Avisar" / "Notificado" - Azul claro o Amarillo claro
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed:
                          (isServed || isNotified || isCancelled)
                              ? null
                              : () {
                                homeNotifier.notifyWaiter(waitingGroup.id);
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isNotified
                                ? const Color(
                                  0xFFFFF9C4,
                                ) // Amarillo muy claro cuando está notificado
                                : const Color(
                                  0xFFE3F2FD,
                                ), // Azul muy claro cuando no está notificado
                        foregroundColor:
                            isNotified
                                ? const Color(
                                  0xFFFFA726,
                                ) // Naranja/amarillo oscuro
                                : const Color(0xFF2196F3), // Azul
                        elevation: 0,
                        disabledBackgroundColor: const Color(0xFFFFF9C4),
                        disabledForegroundColor: const Color(0xFFFFA726),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.notifications, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            isNotified ? 'Notificado' : 'Notificar',
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color:
                                  isNotified
                                      ? const Color(0xFFFFA726)
                                      : const Color(0xFF2196F3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimens.smallMargin),
                // Botón "Cancelar" / "Cancelado" - Rojo claro
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed:
                          (isServed || isCancelled)
                              ? null
                              : () {
                                homeNotifier.cancelWaiter(waitingGroup.id);
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isCancelled
                                ? const Color(
                                  0xFFFFCDD2,
                                ) // Rojo más claro cuando está cancelado
                                : const Color(
                                  0xFFFFEBEE,
                                ), // Rojo muy claro cuando no está cancelado
                        foregroundColor:
                            isCancelled
                                ? const Color(0xFFE53935) // Rojo
                                : const Color(0xFFE53935), // Rojo
                        elevation: 0,
                        disabledBackgroundColor: const Color(0xFFFFCDD2),
                        disabledForegroundColor: const Color(0xFFE53935),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.close, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            isCancelled ? 'Cancelado' : 'Cancelar',
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFE53935),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
