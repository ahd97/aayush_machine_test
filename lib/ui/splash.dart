import 'dart:async';

import 'package:flutter/material.dart';
import 'package:aayush_machine_test/core/db/app_db.dart';
import 'package:aayush_machine_test/core/navigation/navigation_service.dart';
import 'package:aayush_machine_test/core/navigation/routes.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  initState() {
    initSetting();
    super.initState();
  }

  Future<void> initSetting() async {
    //PushNotificationsManager().init();
    Timer(Duration(seconds: 2), () {
      if (!appDB.isLogin)
        navigator.pushReplacementNamed(RouteName.loginPage);
      else {
        navigator.pushReplacementNamed(RouteName.homePage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: FlutterLogo(),
      ),
    );
  }
}
