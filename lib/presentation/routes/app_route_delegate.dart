import 'package:beamer/beamer.dart';
import 'package:black_pearl/presentation/dashboard/home/screen/home_menu_upload_screen.dart';
import 'package:black_pearl/presentation/dashboard/list/screen/list_detail_screen.dart';
import 'package:black_pearl/presentation/dashboard/screen/dashboard_screen.dart';
import 'package:black_pearl/presentation/login/screen/login_screen.dart';
import 'package:black_pearl/presentation/login/screen/login_verification_sreen.dart';
import 'app_route_name.dart';

class RouteDelegator {
  final routeDelegate = BeamerDelegate(
    initialPath: AppRouteName.login,
    locationBuilder: RoutesLocationBuilder(
      routes: {
        AppRouteName.login: (context, state, data) {
          return const LoginScreen();
        },
        AppRouteName.loginVerification: (context, state, data) {
          return const LoginVerificationScreen();
        },
        AppRouteName.home: (context, state, data) {
          return const DashboardScreen();
        },
        AppRouteName.homeMenu: (context, state, data) {
          return const HomeMenuScreen();
        },
        AppRouteName.listDetails: (context, state, data) {
          return ListDetailScreen(url: data as String);
        },
      },
    ),
  );
}
