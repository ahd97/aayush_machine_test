import 'package:flutter/material.dart';
import 'package:aayush_machine_test/ui/auth/login/login_page.dart';
import 'package:aayush_machine_test/ui/home/home_page.dart';
import 'package:aayush_machine_test/ui/splash.dart';

abstract class RouteName {
  static const String root = "splash";
  static const String loginPage = "/login";
  static const String signUpPage = "/signUp";
  static const String homePage = "/home";
  static const String webViewPage = "/webView";
}

class Routes {
  static dynamic route() {
    return {
      RouteName.root: (BuildContext context) => Splash(),
    };
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    debugPrint("Route Name ${settings.name} args $args ");
    var page;
    switch (settings.name) {
      case RouteName.root:
        page = Splash();
        break;

      case RouteName.loginPage:
        page = LoginPage();
        break;

      case RouteName.homePage:
        page = HomePage();
        break;
    }
    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }

  static Route onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(settings.name ?? ''),
          centerTitle: true,
        ),
        body: Center(
          child: Text('${settings.name!.split} Coming soon..'),
        ),
      ),
    );
  }
}
