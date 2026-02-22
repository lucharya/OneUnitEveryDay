import '../entities/activity.dart';
import '../repositories/activity_repository.dart';

/// Use case: Get a single activity by its id
class GetActivityById {
  final IActivityRepository _repository;

  GetActivityById(this._repository);

  Future<Activity?> call(int id) async {
    return await _repository.getById(id);
  }
}
