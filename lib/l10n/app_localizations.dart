import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In pt, this message translates to:
  /// **'OneUnitEveryDay'**
  String get appTitle;

  /// No description provided for @activities.
  ///
  /// In pt, this message translates to:
  /// **'Atividades'**
  String get activities;

  /// No description provided for @noActivitiesYet.
  ///
  /// In pt, this message translates to:
  /// **'Ainda não há atividades'**
  String get noActivitiesYet;

  /// No description provided for @noActivitiesSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Toque no + para criar sua primeira atividade'**
  String get noActivitiesSubtitle;

  /// No description provided for @createActivity.
  ///
  /// In pt, this message translates to:
  /// **'Criar Atividade'**
  String get createActivity;

  /// No description provided for @editActivity.
  ///
  /// In pt, this message translates to:
  /// **'Editar Atividade'**
  String get editActivity;

  /// No description provided for @deleteActivity.
  ///
  /// In pt, this message translates to:
  /// **'Excluir Atividade'**
  String get deleteActivity;

  /// No description provided for @deleteActivityConfirmation.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja excluir esta atividade? Todos os registros serão perdidos.'**
  String get deleteActivityConfirmation;

  /// No description provided for @activityName.
  ///
  /// In pt, this message translates to:
  /// **'Nome da atividade'**
  String get activityName;

  /// No description provided for @activityNameRequired.
  ///
  /// In pt, this message translates to:
  /// **'O nome é obrigatório'**
  String get activityNameRequired;

  /// No description provided for @activityDescription.
  ///
  /// In pt, this message translates to:
  /// **'Descrição (opcional)'**
  String get activityDescription;

  /// No description provided for @save.
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In pt, this message translates to:
  /// **'Excluir'**
  String get delete;

  /// No description provided for @completeToday.
  ///
  /// In pt, this message translates to:
  /// **'Completar Hoje'**
  String get completeToday;

  /// No description provided for @completedToday.
  ///
  /// In pt, this message translates to:
  /// **'Completo Hoje ✓'**
  String get completedToday;

  /// No description provided for @currentStreak.
  ///
  /// In pt, this message translates to:
  /// **'Sequência Atual'**
  String get currentStreak;

  /// No description provided for @streakDays.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{0 dias} =1{1 dia} other{{count} dias}}'**
  String streakDays(int count);

  /// No description provided for @calendar.
  ///
  /// In pt, this message translates to:
  /// **'Calendário'**
  String get calendar;

  /// No description provided for @timeline.
  ///
  /// In pt, this message translates to:
  /// **'Linha do Tempo'**
  String get timeline;

  /// No description provided for @completed.
  ///
  /// In pt, this message translates to:
  /// **'Completo'**
  String get completed;

  /// No description provided for @notCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Não completo'**
  String get notCompleted;

  /// No description provided for @today.
  ///
  /// In pt, this message translates to:
  /// **'Hoje'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In pt, this message translates to:
  /// **'Ontem'**
  String get yesterday;

  /// No description provided for @daily.
  ///
  /// In pt, this message translates to:
  /// **'Diário'**
  String get daily;

  /// No description provided for @activityCreated.
  ///
  /// In pt, this message translates to:
  /// **'Atividade criada com sucesso!'**
  String get activityCreated;

  /// No description provided for @activityUpdated.
  ///
  /// In pt, this message translates to:
  /// **'Atividade atualizada com sucesso!'**
  String get activityUpdated;

  /// No description provided for @activityDeleted.
  ///
  /// In pt, this message translates to:
  /// **'Atividade excluída com sucesso!'**
  String get activityDeleted;

  /// No description provided for @activityCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Atividade completada! Continue assim!'**
  String get activityCompleted;

  /// No description provided for @description.
  ///
  /// In pt, this message translates to:
  /// **'Descrição'**
  String get description;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
