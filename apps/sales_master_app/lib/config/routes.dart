import 'package:go_router/go_router.dart';
import 'package:sales_master_app/views/client_details_screen.dart';
import 'package:sales_master_app/views/login_screen.dart';
import 'package:sales_master_app/views/notification_screen.dart';
import 'package:sales_master_app/views/otp_screen.dart';

class AppRoutes {
  static const login = _Route(path: '/login', name: 'login');
  static const otpValidation = _Route(path: '/otpValidation', name: 'otp');
  static const notification =
      _Route(path: "/notifications", name: "notifications");
  static const clientDetails =
      _Route(path: '/clientDetails', name: 'clientDetails');

  static final router = GoRouter(
    initialLocation: AppRoutes.login.path,
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
          builder: (context, state) => NotificationScreen()),
      GoRoute(
          name: AppRoutes.clientDetails.name,
          path: AppRoutes.clientDetails.path,
          builder: (context, state) => ClientDetailsScreen())
    ],
  );
}

class _Route {
  final String path;
  final String name;
  const _Route({required this.path, required this.name});
}
