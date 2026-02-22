import 'package:intl/intl.dart';

/// Utility functions for date handling
abstract final class AppDateUtils {
  static final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  /// Format a DateTime to YYYY-MM-DD string
  static String formatDate(DateTime date) {
    return _dateFormat.format(date);
  }

  /// Parse a YYYY-MM-DD string to DateTime
  static DateTime parseDate(String dateStr) {
    return _dateFormat.parse(dateStr);
  }

  /// Get today's date as YYYY-MM-DD string
  static String get todayString => formatDate(DateTime.now());

  /// Get today's date with time stripped
  static DateTime get today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Check if a date string represents today
  static bool isToday(String dateStr) {
    return dateStr == todayString;
  }

  /// Check if a date string represents yesterday
  static bool isYesterday(String dateStr) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return dateStr == formatDate(yesterday);
  }

  /// Calculate streak from a sorted list of date strings (most recent first).
  ///
  /// Rules:
  /// - If today has a log → count from today backwards
  /// - If today has NO log but yesterday does → count from yesterday backwards
  /// - If neither today nor yesterday → streak = 0
  static int calculateStreak(List<String> sortedDates) {
    if (sortedDates.isEmpty) return 0;

    final today = AppDateUtils.today;
    final todayStr = formatDate(today);
    final yesterdayStr = formatDate(today.subtract(const Duration(days: 1)));

    final dateSet = sortedDates.toSet();

    // Determine the starting point
    DateTime startDate;
    if (dateSet.contains(todayStr)) {
      startDate = today;
    } else if (dateSet.contains(yesterdayStr)) {
      startDate = today.subtract(const Duration(days: 1));
    } else {
      return 0;
    }

    // Count consecutive days backwards from startDate
    int streak = 0;
    DateTime checkDate = startDate;

    while (dateSet.contains(formatDate(checkDate))) {
      streak++;
      checkDate = checkDate.subtract(const Duration(days: 1));
    }

    return streak;
  }
}
