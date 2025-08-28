import 'package:core_utility/core_utility.dart';
import 'package:data_layer/data_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_master_app/config/routes.dart';
import 'package:sales_master_app/controllers/drawer_controller.dart';
import 'package:sales_master_app/services/push_notification_service.dart';
import 'package:sales_master_app/themes/dark_theme.dart';
import 'package:sales_master_app/themes/light_theme.dart';
import 'package:toastification/toastification.dart';
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

  // translation
  RepoLocalizations.setLocale(Locale("en"));

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
    return ToastificationWrapper(
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('fr'),
        ],
        routerConfig: AppRoutes().router,
      ),
    );
  }
}
