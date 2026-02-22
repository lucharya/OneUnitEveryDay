import 'package:flutter/material.dart';

import '../../core/design/design.dart';

/// Large primary action button used throughout the app
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isCompleted;
  final bool isLoading;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isCompleted = false,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isCompleted ? AppColors.successLight : AppColors.primary,
            foregroundColor:
                isCompleted ? AppColors.success : Colors.white,
            disabledBackgroundColor:
                isCompleted ? AppColors.successLight : AppColors.surfaceVariant,
            disabledForegroundColor:
                isCompleted ? AppColors.success : AppColors.textTertiary,
            elevation: isCompleted ? 0 : 2,
            shadowColor: AppColors.shadow,
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.borderRadiusMd,
              side: isCompleted
                  ? const BorderSide(color: AppColors.success, width: 1.5)
                  : BorderSide.none,
            ),
            textStyle: AppTypography.titleLarge.copyWith(
              color: isCompleted ? AppColors.success : Colors.white,
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: 22),
                      const SizedBox(width: AppSpacing.sm),
                    ],
                    Text(label),
                  ],
                ),
        ),
      ),
    );
  }
}
