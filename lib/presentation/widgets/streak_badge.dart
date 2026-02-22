import 'package:flutter/material.dart';

import '../../core/design/design.dart';

/// Badge that displays the current streak count with a fire icon
class StreakBadge extends StatelessWidget {
  final int streak;
  final bool compact;

  const StreakBadge({
    super.key,
    required this.streak,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return _buildCompact();
    }
    return _buildFull();
  }

  Widget _buildCompact() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: streak > 0 ? AppColors.streakActiveLight : AppColors.surfaceVariant,
        borderRadius: AppRadius.borderRadiusFull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            streak > 0 ? Icons.local_fire_department : Icons.local_fire_department_outlined,
            size: 16,
            color: streak > 0 ? AppColors.streakActive : AppColors.textTertiary,
          ),
          const SizedBox(width: AppSpacing.xxs),
          Text(
            '$streak',
            style: AppTypography.labelMedium.copyWith(
              color: streak > 0 ? AppColors.streakActive : AppColors.textTertiary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFull() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: streak > 0 ? AppColors.streakActiveLight : AppColors.surfaceVariant,
        borderRadius: AppRadius.borderRadiusMd,
        border: Border.all(
          color: streak > 0
              ? AppColors.streakActive.withValues(alpha: 0.3)
              : AppColors.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            streak > 0 ? Icons.local_fire_department : Icons.local_fire_department_outlined,
            size: 28,
            color: streak > 0 ? AppColors.streakActive : AppColors.textTertiary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$streak',
                style: AppTypography.headlineLarge.copyWith(
                  color: streak > 0 ? AppColors.streakActive : AppColors.textTertiary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                streak == 1 ? 'dia' : 'dias',
                style: AppTypography.bodySmall.copyWith(
                  color: streak > 0 ? AppColors.streakActive : AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
