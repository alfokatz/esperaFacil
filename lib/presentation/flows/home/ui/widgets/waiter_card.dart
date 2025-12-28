import 'package:flutter/material.dart';
import 'package:template/presentation/base/theme/app_dimens.dart';

enum WaiterStatus { waiting, notified }

class WaiterCard extends StatelessWidget {
  final String name;
  final String? photoUrl;
  final int peopleCount;
  final int waitingMinutes;
  final WaiterStatus status;
  final VoidCallback? onCancel;
  final VoidCallback? onNotify;
  final VoidCallback? onServe;

  const WaiterCard({
    super.key,
    required this.name,
    this.photoUrl,
    required this.peopleCount,
    required this.waitingMinutes,
    required this.status,
    this.onCancel,
    this.onNotify,
    this.onServe,
  });

  String _getInitials(String name) {
    final parts = name.split(' ');
    if (parts.isEmpty) return '';
    if (parts.length == 1) {
      return parts[0].substring(0, 1).toUpperCase();
    }
    return '${parts[0].substring(0, 1)}${parts[1].substring(0, 1)}'
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final initials = _getInitials(name);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimens.mediumMargin,
        vertical: AppDimens.smallMargin,
      ),
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
        padding: const EdgeInsets.all(AppDimens.mediumMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Avatar, name, time and status
            Row(
              children: [
                // Avatar
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child:
                      photoUrl != null && photoUrl!.isNotEmpty
                          ? ClipOval(
                            child: Image.network(
                              photoUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text(
                                    initials,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                          : Center(
                            child: Text(
                              initials,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                ),
                const SizedBox(width: AppDimens.mediumMargin),
                // Name and details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.people_outline,
                            size: 16,
                            color: const Color(0xFF666666),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$peopleCount pers',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF666666),
                            ),
                          ),
                          const SizedBox(width: AppDimens.smallMargin),
                          Icon(
                            Icons.hourglass_empty,
                            size: 16,
                            color:
                                status == WaiterStatus.waiting
                                    ? const Color(0xFF2196F3)
                                    : const Color(0xFFFFA726),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            status == WaiterStatus.waiting
                                ? 'Esperando'
                                : 'Avisado',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color:
                                  status == WaiterStatus.waiting
                                      ? const Color(0xFF2196F3)
                                      : const Color(0xFFFFA726),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Waiting time
                Text(
                  '$waitingMinutes min',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF666666),
                  ),
                ),
              ],
            ),
            // Action buttons
            const SizedBox(height: AppDimens.mediumMargin),
            Row(
              children: [
                // Cancel button
                Expanded(
                  child: _ActionButton(
                    icon: Icons.close,
                    label: 'Cancelar',
                    backgroundColor: const Color(0xFFE0E0E0),
                    textColor: const Color(0xFF666666),
                    onPressed: onCancel,
                  ),
                ),
                const SizedBox(width: AppDimens.smallMargin),
                // Notify button
                Expanded(
                  child: _ActionButton(
                    icon: Icons.notifications_outlined,
                    label: 'Avisar',
                    backgroundColor: const Color(0xFFFFF9C4),
                    textColor: const Color(0xFF666666),
                    onPressed: onNotify,
                  ),
                ),
                const SizedBox(width: AppDimens.smallMargin),
                // Serve button
                Expanded(
                  flex: 2,
                  child: _ActionButton(
                    icon: null,
                    label: 'Atender',
                    backgroundColor: const Color(0xFF2196F3),
                    textColor: Colors.white,
                    onPressed: onServe,
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

class _ActionButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.smallMargin,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        minimumSize: const Size(0, 44),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: 6)],
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
