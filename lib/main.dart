import 'package:beamer/beamer.dart';
import 'package:black_pearl/di/injector.dart';
import 'package:black_pearl/presentation/routes/app_route_delegate.dart';
import 'package:core/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  getItInit();
  runApp(BlackPearlApp());
}

class BlackPearlApp extends StatelessWidget {
  BlackPearlApp({super.key});

  final _routeDelegate = RouteDelegator().routeDelegate;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(theme).getThemeData(),
      routerDelegate: _routeDelegate,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: _routeDelegate,
      ),
    );
  }
}
