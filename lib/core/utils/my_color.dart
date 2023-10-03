import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/data/controller/common/theme_controller.dart';

class MyColor{

  static const Color primaryColor = Color(0xffCCA353);

  static const Color backgroundColor =  Color(0xff0D222B);
  static const Color splashBgColor = primaryColor;
  static const Color appBarColor = Color(0xff192D36);

  static const Color fieldEnableBorderColor = primaryColor;
  static const Color fieldDisableBorderColor = Color(0xff2C3F47);
  static const Color fieldFillColor = Color(0xff22353E);

  /// card color
  static const Color cardPrimaryColor = Color(0xff0D222B);
  static const Color cardSecondaryColor = Color(0xff2C3F47);
  static const Color cardBorderColor = Color(0xff2C3F47);
  static const Color cardBgColor = Color(0xff192D36);

  /// text color
  static const Color primaryTextColor = Color(0xffffffff);
  static const Color secondaryTextColor = primaryColor;
  static const Color smallTextColor = Color(0xffE7E9EA);
  static const Color labelTextColor = Color(0xffB8BEC1);
  static const Color hintTextColor =  Color(0xff44555B);

  static const Color colorWhite = Color(0xffFFFFFF);
  static const Color colorBlack = Color(0xff262626);
  static const Color colorGrey = Color(0xff777777);
  static const Color transparentColor = Colors.transparent;

  /// bottom navbar
  static const Color bottomNavBgColor = Color(0xff233D48);
  static const Color borderColor =Color(0xff2C3F47);

  /// shimmer color
  static const Color shimmerBaseColor=Color(0xFF2A2E38);
  static const Color shimmerSplashColor=Color(0xFF52575C);
  static const Color red= Color(0xFFD92027);
  static const Color green= Color(0xFF28C76F);


  // light theme color
  static const Color lScreenBgColor1 = Color(0xfff5f6fa);
  //static const Color lScreenBgColor1 = Color(0xffF9F9F9);
  //static const Color lScreenBgColor = Color(0xffF9F9F9);
  static const Color lScreenBgColor = Color(0xffE7E9EA);
  static const Color lTextColor = Color(0xff2A3962);
  static const Color lPrimaryColor = Color(0xff1F2B3A);


  /// set color for theme

  static Color getLabelTextColor(){
    return Get.find<ThemeController>().darkTheme ? labelTextColor : lTextColor.withOpacity(0.6);
  }

  static Color getInputTextColor(){
    return Get.find<ThemeController>().darkTheme ? colorWhite : colorBlack;
  }

  static Color getHintTextColor(){
    return Get.find<ThemeController>().darkTheme ? hintTextColor : colorBlack;
  }

  static Color getButtonColor(){
    return  primaryColor ;
  }

  static Color getAppbarTitleColor(){
    return Get.find<ThemeController>().darkTheme ? colorWhite : lPrimaryColor;
  }

  static Color getButtonTextColor(){
    return Get.find<ThemeController>().darkTheme ? colorBlack : colorWhite;
  }

  static Color getPrimaryColor(){
    return  primaryColor ;
  }

  static Color getAppbarBgColor() {
    return Get.find<ThemeController>().darkTheme ? appBarColor : colorWhite;
  }

  static Color getScreenBgColor(){
    return Get.find<ThemeController>().darkTheme ? backgroundColor : lScreenBgColor1;
  }

  static Color getScreenBgColor1(){
    return Get.find<ThemeController>().darkTheme ? backgroundColor : colorWhite;
  }

  static Color getCardBg(){
    return Get.find<ThemeController>().darkTheme ? cardBgColor : colorWhite;
  }

  static Color getBottomNavBg(){
    return Get.find<ThemeController>().darkTheme ? bottomNavBgColor : primaryColor;
  }

  static Color getBottomNavIconColor(){
    return Get.find<ThemeController>().darkTheme ? colorWhite : colorGrey;
  }

  static Color getBottomNavSelectedIconColor(){
    return Get.find<ThemeController>().darkTheme ? primaryColor : colorWhite;
  }

  static Color getTextFieldTextColor(){
    return Get.find<ThemeController>().darkTheme ? colorWhite : lPrimaryColor;
  }

  static Color getTextFieldLabelColor(){
    return Get.find<ThemeController>().darkTheme ? labelTextColor : lTextColor;
  }

  static Color getTextColor(){
    return Get.find<ThemeController>().darkTheme ? colorWhite : colorBlack;
  }

  static Color getTextColor1(){
    return Get.find<ThemeController>().darkTheme ? Colors.white.withOpacity(0.5) : lTextColor;
  }

  static Color getTextFieldBg(){
    return Get.find<ThemeController>().darkTheme ? transparentColor : transparentColor;
  }

  static Color getTextFieldHintColor(){
    return Get.find<ThemeController>().darkTheme ? hintTextColor : colorGrey;
  }

  static Color getPrimaryTextColor(){
    return Get.find<ThemeController>().darkTheme ? colorWhite : colorBlack;
  }

  static Color getSecondaryTextColor(){
    return Get.find<ThemeController>().darkTheme ? colorWhite.withOpacity(0.8) : colorBlack.withOpacity(0.8);
  }

  static Color getDialogBg(){
    return Get.find<ThemeController>().darkTheme ? cardBgColor : colorWhite;
  }

  static Color getStatusColor(){
    return Get.find<ThemeController>().darkTheme ? primaryColor : lPrimaryColor;
  }

  static Color getFieldDisableBorderColor(){
    return Get.find<ThemeController>().darkTheme ? fieldDisableBorderColor : colorGrey.withOpacity(0.3);
  }

  static Color getFieldEnableBorderColor(){
    return Get.find<ThemeController>().darkTheme ? primaryColor : lPrimaryColor;
  }

  static Color getTextColor2(){
    return Get.find<ThemeController>().darkTheme ? colorWhite : colorGrey;
  }

  static Color getTextColor3(){
    return Get.find<ThemeController>().darkTheme ? getLabelTextColor() : getLabelTextColor();
  }

  static Color getBottomNavColor(){
    return Get.find<ThemeController>().darkTheme ? bottomNavBgColor : colorWhite;
  }

  static Color getUnselectedIconColor(){
    return Get.find<ThemeController>().darkTheme ? colorWhite : colorGrey.withOpacity(0.6);
  }

  static Color getSelectedIconColor(){
    return Get.find<ThemeController>().darkTheme ? getTextColor() : getTextColor();
  }

  static Color getPendingStatueColor(){
    return Get.find<ThemeController>().darkTheme ? Colors.grey : Colors.orange;
  }

  static Color getBorderColor(){
    return Get.find<ThemeController>().darkTheme ? Colors.grey.withOpacity(.3) : Colors.grey.withOpacity(.3);
  }

  static const Color pendingColor = Color(0xFFfcb44f);
  static const Color highPriorityPurpleColor = Color(0xFF7367F0);
  static const Color bgColorLight = Color(0xFFf2f2f2);
  static const Color closeRedColor = Color(0xFFEA5455);
  static const Color greenSuccessColor = greenP;
  static const Color redCancelTextColor = Color(0xFFF93E2C);
  static const Color greenP = Color(0xFF28C76F);

}
