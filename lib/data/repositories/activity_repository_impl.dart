import '../../domain/entities/activity.dart';
import '../../domain/repositories/activity_repository.dart';
import '../datasources/activity_local_datasource.dart';
import '../models/activity_model.dart';

/// Implementation of IActivityRepository using local SQLite data source
class ActivityRepositoryImpl implements IActivityRepository {
  final ActivityLocalDataSource _dataSource;

  ActivityRepositoryImpl({ActivityLocalDataSource? dataSource})
      : _dataSource = dataSource ?? ActivityLocalDataSource();

  @override
  Future<List<Activity>> getAll() async {
    final models = await _dataSource.getAll();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Activity?> getById(int id) async {
    final model = await _dataSource.getById(id);
    return model?.toEntity();
  }

  @override
  Future<Activity> create(Activity activity) async {
    final model = ActivityModel.fromEntity(activity);
    final id = await _dataSource.insert(model);
    return activity.copyWith(id: id);
  }

  @override
  Future<void> update(Activity activity) async {
    final model = ActivityModel.fromEntity(activity);
    await _dataSource.update(model);
  }

  @override
  Future<void> delete(int id) async {
    await _dataSource.delete(id);
  }
}
