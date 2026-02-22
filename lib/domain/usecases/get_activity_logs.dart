import '../entities/activity_log.dart';
import '../repositories/activity_log_repository.dart';

/// Use case: Get all logs for an activity
class GetActivityLogs {
  final IActivityLogRepository _repository;

  GetActivityLogs(this._repository);

  /// Get all logs ordered by date descending
  Future<List<ActivityLog>> call(int activityId) async {
    return await _repository.getByActivityId(activityId);
  }

  /// Get logs within a date range
  Future<List<ActivityLog>> forDateRange(
    int activityId,
    String startDate,
    String endDate,
  ) async {
    return await _repository.getByActivityAndDateRange(
      activityId,
      startDate,
      endDate,
    );
  }
}
