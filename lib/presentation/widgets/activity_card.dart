import 'package:flutter/material.dart';

import '../../core/design/design.dart';
import 'streak_badge.dart';

/// Card component for displaying an activity in the list with subtle tap animation
class ActivityCard extends StatefulWidget {
  final String name;
  final String? description;
  final int streak;
  final bool completedToday;
  final VoidCallback? onTap;

  const ActivityCard({
    super.key,
    required this.name,
    this.description,
    required this.streak,
    required this.completedToday,
    this.onTap,
  });

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: widget.completedToday
                ? AppColors.successLight
                : AppColors.surface,
            borderRadius: AppRadius.borderRadiusMd,
            border: Border.all(
              color: widget.completedToday
                  ? AppColors.success.withValues(alpha: 0.3)
                  : AppColors.border,
            ),
            boxShadow: AppElevation.sm,
          ),
          child: Row(
            children: [
              // Status indicator
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: widget.completedToday
                      ? AppColors.success
                      : AppColors.surfaceVariant,
                  shape: BoxShape.circle,
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    widget.completedToday
                        ? Icons.check
                        : Icons.circle_outlined,
                    key: ValueKey(widget.completedToday),
                    color: widget.completedToday
                        ? Colors.white
                        : AppColors.textTertiary,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: AppTypography.titleLarge.copyWith(
                        color: widget.completedToday
                            ? AppColors.success
                            : AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (widget.description != null &&
                        widget.description!.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        widget.description!,
                        style: AppTypography.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              // Streak badge
              StreakBadge(streak: widget.streak, compact: true),
              const SizedBox(width: AppSpacing.xs),
              const Icon(
                Icons.chevron_right,
                color: AppColors.textTertiary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
