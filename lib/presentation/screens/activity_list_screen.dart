import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';

import '../../core/design/design.dart';
import '../providers/activity_providers.dart';
import '../widgets/activity_card.dart';
import '../widgets/empty_state.dart';
import 'activity_detail_screen.dart';
import 'create_edit_activity_screen.dart';

/// Home screen showing list of all activities with streaks and status
class ActivityListScreen extends ConsumerWidget {
  const ActivityListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesAsync = ref.watch(activitiesProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.appTitle,
          style: AppTypography.headlineMedium,
        ),
      ),
      body: activitiesAsync.when(
        data: (activities) {
          if (activities.isEmpty) {
            return EmptyState(
              icon: Icons.add_task,
              title: l10n.noActivitiesYet,
              subtitle: l10n.noActivitiesSubtitle,
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: activities.length,
            separatorBuilder: (_, _) =>
                const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final activity = activities[index];
              final activityId = activity.id!;

              return _ActivityCardWrapper(
                activityId: activityId,
                name: activity.name,
                description: activity.description,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ActivityDetailScreen(
                        activityId: activityId,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text('Erro: $error'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push<bool>(
            MaterialPageRoute(
              builder: (_) => const CreateEditActivityScreen(),
            ),
          );
          if (result == true) {
            ref.invalidate(activitiesProvider);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Wrapper widget that loads streak and today status for each activity card
class _ActivityCardWrapper extends ConsumerWidget {
  final int activityId;
  final String name;
  final String? description;
  final VoidCallback onTap;

  const _ActivityCardWrapper({
    required this.activityId,
    required this.name,
    this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakAsync = ref.watch(streakProvider(activityId));
    final todayAsync = ref.watch(todayStatusProvider(activityId));

    final streak = streakAsync.valueOrNull ?? 0;
    final completedToday = todayAsync.valueOrNull ?? false;

    return ActivityCard(
      name: name,
      description: description,
      streak: streak,
      completedToday: completedToday,
      onTap: onTap,
    );
  }
}
