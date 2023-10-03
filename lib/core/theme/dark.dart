
import 'package:flutter/material.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/style.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Inter',
  primaryColor: MyColor.getPrimaryColor(),
  brightness: Brightness.light,
  scaffoldBackgroundColor: MyColor.getScreenBgColor(),
  hintColor: MyColor.hintTextColor,
  focusColor: MyColor.fieldEnableBorderColor,
  buttonTheme: ButtonThemeData(
    buttonColor: MyColor.getPrimaryColor(),
  ),
  cardColor: MyColor.cardBgColor,
  appBarTheme: AppBarTheme(
    backgroundColor: MyColor.getAppbarBgColor(),
    elevation: 0,
    titleTextStyle: interRegularLarge.copyWith(color: MyColor.colorWhite),
    iconTheme: const IconThemeData(
      size: 20,
      color: MyColor.colorWhite
    )
  ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(MyColor.colorWhite),
      fillColor: MaterialStateProperty.all(MyColor.colorWhite),
      overlayColor: MaterialStateProperty.all(MyColor.greenSuccessColor),
    ));