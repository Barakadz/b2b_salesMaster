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
import 'package:sales_master_app/views/realisation_screen.dart';
import 'package:sales_master_app/views/todolist_archive_screen.dart';
import 'package:sales_master_app/views/todolist_screen.dart';

final appRoutes = AppRoutes();

class AppRoutes {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = Get.key;

  static BuildContext? get rootContext => _rootNavigatorKey.currentContext;
  
  // Unique navigator keys for each branch
  static final _homeNavigatorKey = GlobalKey<NavigatorState>();
  static final _clientsNavigatorKey = GlobalKey<NavigatorState>();
  static final _pipelineNavigatorKey = GlobalKey<NavigatorState>();
  static final _todolistNavigatorKey = GlobalKey<NavigatorState>();

  static const login = _Route(path: '/login', name: 'login');
  static const otpValidation = _Route(path: '/otpValidation', name: 'otp');
  static const notification = _Route(path: "/notifications", name: "notifications");
  static const clientDetails = _Route(path: '/clientDetails', name: 'clientDetails');
  static const myClients = _Route(path: '/myClients', name: 'myClients');
  static const processAndForms = _Route(path: '/processAndForms', name: 'processAndForms');
  static const badDebtDetails = _Route(path: '/badDebtDetails', name: "badDebtDetails");
  static const pipeline = _Route(path: '/Pipeline', name: "pipeline");
  static const todolist = _Route(path: '/todolist', name: "todolist");
  static const dealsScreen = _Route(path: "/deals", name: "deals");
  static const todolistArchive = _Route(path: "/todolist_archive", name: "todolist_archive");
  static const dealDetails = _Route(path: "/dealDetails", name: "dealDetails");
  static const catalogue = _Route(path: "/catalogue", name: "catalogue");
  static const dashboardRealisations = _Route(path: "/realisations", name: "realisations");
  static const home = _Route(path: "/homepage", name: "home");

  final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    refreshListenable: Get.find<AuthController>().isLoggedNotifier,
    initialLocation: '/login',
    redirect: (context, state) {
      final authController = Get.find<AuthController>();
      final isLoggedIn = authController.isLoged.value;
      final location = state.matchedLocation;

      // Public routes (no auth required)
      final publicRoutes = ['/login', '/otpValidation'];

      if (!isLoggedIn && !publicRoutes.contains(location)) {
        return '/login';
      }

      if (isLoggedIn && publicRoutes.contains(location)) {
        return '/homepage';
      }

      return null;
    },
    routes: [
      // Public routes (NO bottom navigation)
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
      
      // StatefulShellRoute - ALL authenticated pages with bottom nav
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BaseView(navigationShell: navigationShell);
        },
        branches: [
          // HOME BRANCH
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                name: AppRoutes.home.name,
                path: AppRoutes.home.path,
                builder: (context, state) => HomeScreen(),
              ),
              // All these routes are SIBLINGS of home, not children
              GoRoute(
                name: AppRoutes.notification.name,
                path: '/notifications',
                builder: (context, state) => const NotificationScreen(),
              ),
              GoRoute(
                name: AppRoutes.dealsScreen.name,
                path: '/deals',
                builder: (context, state) => const DealsScreen(),
              ),
              GoRoute(
                name: AppRoutes.dealDetails.name,
                path: '/dealDetails',
                builder: (context, state) {
                  Deal? deal = state.extra as Deal?;
                  return DealsDetailsScreen(deal: deal);
                },
              ),
              GoRoute(
                name: AppRoutes.dashboardRealisations.name,
                path: '/realisations',
                builder: (context, state) => const RealisationScreen(),
              ),
              GoRoute(
                name: AppRoutes.catalogue.name,
                path: '/catalogue',
                builder: (context, state) => const CatalogueScreen(),
              ),
            ],
          ),
          
          // CLIENTS BRANCH
          StatefulShellBranch(
            navigatorKey: _clientsNavigatorKey,
            routes: [
              GoRoute(
                name: AppRoutes.myClients.name,
                path: AppRoutes.myClients.path,
                builder: (context, state) => ClientsScreen(),
              ),
              // Client-related routes as siblings
              GoRoute(
                name: AppRoutes.clientDetails.name,
                path: '/clientDetails',
                builder: (context, state) {
                  String id = state.extra as String;
                  return ClientDetailsScreen(clientId: id);
                },
              ),
              GoRoute(
                name: AppRoutes.badDebtDetails.name,
                path: '/badDebtDetails',
                builder: (context, state) {
                  String id = state.extra as String;
                  return BadDebtDetails(badDebtId: id);
                },
              ),
            ],
          ),
          
          // PIPELINE BRANCH
          StatefulShellBranch(
            navigatorKey: _pipelineNavigatorKey,
            routes: [
              GoRoute(
                name: AppRoutes.pipeline.name,
                path: AppRoutes.pipeline.path,
                builder: (context, state) => PipelineMainPage(),
              ),
            ],
          ),
          
          // TODOLIST BRANCH
          StatefulShellBranch(
            navigatorKey: _todolistNavigatorKey,
            routes: [
              GoRoute(
                name: AppRoutes.todolist.name,
                path: AppRoutes.todolist.path,
                builder: (context, state) => TodolistScreen(),
              ),
              GoRoute(
                name: AppRoutes.todolistArchive.name,
                path: '/todolist_archive',
                builder: (context, state) => TodolistArchiveScreen(),
              ),
            ],
          ),
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