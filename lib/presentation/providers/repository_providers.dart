import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/activity_local_datasource.dart';
import '../../data/datasources/activity_log_local_datasource.dart';
import '../../data/repositories/activity_log_repository_impl.dart';
import '../../data/repositories/activity_repository_impl.dart';
import '../../domain/repositories/activity_log_repository.dart';
import '../../domain/repositories/activity_repository.dart';

/// Provider for the activity repository
final activityRepositoryProvider = Provider<IActivityRepository>((ref) {
  return ActivityRepositoryImpl(dataSource: ActivityLocalDataSource());
});

/// Provider for the activity log repository
final activityLogRepositoryProvider = Provider<IActivityLogRepository>((ref) {
  return ActivityLogRepositoryImpl(dataSource: ActivityLogLocalDataSource());
});
