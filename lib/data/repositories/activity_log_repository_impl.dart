import '../../domain/entities/activity_log.dart';
import '../../domain/repositories/activity_log_repository.dart';
import '../datasources/activity_log_local_datasource.dart';
import '../models/activity_log_model.dart';

/// Implementation of IActivityLogRepository using local SQLite data source
class ActivityLogRepositoryImpl implements IActivityLogRepository {
  final ActivityLogLocalDataSource _dataSource;

  ActivityLogRepositoryImpl({ActivityLogLocalDataSource? dataSource})
      : _dataSource = dataSource ?? ActivityLogLocalDataSource();

  @override
  Future<List<ActivityLog>> getByActivityId(int activityId) async {
    final models = await _dataSource.getByActivityId(activityId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<ActivityLog?> getByActivityAndDate(
    int activityId,
    String date,
  ) async {
    final model = await _dataSource.getByActivityAndDate(activityId, date);
    return model?.toEntity();
  }

  @override
  Future<List<ActivityLog>> getByActivityAndDateRange(
    int activityId,
    String startDate,
    String endDate,
  ) async {
    final models = await _dataSource.getByActivityAndDateRange(
      activityId,
      startDate,
      endDate,
    );
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<ActivityLog> create(ActivityLog log) async {
    final model = ActivityLogModel.fromEntity(log);
    final id = await _dataSource.insert(model);
    return log.copyWith(id: id);
  }

  @override
  Future<bool> existsForDate(int activityId, String date) async {
    return await _dataSource.existsForDate(activityId, date);
  }

  @override
  Future<bool> deleteByActivityAndDate(int activityId, String date) async {
    final count = await _dataSource.deleteByActivityAndDate(activityId, date);
    return count > 0;
  }

  @override
  Future<void> deleteByActivityId(int activityId) async {
    await _dataSource.deleteByActivityId(activityId);
  }
}
