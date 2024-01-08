
import 'package:beamer/beamer.dart';
import 'app_route_name.dart';

class RouteDelegator {
  final routeDelegate = BeamerDelegate(
      initialPath: AppRouteName.home,
      locationBuilder: RoutesLocationBuilder(
          routes: {AppRouteName.home: (context, state, data) {}}));
}
