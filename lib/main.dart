import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'l10n/app_localizations.dart';

import 'core/design/app_theme.dart';
import 'presentation/screens/activity_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: OneUnitEveryDayApp()));
}

class OneUnitEveryDayApp extends StatelessWidget {
  const OneUnitEveryDayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OneUnitEveryDay',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      locale: const Locale('pt'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const ActivityListScreen(),
    );
  }
}
