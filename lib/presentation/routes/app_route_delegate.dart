import 'package:beamer/beamer.dart';
import 'package:black_pearl/presentation/dashboard/home/screen/home_menu_upload_screen.dart';
import 'package:black_pearl/presentation/dashboard/list/screen/list_detail_screen.dart';
import 'package:black_pearl/presentation/dashboard/profile/screen/profile_edit_screen.dart';
import 'package:black_pearl/presentation/dashboard/screen/dashboard_screen.dart';
import 'package:black_pearl/presentation/login/screen/login_screen.dart';
import 'package:black_pearl/presentation/login/screen/login_verification_sreen.dart';
import 'package:black_pearl/presentation/register/screen/register_screen.dart';
import 'package:core/enums/menu_type.dart';
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
          return LoginVerificationScreen(
            data: data as Map<String, String>,
          );
        },
        AppRouteName.home: (context, state, data) {
          return const DashboardScreen();
        },
        AppRouteName.homeMenu: (context, state, data) {
          return HomeMenuScreen(
            menuType: data as MenuType,
          );
        },
        AppRouteName.listDetails: (context, state, data) {
          return ListDetailScreen(url: data as String);
        },
        AppRouteName.profileEdit: (context, state, data) {
          return const ProfileEditScreen();
        },
        AppRouteName.register: (context, state, data) {
          return RegisterScreen(mobileNumber: data as String);
        }
      },
    ),
  );
}
