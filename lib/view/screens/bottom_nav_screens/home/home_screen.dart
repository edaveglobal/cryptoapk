import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/routes/route.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_images.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/util.dart';
import 'package:hyip_lab/data/controller/common/theme_controller.dart';
import 'package:hyip_lab/data/repo/dashboard_repo.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import 'package:hyip_lab/view/components/animated_widget/expanded_widget.dart';
import 'package:hyip_lab/view/components/bottom_Nav/bottom_nav.dart';
import 'package:hyip_lab/view/components/card/card_with_round_icon.dart';
import 'package:hyip_lab/view/components/custom_loader/custom_loader.dart';
import 'package:hyip_lab/view/components/will_pop_widget.dart';
import 'package:hyip_lab/view/screens/bottom_nav_screens/home/widgets/home_bottom_section.dart';
import 'package:hyip_lab/view/screens/bottom_nav_screens/home/widgets/home_top_section.dart';

import '../../../../data/controller/dashboard/dashboard_controller.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DashboardRepo(apiClient: Get.find()));
    final controller = Get.put(DashBoardController(dashboardRepo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadData();
    });
  }

  @override
  void dispose() {
    ThemeController themeController = ThemeController(sharedPreferences: Get.find());
    MyUtils.allScreensUtils(themeController.darkTheme);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.getScreenBgColor(),
            body: GetBuilder<DashBoardController>(
            builder: (controller) =>/*controller.isLoading? const CustomLoader(): */SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  const HomeTopSection(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: MyColor.getCardBg(),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: Dimensions.space20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CardWithRoundIcon(
                                    backgroundColor: MyColor.getScreenBgColor(),
                                    titleText: MyStrings.depositWalletBalance.tr,
                                    titleColor: MyColor.getTextColor(),
                                    trailColor: MyColor.getPrimaryColor(),
                                    trailText: controller.depositWalletBal,
                                    icon: MyImages.depositWallet,
                                    onPressed: (){
                                      Get.toNamed(RouteHelper.transactionHistoryScreen,arguments: MyStrings.depositWallet);
                                    },
                                  ),
                                ),
                                const SizedBox(width: Dimensions.space12),
                                Expanded(
                                  child: CardWithRoundIcon(
                                    backgroundColor: MyColor.getScreenBgColor(),
                                    titleText: MyStrings.interestWalletBalance.tr,
                                    titleColor: MyColor.getTextColor(),
                                    trailColor: MyColor.getPrimaryColor(),
                                    trailText: controller.interestWalletBal,
                                    icon: MyImages.interestWallet,
                                    onPressed: (){
                                      Get.toNamed(RouteHelper.transactionHistoryScreen,arguments: MyStrings.interestWallet);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        ExpandedSection(
                          duration: 800,
                          expand: controller.isExpand,
                          child: Column(
                            children: [
                              const SizedBox(height: Dimensions.space12),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: Dimensions.space12),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: CardWithRoundIcon(
                                          backgroundColor: MyColor.getScreenBgColor(),
                                          titleText: MyStrings.depositPending.tr,
                                          titleColor: MyColor.getTextColor(),
                                          trailColor: MyColor.getPrimaryColor(),
                                          trailText: controller.depositPending,
                                          icon: MyImages.pending,
                                          onPressed: (){
                                            Get.toNamed(RouteHelper.depositScreen);
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: Dimensions.space12),
                                      Expanded(
                                        child: CardWithRoundIcon(
                                          backgroundColor: MyColor.getScreenBgColor(),
                                          titleText: MyStrings.withdrawalPending.tr,
                                          icon: MyImages.pending,
                                          titleColor: MyColor.getTextColor(),
                                          trailText: controller.withdrawPending,
                                          onPressed: () => Get.toNamed(RouteHelper.withdrawHistoryScreen),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: Dimensions.space12),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: CardWithRoundIcon(
                                          backgroundColor: MyColor.getScreenBgColor(),
                                          titleText: MyStrings.totalDeposit.tr,
                                          titleColor: MyColor.getTextColor(),
                                          trailColor: MyColor.getPrimaryColor(),
                                          trailText: controller.totalDeposit,
                                          icon: MyImages.totalDeposit,
                                          onPressed: (){
                                            Get.toNamed(RouteHelper.depositScreen);
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: Dimensions.space12),
                                      Expanded(
                                        child: CardWithRoundIcon(
                                          backgroundColor: MyColor.getScreenBgColor(),
                                          titleText: MyStrings.totalWithdraw.tr,
                                          titleColor: MyColor.getTextColor(),
                                          trailColor: MyColor.getPrimaryColor(),
                                          trailText: controller.totalWithdraw,
                                          icon: MyImages.totalWithdraw,
                                          onPressed: (){
                                            Get.toNamed(RouteHelper.withdrawHistoryScreen);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: Dimensions.space12),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: CardWithRoundIcon(
                                          backgroundColor: MyColor.getScreenBgColor(),
                                          titleText: MyStrings.totalInvest.tr,
                                          titleColor: MyColor.getTextColor(),
                                          trailColor: MyColor.getPrimaryColor(),
                                          trailText: controller.totalInvest,
                                          icon: MyImages.totalInvest,
                                          onPressed: (){
                                            Get.toNamed(RouteHelper.investmentScreen);
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: Dimensions.space12),
                                      Expanded(
                                        child: CardWithRoundIcon(
                                            backgroundColor: MyColor.getScreenBgColor(),
                                            titleText: MyStrings.referralEarnings.tr,
                                            titleColor: MyColor.getTextColor(),
                                            trailColor: MyColor.getPrimaryColor(),
                                            trailText: controller.referralEarnings,
                                            icon: MyImages.referralEarnings,
                                            onPressed: (){
                                              Get.toNamed(RouteHelper.referralScreen);
                                            },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimensions.space15),
                        InkWell(
                          onTap: (){
                            controller.changeVisibility();
                          },
                          child: SizedBox(
                            height: 30, width: 30,
                            child: Icon(controller.isExpand ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: MyColor.getTextColor().withOpacity(0.5), size: 20),
                          )
                        ),
                        const SizedBox(height: Dimensions.space15),
                        const HomeBottomSection()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: const CustomBottomNav(currentIndex: 0),
        )
      ),
    );
  }
}
