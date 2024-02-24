import 'package:beamer/beamer.dart';
import 'package:black_pearl/di/injector.dart';
import 'package:black_pearl/firebase_options.dart';
import 'package:black_pearl/presentation/routes/app_route_delegate.dart';
import 'package:core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  if (Firebase.apps.isEmpty) {
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).whenComplete(() {
      getItInit();
      getIt.allReady().then((value) => {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]).then((value) => runApp(BlackPearlApp())).then((value) {
              FlutterNativeSplash.remove();
            })
          });
    });
  }
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
