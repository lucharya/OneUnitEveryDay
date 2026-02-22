import '../entities/activity.dart';

/// Interface for activity data access
abstract class IActivityRepository {
  /// Get all activities ordered by creation date
  Future<List<Activity>> getAll();

  /// Get a single activity by id
  Future<Activity?> getById(int id);

  /// Create a new activity, returns the created activity with id
  Future<Activity> create(Activity activity);

  /// Update an existing activity
  Future<void> update(Activity activity);

  /// Delete an activity and all its logs
  Future<void> delete(int id);
}
