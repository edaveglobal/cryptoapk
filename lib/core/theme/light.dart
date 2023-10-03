import 'package:flutter/material.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/style.dart';

ThemeData light = ThemeData(
    fontFamily: 'Inter',
    primaryColor: MyColor.lPrimaryColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: MyColor.colorGrey.withOpacity(0.3),
    hintColor: MyColor.hintTextColor,
    buttonTheme: ButtonThemeData(
      buttonColor: MyColor.getPrimaryColor(),
    ),
    cardColor: MyColor.cardBgColor,
    appBarTheme: AppBarTheme(
        backgroundColor: MyColor.lPrimaryColor,
        elevation: 0,
        titleTextStyle: interRegularLarge.copyWith(color: MyColor.colorWhite),
        iconTheme: const IconThemeData(
            size: 20,
            color: MyColor.colorWhite
        )
    ),
    checkboxTheme: CheckboxThemeData(
     checkColor: MaterialStateProperty.all(MyColor.colorBlack),
     fillColor: MaterialStateProperty.all(MyColor.primaryColor),

));