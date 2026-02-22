import 'package:flutter/material.dart';

import '../../core/design/design.dart';

/// Custom calendar day widget.
/// Shows orange circles for completed days and horizontal bars
/// connecting consecutive completed days within the same week row.
class CalendarDay extends StatelessWidget {
  final String text;
  final bool isCompleted;
  final bool isToday;
  final bool isOutside;
  final bool connectLeft;
  final bool connectRight;

  const CalendarDay({
    super.key,
    required this.text,
    this.isCompleted = false,
    this.isToday = false,
    this.isOutside = false,
    this.connectLeft = false,
    this.connectRight = false,
  });

  static const _circleSize = 32.0;
  static const _barHeight = 28.0;

  @override
  Widget build(BuildContext context) {
    if (isOutside) return _buildOutside();
    if (isCompleted) return _buildCompleted();
    if (isToday) return _buildToday();
    return _buildDefault();
  }

  Widget _buildOutside() {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.textTertiary.withValues(alpha: 0.25),
        ),
      ),
    );
  }

  /// Completed day — translucent orange circle with optional connection bars
  Widget _buildCompleted() {
    final barColor = AppColors.streakActive.withValues(alpha: 0.15);
    final circleColor = isToday
        ? AppColors.streakActive.withValues(alpha: 0.85)
        : AppColors.streakActive.withValues(alpha: 0.7);

    return Stack(
      alignment: Alignment.center,
      children: [
        // Connection bar layer
        if (connectLeft || connectRight)
          Row(
            children: [
              Expanded(
                child: Container(
                  height: _barHeight,
                  color: connectLeft ? barColor : Colors.transparent,
                ),
              ),
              Expanded(
                child: Container(
                  height: _barHeight,
                  color: connectRight ? barColor : Colors.transparent,
                ),
              ),
            ],
          ),
        // Circle on top
        Container(
          width: _circleSize,
          height: _circleSize,
          decoration: BoxDecoration(
            color: circleColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToday() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: _circleSize,
          height: _circleSize,
          decoration: BoxDecoration(
            color: AppColors.calendarToday.withValues(alpha: 0.06),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.calendarToday, width: 2),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: AppColors.calendarToday,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDefault() {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.textTertiary,
          height: 1,
        ),
      ),
    );
  }
}
