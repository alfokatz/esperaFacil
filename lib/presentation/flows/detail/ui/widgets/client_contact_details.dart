import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../base/core/base_hook_widget.dart';
import '../../../../base/theme/app_dimens.dart';
import '../../providers/detail_provider.dart';

class ClientContactDetails extends BaseHookWidget {
  ClientContactDetails({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(detailProvider);
    final waitingGroup = detailState.waitingGroup;

    if (waitingGroup == null) {
      return const SizedBox.shrink();
    }

    final phoneNumber = waitingGroup.phoneNumber;
    final notes = waitingGroup.notes;
    final hasPhone = phoneNumber != null && phoneNumber.isNotEmpty;
    final hasNotes = notes != null && notes.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.mediumMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.only(bottom: AppDimens.mediumMargin),
            child: Text(
              'INFORMACIÓN DE CONTACTO',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
          ),
          // Tarjeta de teléfono
          Container(
            margin: const EdgeInsets.only(bottom: AppDimens.smallMargin),
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
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icono circular verde
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9), // Verde muy claro
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.phone,
                    color: const Color(0xFF4CAF50), // Verde oscuro
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                // Texto del teléfono
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Teléfono móvil',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        hasPhone ? phoneNumber : '-',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                // Botón de llamar
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5), // Gris muy claro
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap:
                          hasPhone
                              ? () => ref
                                  .read(detailProvider.notifier)
                                  .makePhoneCall(
                                    phoneNumber: phoneNumber,
                                    context: context,
                                  )
                              : null,
                      child: Icon(
                        Icons.phone,
                        color:
                            hasPhone
                                ? const Color(0xFF2196F3) // Azul
                                : Colors.grey[400], // Gris deshabilitado
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Tarjeta de notas
          Container(
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
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icono circular naranja
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0), // Naranja muy claro
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.note,
                    color: const Color(0xFFFB8C00), // Naranja oscuro
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                // Texto de las notas
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nota del cliente',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        hasNotes ? notes : '-',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                        maxLines: null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
