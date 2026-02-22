import '../entities/activity.dart';
import '../repositories/activity_repository.dart';

/// Use case: Get all activities
class GetActivities {
  final IActivityRepository _repository;

  GetActivities(this._repository);

  Future<List<Activity>> call() async {
    return await _repository.getAll();
  }
}
