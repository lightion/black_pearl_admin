import 'package:beamer/beamer.dart';
import 'package:black_pearl/presentation/login/screen/login_screen.dart';
import 'app_route_name.dart';

class RouteDelegator {
  final routeDelegate = BeamerDelegate(
    initialPath: AppRouteName.login,
    locationBuilder: RoutesLocationBuilder(
      routes: {
        AppRouteName.login: (context, state, data) {
          return const LoginScreen();
        },
      },
    ),
  );
}
