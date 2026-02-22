import '../repositories/activity_log_repository.dart';
import '../repositories/activity_repository.dart';

/// Use case: Delete an activity and all its logs
class DeleteActivity {
  final IActivityRepository _activityRepository;
  final IActivityLogRepository _logRepository;

  DeleteActivity(this._activityRepository, this._logRepository);

  Future<void> call(int activityId) async {
    // Delete logs first (also handled by CASCADE, but explicit is better)
    await _logRepository.deleteByActivityId(activityId);
    await _activityRepository.delete(activityId);
  }
}
