// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'OneUnitEveryDay';

  @override
  String get activities => 'Activities';

  @override
  String get noActivitiesYet => 'No activities yet';

  @override
  String get noActivitiesSubtitle => 'Tap + to create your first activity';

  @override
  String get createActivity => 'Create Activity';

  @override
  String get editActivity => 'Edit Activity';

  @override
  String get deleteActivity => 'Delete Activity';

  @override
  String get deleteActivityConfirmation =>
      'Are you sure you want to delete this activity? All records will be lost.';

  @override
  String get activityName => 'Activity name';

  @override
  String get activityNameRequired => 'Name is required';

  @override
  String get activityDescription => 'Description (optional)';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get completeToday => 'Complete Today';

  @override
  String get completedToday => 'Completed Today ✓';

  @override
  String get currentStreak => 'Current Streak';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
      zero: '0 days',
    );
    return '$_temp0';
  }

  @override
  String get calendar => 'Calendar';

  @override
  String get timeline => 'Timeline';

  @override
  String get completed => 'Completed';

  @override
  String get notCompleted => 'Not completed';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get daily => 'Daily';

  @override
  String get activityCreated => 'Activity created successfully!';

  @override
  String get activityUpdated => 'Activity updated successfully!';

  @override
  String get activityDeleted => 'Activity deleted successfully!';

  @override
  String get activityCompleted => 'Activity completed! Keep it up!';

  @override
  String get description => 'Description';
}
