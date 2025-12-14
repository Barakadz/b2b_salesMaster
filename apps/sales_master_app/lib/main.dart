import 'package:data_layer/data_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/config/routes.dart';
import 'package:sales_master_app/controllers/drawer_controller.dart';
import 'package:sales_master_app/controllers/language_controller.dart';
import 'package:sales_master_app/localization/app_translation.dart';
import 'package:sales_master_app/services/push_notification_service.dart';
import 'package:sales_master_app/themes/dark_theme.dart';
import 'package:sales_master_app/themes/light_theme.dart';
import 'controllers/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //push notification
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupNotificationChannel();
  await initializeLocalNotifications();
  await PushNotificationService.init();

  //in app storage
  await AppStorage().init();

  // global controllers
  AuthController authController = Get.put(AuthController(), permanent: true);
  Get.put<CustomDrawerController>(CustomDrawerController());
 
  //api services config
  Config.configure(
      enableRefreshToken: true,
      tokenKey: "access_token",
      refreshTokenKey: "refresh_token");
  Api.getInstance(baseUrl: authController.getBaseUrl());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController languageController = Get.put(LanguageController());

    return GetMaterialApp.router(
      title: 'B2B Sales Master',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      locale: languageController.appLocale.value,
      fallbackLocale: const Locale('en'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
      ],
      translations: AppTranslations(),
      routeInformationParser: appRoutes.router.routeInformationParser,
      routerDelegate: appRoutes.router.routerDelegate,
      routeInformationProvider: appRoutes.router.routeInformationProvider,
    );
  }
}