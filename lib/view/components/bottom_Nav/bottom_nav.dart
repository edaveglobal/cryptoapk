import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/routes/route.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_images.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/data/controller/common/theme_controller.dart';
import 'package:hyip_lab/data/controller/localization/localization_controller.dart';
import 'package:hyip_lab/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:hyip_lab/view/screens/bottom_nav_screens/history/history_bottom_sheet_items.dart';

class CustomBottomNav extends StatefulWidget {
  final int currentIndex;
  const CustomBottomNav({Key? key,required this.currentIndex}) : super(key: key);

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {

  var bottomNavIndex = 0;//default index of a first screen

  List<String> iconList = [
    MyImages.home,
    MyImages.planIcon,
    MyImages.history1,
    MyImages.menu
  ];

  final textList = [
    MyStrings.home,
    MyStrings.plan,
    MyStrings.history,
    MyStrings.menu
  ];

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    Get.put(ThemeController(sharedPreferences: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (theme){
      return GetBuilder<LocalizationController>(builder: (languageController)=>AnimatedBottomNavigationBar.builder(
        height: 65,
        elevation: 10,
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconList[index],
                height: 22, width: 22,
                color: isActive ? MyColor.primaryColor : MyColor.getUnselectedIconColor(),
              ),
              const SizedBox(height: Dimensions.space5),
              Text(
                textList[index].tr,
                style: interRegularSmall.copyWith(color: isActive ? MyColor.primaryColor : MyColor.getUnselectedIconColor()),
              )
            ],
          );
        },
        backgroundColor: MyColor.getBottomNavColor(),
        splashColor: MyColor.getScreenBgColor(),
        gapLocation: GapLocation.none,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        onTap: (index) {
          _onTap(index);
        },
        activeIndex: bottomNavIndex,
      ));
    });
  }


  void _onTap(int index) {

    if (index == 0) {
      if (!(widget.currentIndex == 0)) {
        Get.toNamed(RouteHelper.homeScreen);
      }
    }

    else if (index == 1) {
      if (!(widget.currentIndex == 2)) {
        Get.toNamed(RouteHelper.planScreen);
      }
    }

    else if (index == 2) {
      if (!(widget.currentIndex == 2)) {
        CustomBottomSheet(
            isNeedMargin: true,
            backgroundColor: MyColor.getCardBg(),
            child: const HistoryBottomSheetItems()
        ).customBottomSheet(context);
      }
    }

    else if (index == 3) {
      if (!(widget.currentIndex == 3)) {
        Get.toNamed(RouteHelper.menuScreen);
      }
    }


  }
}




  


