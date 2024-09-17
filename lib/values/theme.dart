import 'package:flutter/material.dart';
import 'package:aayush_machine_test/values/colors.dart';
import 'package:aayush_machine_test/values/style.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: AppColor.primaryColor,
  hintColor: AppColor.brownColor,
  scaffoldBackgroundColor: const Color(0xfff9f9f9),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: AppBarTheme(
    color: AppColor.primaryColor,
    titleTextStyle: textBold,
    iconTheme: IconThemeData(color: AppColor.white, size: 30.0),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: AppColor.textBackgroundColor,
    disabledColor: AppColor.textBackgroundColor,
  ),
);
