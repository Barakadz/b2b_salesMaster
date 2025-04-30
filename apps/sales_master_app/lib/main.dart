import 'package:core_utility/core_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sales_master_app/config/routes.dart';
import 'package:sales_master_app/themes/dark_theme.dart';
import 'package:sales_master_app/themes/light_theme.dart';
import 'package:sales_master_app/views/login_screen.dart';

void main() {
  RepoLocalizations.setLocale(Locale("en"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate
      ],
      supportedLocales: [
        Locale('en'),
        Locale('fr'),
      ],
      routerConfig: AppRoutes.router,
    );
  }
}
