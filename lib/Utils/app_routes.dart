
import 'package:flutter_ui_ux_portfolio/Utils/route_name_utils.dart';
import 'package:flutter_ui_ux_portfolio/pages/error_page.dart';
import 'package:flutter_ui_ux_portfolio/pages/home_page.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: RoutePaths.home,
        name: RouteNames.home,
        builder: (context, state) => const HomePage(),
      ),
    ],
    
    initialLocation: '/',
    errorBuilder: (context, state) => ErrorPage(
      errorMessage: state.error.toString(),
      message: '',
    ),
    debugLogDiagnostics: true,
  );
}
