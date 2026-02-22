// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'OneUnitEveryDay';

  @override
  String get activities => 'Atividades';

  @override
  String get noActivitiesYet => 'Ainda não há atividades';

  @override
  String get noActivitiesSubtitle =>
      'Toque no + para criar sua primeira atividade';

  @override
  String get createActivity => 'Criar Atividade';

  @override
  String get editActivity => 'Editar Atividade';

  @override
  String get deleteActivity => 'Excluir Atividade';

  @override
  String get deleteActivityConfirmation =>
      'Tem certeza que deseja excluir esta atividade? Todos os registros serão perdidos.';

  @override
  String get activityName => 'Nome da atividade';

  @override
  String get activityNameRequired => 'O nome é obrigatório';

  @override
  String get activityDescription => 'Descrição (opcional)';

  @override
  String get save => 'Salvar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get completeToday => 'Completar Hoje';

  @override
  String get completedToday => 'Completo Hoje ✓';

  @override
  String get currentStreak => 'Sequência Atual';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias',
      one: '1 dia',
      zero: '0 dias',
    );
    return '$_temp0';
  }

  @override
  String get calendar => 'Calendário';

  @override
  String get timeline => 'Linha do Tempo';

  @override
  String get completed => 'Completo';

  @override
  String get notCompleted => 'Não completo';

  @override
  String get today => 'Hoje';

  @override
  String get yesterday => 'Ontem';

  @override
  String get daily => 'Diário';

  @override
  String get activityCreated => 'Atividade criada com sucesso!';

  @override
  String get activityUpdated => 'Atividade atualizada com sucesso!';

  @override
  String get activityDeleted => 'Atividade excluída com sucesso!';

  @override
  String get activityCompleted => 'Atividade completada! Continue assim!';

  @override
  String get description => 'Descrição';
}
