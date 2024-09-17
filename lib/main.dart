import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aayush_machine_test/core/navigation/navigation_service.dart';
import 'package:aayush_machine_test/values/export.dart';
import 'package:aayush_machine_test/values/string_constants.dart';
import 'package:aayush_machine_test/values/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'core/db/app_db.dart';
import 'core/locator.dart';
import 'core/navigation/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();

  Hive
    ..init(appDocumentDir.path);

  await setupLocator();
  await locator.isReady<AppDB>();

  //await Firebase.initializeApp();

  // Fixing App Orientation.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runZonedGuarded(() {
      runApp(MyApp());
    }, (Object error, StackTrace stackTrace) {
      /// for debug:
      if (!kReleaseMode) {
        debugPrint('[Error]: ${error.toString()}');
        debugPrint('[Stacktrace]: ${stackTrace.toString()}');
      }
    }),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context,widget) => MaterialApp(
        title: StringConstant.appName,
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        routes: Routes.route(),
        onGenerateRoute: Routes.onGenerateRoute,
        onUnknownRoute: Routes.onUnknownRoute,
        initialRoute: RouteName.root,
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
