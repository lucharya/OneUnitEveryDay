import '../../core/utils/date_utils.dart';
import '../repositories/activity_log_repository.dart';

/// Use case: Calculate the current streak for an activity
class CalculateStreak {
  final IActivityLogRepository _repository;

  CalculateStreak(this._repository);

  /// Returns the number of consecutive days (up to today) with completion
  Future<int> call(int activityId) async {
    final logs = await _repository.getByActivityId(activityId);
    final dates = logs.map((l) => l.date).toList();
    return AppDateUtils.calculateStreak(dates);
  }
}
