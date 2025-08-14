import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_master_app/controllers/auth_controller.dart';
import 'package:sales_master_app/models/deal.dart';
import 'package:sales_master_app/views/bad_debt_details.dart';
import 'package:sales_master_app/views/base_view.dart';
import 'package:sales_master_app/views/catalogue_screen.dart';
import 'package:sales_master_app/views/client_details_screen.dart';
import 'package:sales_master_app/views/clients_screen.dart';
import 'package:sales_master_app/views/deals_details_screen.dart';
import 'package:sales_master_app/views/deals_screen.dart';
import 'package:sales_master_app/views/home_screen.dart';
import 'package:sales_master_app/views/login_screen.dart';
import 'package:sales_master_app/views/notification_screen.dart';
import 'package:sales_master_app/views/otp_screen.dart';
import 'package:sales_master_app/views/pipeline_main_page.dart';
import 'package:sales_master_app/views/precess_and_forms.dart';
//import 'package:sales_master_app/views/precess_and_forms.dart';
import 'package:sales_master_app/views/realisation_screen.dart';
import 'package:sales_master_app/views/todolist_archive_screen.dart';
import 'package:sales_master_app/views/todolist_screen.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = Get.key;
  static final _sectionNavigatorKey = GlobalKey<NavigatorState>();

  static const login = _Route(path: '/login', name: 'login');
  static const otpValidation = _Route(path: '/otpValidation', name: 'otp');
  static const notification =
      _Route(path: "/notifications", name: "notifications");
  static const clientDetails =
      _Route(path: '/clientDetails', name: 'clientDetails');
  static const myClients = _Route(path: '/myClients', name: 'myClients');
  static const processAndForms =
      _Route(path: '/processAndForms', name: 'processAndForms');
  static const badDebtDetails =
      _Route(path: '/badDebtDetails', name: "badDebtDetails");
  static const pipeline = _Route(path: '/Pipeline', name: "pipeline");
  static const todolist = _Route(path: '/todolist', name: "todolist");
  static const dealsScreen = _Route(path: "/deals", name: "deals");
  static const todolistArchive =
      _Route(path: "/todolist_archive", name: "todolist_archive");
  static const dealDetails = _Route(path: "/dealDetails", name: "dealDetails");
  static const catalogue = _Route(path: "/catalogue", name: "catalogue");
  static const dashboardRealisations =
      _Route(path: "/realisations", name: "realisations");
  static const home = _Route(path: "/homepage", name: "home");

  final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    // redirect: (BuildContext context, GoRouterState state) {
    //   final isAuthenticated = Get.find<AuthController>().isLoged.value;
    //   if (!isAuthenticated) {
    //     return '/login';
    //   } else {
    //     return null;
    //   }
    // },

    redirect: (BuildContext context, GoRouterState state) {
      final authController = Get.find<AuthController>();
      final isLoggedIn = authController.isLoged.value;

      // If not logged in, always go to login (except if already on login/otp)
      if (!isLoggedIn &&
          state.matchedLocation != '/login' &&
          state.matchedLocation != '/otpValidation') {
        return '/login';
      }

      // If logged in and trying to go to login/otp, redirect to home
      if (isLoggedIn &&
          (state.matchedLocation == '/login' ||
              state.matchedLocation == '/otpValidation')) {
        return '/homepage';
      }

      return null; // stay on current route
    },
    routes: [
      GoRoute(
        name: AppRoutes.login.name,
        path: AppRoutes.login.path,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        name: AppRoutes.otpValidation.name,
        path: AppRoutes.otpValidation.path,
        builder: (context, state) => OtpScreen(),
      ),
      GoRoute(
        name: AppRoutes.notification.name,
        path: AppRoutes.notification.path,
        builder: (context, state) => const NotificationScreen(),
      ),
      // GoRoute(
      //   name: AppRoutes.pipeline.name,
      //   path: AppRoutes.pipeline.path,
      //   builder: (context, state) => PipelineMainPage(),
      // ),
      GoRoute(
        name: AppRoutes.dealsScreen.name,
        path: AppRoutes.dealsScreen.path,
        builder: (context, state) => const DealsScreen(),
      ),
      GoRoute(
        name: AppRoutes.dashboardRealisations.name,
        path: AppRoutes.dashboardRealisations.path,
        builder: (context, state) => const RealisationScreen(),
      ),
      // GoRoute(
      //   name: AppRoutes.processAndForms.name,
      //   path: AppRoutes.processAndForms.path,
      //   builder: (context, state) => const ProcessAndForms(),
      // ),
      GoRoute(
        name: AppRoutes.catalogue.name,
        path: AppRoutes.catalogue.path,
        builder: (context, state) => const CatalogueScreen(),
      ),

      GoRoute(
        name: AppRoutes.dealDetails.name,
        path: AppRoutes.dealDetails.path,
        builder: (context, state) {
          Deal? deal = state.extra as Deal?;
          return DealsDetailsScreen(
            deal: deal,
          );
        },
      ),
      // GoRoute(
      //   name: AppRoutes.myClients.name,
      //   path: AppRoutes.myClients.path,
      //   builder: (context, state) {
      //     return ClientsScreen();
      //   },
      // ),
      GoRoute(
        name: AppRoutes.clientDetails.name,
        path: AppRoutes.clientDetails.path,
        builder: (context, state) {
          String id = state.extra as String;
          return ClientDetailsScreen(
            clientId: id,
          );
        },
      ),
      GoRoute(
        name: AppRoutes.badDebtDetails.name,
        path: AppRoutes.badDebtDetails.path,
        builder: (context, state) {
          String id = state.extra as String;
          return BadDebtDetails(
            badDebtId: id,
          );
        },
      ),
      GoRoute(
        name: AppRoutes.todolistArchive.name,
        path: AppRoutes.todolistArchive.path,
        builder: (context, state) {
          return TodolistArchiveScreen();
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BaseView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _sectionNavigatorKey,
            routes: [
              GoRoute(
                name: AppRoutes.home.name,
                path: AppRoutes.home.path,
                builder: (context, state) => HomeScreen(),
              ),
            ],
          ),

          // StatefulShellBranch(
          //   navigatorKey: _sectionNavigatorKey,
          //   routes: [
          //     GoRoute(
          //       name: AppRoutes.myClients.name,
          //       path: AppRoutes.myClients.path,
          //       builder: (context, state) => ClientsScreen(),
          //     ),
          //   ],
          // ),
          // StatefulShellBranch(
          //   routes: [
          //     GoRoute(
          //       name: AppRoutes.pipeline.name,
          //       path: AppRoutes.pipeline.path,
          //       builder: (context, state) => PipelineMainPage(),
          //     ),
          //   ],
          // ),
          // StatefulShellBranch(
          //   routes: [
          //     GoRoute(
          //       name: AppRoutes.processAndForms.name,
          //       path: AppRoutes.processAndForms.path,
          //       builder: (context, state) => ProcessAndForms(),
          //     ),
          //   ],
          // ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.myClients.name,
                path: AppRoutes.myClients.path,
                builder: (context, state) => ClientsScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.pipeline.name,
                path: AppRoutes.pipeline.path,
                builder: (context, state) => PipelineMainPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.todolist.name,
                path: AppRoutes.todolist.path,
                builder: (context, state) => TodolistScreen(),
              ),
            ],
          ),

          // StatefulShellBranch(
          //   routes: [
          //     GoRoute(
          //       name: AppRoutes.dashboardRealisations.name,
          //       path: AppRoutes.dashboardRealisations.path,
          //       builder: (context, state) => RealisationScreen(),
          //     ),
          //   ],
          // ),
        ],
      ),
    ],
  );
}

class _Route {
  final String path;
  final String name;
  const _Route({required this.path, required this.name});
}
