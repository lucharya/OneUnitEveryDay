import '../entities/activity_log.dart';

/// Interface for activity log data access
abstract class IActivityLogRepository {
  /// Get all logs for a given activity, ordered by date descending
  Future<List<ActivityLog>> getByActivityId(int activityId);

  /// Get a log for a specific activity and date
  Future<ActivityLog?> getByActivityAndDate(int activityId, String date);

  /// Get logs for a specific activity within a date range
  Future<List<ActivityLog>> getByActivityAndDateRange(
    int activityId,
    String startDate,
    String endDate,
  );

  /// Create a new log entry. Throws if duplicate (activityId, date) exists.
  Future<ActivityLog> create(ActivityLog log);

  /// Check if a log exists for the given activity and date
  Future<bool> existsForDate(int activityId, String date);

  /// Delete a log for a specific activity and date. Returns true if deleted.
  Future<bool> deleteByActivityAndDate(int activityId, String date);

  /// Delete all logs for a given activity
  Future<void> deleteByActivityId(int activityId);
}
