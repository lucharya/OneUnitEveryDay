import '../../core/utils/date_utils.dart';
import '../entities/activity_log.dart';
import '../repositories/activity_log_repository.dart';

/// Use case: Mark an activity as completed for today
class CompleteActivityToday {
  final IActivityLogRepository _repository;

  CompleteActivityToday(this._repository);

  /// Returns the created log, or null if already completed today
  Future<ActivityLog?> call(int activityId) async {
    final today = AppDateUtils.todayString;

    // Check if already completed today
    final exists = await _repository.existsForDate(activityId, today);
    if (exists) return null;

    final log = ActivityLog(
      activityId: activityId,
      date: today,
      createdAt: DateTime.now(),
    );

    return await _repository.create(log);
  }
}
