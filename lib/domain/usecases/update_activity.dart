import '../entities/activity.dart';
import '../repositories/activity_repository.dart';

/// Use case: Update an existing activity
class UpdateActivity {
  final IActivityRepository _repository;

  UpdateActivity(this._repository);

  Future<void> call({
    required Activity activity,
    required String name,
    String? description,
  }) async {
    final updated = activity.copyWith(
      name: name.trim(),
      description: description?.trim(),
    );
    await _repository.update(updated);
  }
}
