
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hyip_lab/core/utils/my_color.dart';

class MyUtils{

  static dynamic getShadow(){
    return  [
      BoxShadow(
          blurRadius: 15.0,
          offset: const Offset(0, 25),
          color: Colors.grey.shade500.withOpacity(0.6),
          spreadRadius: -35.0),
    ];
  }

  static dynamic getBottomSheetShadow(){
    return  [
      BoxShadow(
        // color: MyColor.screenBgColor,
        color: Colors.grey.shade400.withOpacity(0.08),
        spreadRadius: 3,
        blurRadius: 4,
        offset: const Offset(0, 3), // changes position of shadow
      ),
    ];
  }

  static dynamic getCardShadow(){
    return  [
      BoxShadow(
        color: Colors.grey.shade400.withOpacity(0.05),
        spreadRadius: 2,
        blurRadius: 2,
        offset: const Offset(0, 3),
      ),
    ];
  }

  static void splashScreenUtils(){
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColor.primaryColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: MyColor.primaryColor,
      systemNavigationBarIconBrightness: Brightness.light)
    );
  }

  static void allScreensUtils(bool isDark){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyColor.getPrimaryColor(),
        statusBarIconBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: MyColor.getScreenBgColor(),
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark
      )
    );
  }
}