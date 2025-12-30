import 'package:flutter/material.dart';
import 'package:template/presentation/base/theme/app_dimens.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String businessName;
  final int waitingGroupsCount;
  final VoidCallback? onSettingsPressed;

  const HomeAppBar({
    super.key,
    required this.businessName,
    required this.waitingGroupsCount,
    this.onSettingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: const Color(0xFFF5F5F5),
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 80,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.mediumMargin),
        child: Row(
          children: [
            // Business icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFB3E5FC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.store,
                color: Color(0xFF0277BD),
                size: 28,
              ),
            ),
            const SizedBox(width: AppDimens.mediumMargin),
            // Business name and waiting count
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    businessName.isEmpty ? 'N/A' : businessName,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF333333),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$waitingGroupsCount grupos en espera',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),
            // Settings button
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Color(0xFF666666),
                size: 24,
              ),
              onPressed: onSettingsPressed,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
