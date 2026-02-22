import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/date_utils.dart';
import '../../domain/entities/activity.dart';
import '../../domain/entities/activity_log.dart';
import 'usecase_providers.dart';

/// Provider for the list of all activities
final activitiesProvider =
    AsyncNotifierProvider<ActivitiesNotifier, List<Activity>>(
  ActivitiesNotifier.new,
);

class ActivitiesNotifier extends AsyncNotifier<List<Activity>> {
  @override
  Future<List<Activity>> build() async {
    return await ref.watch(getActivitiesProvider).call();
  }

  Future<Activity> createActivity({
    required String name,
    String? description,
  }) async {
    final activity = await ref.read(createActivityProvider).call(
          name: name,
          description: description,
        );
    ref.invalidateSelf();
    return activity;
  }

  Future<void> updateActivity({
    required Activity activity,
    required String name,
    String? description,
  }) async {
    await ref.read(updateActivityProvider).call(
          activity: activity,
          name: name,
          description: description,
        );
    ref.invalidateSelf();
  }

  Future<void> deleteActivity(int activityId) async {
    await ref.read(deleteActivityProvider).call(activityId);
    ref.invalidateSelf();
  }
}

/// Provider for a single activity by ID
final activityProvider =
    FutureProvider.family<Activity?, int>((ref, id) async {
  final activities = await ref.watch(activitiesProvider.future);
  try {
    return activities.firstWhere((a) => a.id == id);
  } catch (_) {
    return null;
  }
});

/// Provider for activity logs for a given activity
final activityLogsProvider =
    AsyncNotifierProvider.family<ActivityLogsNotifier, List<ActivityLog>, int>(
  ActivityLogsNotifier.new,
);

class ActivityLogsNotifier extends FamilyAsyncNotifier<List<ActivityLog>, int> {
  @override
  Future<List<ActivityLog>> build(int arg) async {
    return await ref.watch(getActivityLogsProvider).call(arg);
  }

  Future<bool> completeToday() async {
    final result = await ref.read(completeActivityTodayProvider).call(arg);
    if (result != null) {
      final currentLogs = state.valueOrNull ?? [];
      state = AsyncData([result, ...currentLogs]);
      return true;
    }
    return false;
  }

  Future<bool> uncompleteToday() async {
    final success =
        await ref.read(uncompleteActivityTodayProvider).call(arg);
    if (success) {
      final today = AppDateUtils.todayString;
      final currentLogs = state.valueOrNull ?? [];
      state = AsyncData(currentLogs.where((l) => l.date != today).toList());
      return true;
    }
    return false;
  }
}

/// Provider for the current streak of an activity
final streakProvider = FutureProvider.family<int, int>((ref, activityId) async {
  // Re-compute when logs change
  final logs = await ref.watch(activityLogsProvider(activityId).future);
  final dates = logs.map((l) => l.date).toList();
  return AppDateUtils.calculateStreak(dates);
});

/// Provider for whether an activity is completed today
final todayStatusProvider =
    FutureProvider.family<bool, int>((ref, activityId) async {
  final logs = await ref.watch(activityLogsProvider(activityId).future);
  final today = AppDateUtils.todayString;
  return logs.any((l) => l.date == today);
});
