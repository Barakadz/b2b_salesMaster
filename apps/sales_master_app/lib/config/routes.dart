import 'package:go_router/go_router.dart';
import 'package:sales_master_app/views/login_screen.dart';
import 'package:sales_master_app/views/otp_screen.dart';

class AppRoutes {
  static const login = _Route(path: '/login', name: 'login');
  static const otpValidation = _Route(path: '/otpValidation', name: 'otp');

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
    ],
  );
}

class _Route {
  final String path;
  final String name;
  const _Route({required this.path, required this.name});
}
