import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/design/design.dart';
import '../../core/utils/date_utils.dart';
import '../providers/activity_providers.dart';
import '../widgets/primary_button.dart';
import '../widgets/streak_badge.dart';
import '../widgets/timeline_item.dart';
import '../widgets/calendar_day.dart';
import 'create_edit_activity_screen.dart';

/// Detail screen for a single activity, with complete button, calendar & timeline
class ActivityDetailScreen extends ConsumerStatefulWidget {
  final int activityId;

  const ActivityDetailScreen({super.key, required this.activityId});

  @override
  ConsumerState<ActivityDetailScreen> createState() =>
      _ActivityDetailScreenState();
}

class _ActivityDetailScreenState extends ConsumerState<ActivityDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isCompleting = false;
  DateTime _focusedMonth = DateTime.now();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _toggleToday(bool completedToday) async {
    if (_isCompleting) return;

    setState(() => _isCompleting = true);

    try {
      final notifier =
          ref.read(activityLogsProvider(widget.activityId).notifier);

      if (completedToday) {
        await notifier.uncompleteToday();
      } else {
        final success = await notifier.completeToday();
        if (mounted && success) {
          final l10n = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.activityCompleted),
              backgroundColor: AppColors.success,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isCompleting = false);
      }
    }
  }

  Future<void> _deleteActivity() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteActivity),
        content: Text(l10n.deleteActivityConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await ref
          .read(activitiesProvider.notifier)
          .deleteActivity(widget.activityId);
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.activityDeleted)),
        );
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final activityAsync = ref.watch(activityProvider(widget.activityId));
    final streakAsync = ref.watch(streakProvider(widget.activityId));
    final todayAsync = ref.watch(todayStatusProvider(widget.activityId));
    final logsAsync = ref.watch(activityLogsProvider(widget.activityId));
    final l10n = AppLocalizations.of(context)!;

    return activityAsync.when(
      data: (activity) {
        if (activity == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Atividade não encontrada')),
          );
        }

        final streak = streakAsync.valueOrNull ?? 0;
        final completedToday = todayAsync.valueOrNull ?? false;
        final logs = logsAsync.valueOrNull ?? [];
        final completedDates =
            logs.map((l) => l.date).toSet();

        return Scaffold(
          appBar: AppBar(
            title: Text(
              activity.name,
              style: AppTypography.headlineSmall,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () async {
                  final result = await Navigator.of(context).push<bool>(
                    MaterialPageRoute(
                      builder: (_) => CreateEditActivityScreen(
                        activity: activity,
                      ),
                    ),
                  );
                  if (result == true) {
                    ref.invalidate(activitiesProvider);
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: _deleteActivity,
              ),
            ],
          ),
          body: Column(
            children: [
              // Header with description, streak and complete button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (activity.description != null &&
                        activity.description!.isNotEmpty) ...[
                      Text(
                        activity.description!,
                        style: AppTypography.bodyMedium,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                    // Streak display
                    Row(
                      children: [
                        Text(
                          l10n.currentStreak,
                          style: AppTypography.titleMedium,
                        ),
                        const Spacer(),
                        StreakBadge(streak: streak),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    // Complete Today button
                    PrimaryButton(
                      label: completedToday
                          ? l10n.completedToday
                          : l10n.completeToday,
                      isCompleted: completedToday,
                      isLoading: _isCompleting,
                      icon: completedToday ? Icons.check : Icons.bolt,
                      onPressed: () => _toggleToday(completedToday),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
              // Tab bar
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.border),
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textTertiary,
                  indicatorColor: AppColors.primary,
                  tabs: [
                    Tab(text: l10n.calendar),
                    Tab(text: l10n.timeline),
                  ],
                ),
              ),
              // Tab content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Calendar view
                    _CalendarTab(
                      completedDates: completedDates,
                      focusedMonth: _focusedMonth,
                      onMonthChanged: (month) {
                        setState(() => _focusedMonth = month);
                      },
                    ),
                    // Timeline view
                    _TimelineTab(
                      completedDates: completedDates,
                      activityCreatedAt: activity.createdAt,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('Erro: $error')),
      ),
    );
  }
}

/// Calendar tab showing completed days in a monthly view.
class _CalendarTab extends StatelessWidget {
  final Set<String> completedDates;
  final DateTime focusedMonth;
  final ValueChanged<DateTime> onMonthChanged;

  const _CalendarTab({
    required this.completedDates,
    required this.focusedMonth,
    required this.onMonthChanged,
  });

  /// Builds a single calendar day cell with streak connection bars.
  Widget _buildDay(DateTime day, {required bool isToday}) {
    final dateStr = AppDateUtils.formatDate(day);
    final isCompleted = completedDates.contains(dateStr);

    bool connectLeft = false;
    bool connectRight = false;

    if (isCompleted) {
      final prevDay = day.subtract(const Duration(days: 1));
      final nextDay = day.add(const Duration(days: 1));
      final prevCompleted =
          completedDates.contains(AppDateUtils.formatDate(prevDay));
      final nextCompleted =
          completedDates.contains(AppDateUtils.formatDate(nextDay));

      // Only connect within the same week row (Monday = 1, Sunday = 7)
      connectLeft = prevCompleted && day.weekday != DateTime.monday;
      connectRight = nextCompleted && day.weekday != DateTime.sunday;
    }

    return CalendarDay(
      text: '${day.day}',
      isCompleted: isCompleted,
      isToday: isToday,
      connectLeft: connectLeft,
      connectRight: connectRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: TableCalendar(
        firstDay: DateTime(2020, 1, 1),
        lastDay: DateTime.now(),
        focusedDay: focusedMonth,
        calendarFormat: CalendarFormat.month,
        availableCalendarFormats: const {CalendarFormat.month: 'Mês'},
        startingDayOfWeek: StartingDayOfWeek.monday,
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: AppTypography.titleLarge,
          leftChevronIcon: const Icon(
            Icons.chevron_left,
            color: AppColors.textSecondary,
          ),
          rightChevronIcon: const Icon(
            Icons.chevron_right,
            color: AppColors.textSecondary,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: AppTypography.labelSmall,
          weekendStyle: AppTypography.labelSmall,
        ),
        calendarStyle: const CalendarStyle(
          outsideDaysVisible: true,
          cellMargin: EdgeInsets.all(2),
        ),
        onPageChanged: onMonthChanged,
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            return _buildDay(day, isToday: false);
          },
          todayBuilder: (context, day, focusedDay) {
            return _buildDay(day, isToday: true);
          },
          outsideBuilder: (context, day, focusedDay) {
            return const CalendarDay(text: '', isOutside: true);
          },
        ),
      ),
    );
  }
}

/// Timeline tab showing all days from activity creation to today.
class _TimelineTab extends StatelessWidget {
  final Set<String> completedDates;
  final DateTime activityCreatedAt;

  const _TimelineTab({
    required this.completedDates,
    required this.activityCreatedAt,
  });

  @override
  Widget build(BuildContext context) {
    final today = AppDateUtils.today;
    final creationDay = DateTime(
      activityCreatedAt.year,
      activityCreatedAt.month,
      activityCreatedAt.day,
    );
    final totalDays = today.difference(creationDay).inDays + 1;

    // Generate all days from today back to creation date
    final days = List.generate(totalDays, (i) {
      final date = today.subtract(Duration(days: i));
      return AppDateUtils.formatDate(date);
    });

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      itemCount: days.length,
      itemBuilder: (context, index) {
        final dateStr = days[index];
        final isCompleted = completedDates.contains(dateStr);
        return TimelineItem(
          date: dateStr,
          isCompleted: isCompleted,
          isFirst: index == 0,
          isLast: index == days.length - 1,
        );
      },
    );
  }
}
