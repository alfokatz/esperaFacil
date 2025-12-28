import 'package:flutter/material.dart';
import 'package:template/presentation/base/theme/app_dimens.dart';

enum WaitersFilterType { all, waiting, notified }

class WaitersFilter extends StatelessWidget {
  final WaitersFilterType selectedFilter;
  final Function(WaitersFilterType) onFilterChanged;

  const WaitersFilter({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.mediumMargin),
      child: Row(
        children: [
          // Todos button
          Expanded(
            child: _FilterButton(
              label: 'Todos',
              isSelected: selectedFilter == WaitersFilterType.all,
              onPressed: () => onFilterChanged(WaitersFilterType.all),
            ),
          ),
          const SizedBox(width: AppDimens.smallMargin),
          // Esperando button
          Expanded(
            child: _FilterButton(
              label: 'Esperando',
              isSelected: selectedFilter == WaitersFilterType.waiting,
              onPressed: () => onFilterChanged(WaitersFilterType.waiting),
              indicatorColor: const Color(0xFF2196F3),
            ),
          ),
          const SizedBox(width: AppDimens.smallMargin),
          // Avisados button
          Expanded(
            child: _FilterButton(
              label: 'Avisados',
              isSelected: selectedFilter == WaitersFilterType.notified,
              onPressed: () => onFilterChanged(WaitersFilterType.notified),
              indicatorColor: const Color(0xFFFFA726),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;
  final Color? indicatorColor;

  const _FilterButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
    this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.smallMargin,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF333333) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border:
              isSelected
                  ? null
                  : Border.all(color: const Color(0xFFE0E0E0), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (indicatorColor != null && !isSelected) ...[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: indicatorColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected ? Colors.white : const Color(0xFF333333),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
