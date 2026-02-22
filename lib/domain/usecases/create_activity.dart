import '../entities/activity.dart';
import '../entities/activity_type.dart';
import '../repositories/activity_repository.dart';

/// Use case: Create a new daily activity
class CreateActivity {
  final IActivityRepository _repository;

  CreateActivity(this._repository);

  Future<Activity> call({
    required String name,
    String? description,
  }) async {
    final activity = Activity(
      name: name.trim(),
      description: description?.trim(),
      type: ActivityType.daily,
      createdAt: DateTime.now(),
    );
    return await _repository.create(activity);
  }
}
