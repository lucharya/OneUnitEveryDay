import 'package:flutter/material.dart';

import '../../core/design/design.dart';
import '../../core/utils/date_utils.dart';

/// Single item in the timeline view — orange theme with fire icon.
class TimelineItem extends StatelessWidget {
  final String date;
  final bool isCompleted;
  final bool isFirst;
  final bool isLast;

  const TimelineItem({
    super.key,
    required this.date,
    required this.isCompleted,
    this.isFirst = false,
    this.isLast = false,
  });

  String _formatDate(String dateStr) {
    if (AppDateUtils.isToday(dateStr)) return 'Hoje';
    if (AppDateUtils.isYesterday(dateStr)) return 'Ontem';

    final dt = AppDateUtils.parseDate(dateStr);
    final day = dt.day.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final year = dt.year;
    return '$day/$month/$year';
  }

  String _weekday(String dateStr) {
    if (AppDateUtils.isToday(dateStr)) return '';
    if (AppDateUtils.isYesterday(dateStr)) return '';

    final dt = AppDateUtils.parseDate(dateStr);
    const days = [
      'Segunda',
      'Terça',
      'Quarta',
      'Quinta',
      'Sexta',
      'Sábado',
      'Domingo',
    ];
    return days[dt.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    final lineColor = AppColors.border;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline line and dot
          SizedBox(
            width: 40,
            child: Column(
              children: [
                // Top line
                if (!isFirst)
                  Expanded(
                    child: Container(width: 2, color: lineColor),
                  )
                else
                  const Expanded(child: SizedBox()),
                // Dot
                if (isCompleted)
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppColors.streakActive,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 11,
                      color: Colors.white,
                    ),
                  )
                else
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border, width: 2),
                    ),
                  ),
                // Bottom line
                if (!isLast)
                  Expanded(
                    child: Container(width: 2, color: lineColor),
                  )
                else
                  const Expanded(child: SizedBox()),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          // Content card
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.md,
                horizontal: AppSpacing.lg,
              ),
              margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              decoration: BoxDecoration(
                color: isCompleted
                    ? AppColors.streakActiveLight
                    : AppColors.surface,
                borderRadius: AppRadius.borderRadiusSm,
                border: Border.all(
                  color: isCompleted
                      ? AppColors.streakActive.withValues(alpha: 0.2)
                      : AppColors.border,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _formatDate(date),
                          style: AppTypography.titleMedium.copyWith(
                            color: isCompleted
                                ? AppColors.streakActive
                                : AppColors.textPrimary,
                          ),
                        ),
                        if (_weekday(date).isNotEmpty) ...[
                          const SizedBox(height: AppSpacing.xxs),
                          Text(
                            _weekday(date),
                            style: AppTypography.bodySmall.copyWith(
                              color: isCompleted
                                  ? AppColors.streakActive
                                      .withValues(alpha: 0.6)
                                  : AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Right icon
                  if (isCompleted)
                    Icon(
                      Icons.local_fire_department,
                      color: AppColors.streakActive.withValues(alpha: 0.7),
                      size: 22,
                    )
                  else
                    Icon(
                      Icons.remove_circle_outline,
                      color: AppColors.textTertiary.withValues(alpha: 0.4),
                      size: 20,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
