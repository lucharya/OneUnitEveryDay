import '../../core/utils/date_utils.dart';
import '../repositories/activity_log_repository.dart';

/// Use case: Remove today's completion for an activity
class UncompleteActivityToday {
  final IActivityLogRepository _repository;

  UncompleteActivityToday(this._repository);

  /// Returns true if the log was deleted, false if there was nothing to delete
  Future<bool> call(int activityId) async {
    final today = AppDateUtils.todayString;
    return await _repository.deleteByActivityAndDate(activityId, today);
  }
}
