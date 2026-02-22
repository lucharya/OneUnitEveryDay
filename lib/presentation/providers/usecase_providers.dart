import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/usecases.dart';
import 'repository_providers.dart';

/// Provider for CreateActivity use case
final createActivityProvider = Provider<CreateActivity>((ref) {
  return CreateActivity(ref.watch(activityRepositoryProvider));
});

/// Provider for UpdateActivity use case
final updateActivityProvider = Provider<UpdateActivity>((ref) {
  return UpdateActivity(ref.watch(activityRepositoryProvider));
});

/// Provider for DeleteActivity use case
final deleteActivityProvider = Provider<DeleteActivity>((ref) {
  return DeleteActivity(
    ref.watch(activityRepositoryProvider),
    ref.watch(activityLogRepositoryProvider),
  );
});

/// Provider for GetActivities use case
final getActivitiesProvider = Provider<GetActivities>((ref) {
  return GetActivities(ref.watch(activityRepositoryProvider));
});

/// Provider for GetActivityById use case
final getActivityByIdProvider = Provider<GetActivityById>((ref) {
  return GetActivityById(ref.watch(activityRepositoryProvider));
});

/// Provider for CompleteActivityToday use case
final completeActivityTodayProvider = Provider<CompleteActivityToday>((ref) {
  return CompleteActivityToday(ref.watch(activityLogRepositoryProvider));
});

/// Provider for UncompleteActivityToday use case
final uncompleteActivityTodayProvider =
    Provider<UncompleteActivityToday>((ref) {
  return UncompleteActivityToday(ref.watch(activityLogRepositoryProvider));
});

/// Provider for GetActivityLogs use case
final getActivityLogsProvider = Provider<GetActivityLogs>((ref) {
  return GetActivityLogs(ref.watch(activityLogRepositoryProvider));
});

/// Provider for CalculateStreak use case
final calculateStreakProvider = Provider<CalculateStreak>((ref) {
  return CalculateStreak(ref.watch(activityLogRepositoryProvider));
});
