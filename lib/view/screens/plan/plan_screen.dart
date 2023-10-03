import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/routes/route.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/data/controller/plan/plan_controller.dart';
import 'package:hyip_lab/data/repo/plan/plan_repo.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import 'package:hyip_lab/view/components/appbar/custom_appbar.dart';
import 'package:hyip_lab/view/components/bottom_Nav/bottom_nav.dart';
import 'package:hyip_lab/view/components/custom_loader/custom_loader.dart';
import 'package:hyip_lab/view/components/will_pop_widget.dart';
import 'package:hyip_lab/view/screens/plan/widget/plan_card.dart';

class PlanScreen extends StatefulWidget {

  const PlanScreen({Key? key}) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(PlanRepo(apiClient: Get.find()));
    final controller = Get.put(PlanController(planRepo: Get.find()));

    super.initState();
    pageController = PageController(initialPage:0, viewportFraction: .8);
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       controller.getAllPackageData();
       controller.planList.clear();
     });
  }

  late PageController pageController;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<PlanController>(builder: (controller)=>WillPopWidget(
      nextRoute: RouteHelper.homeScreen,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.getScreenBgColor(),
          appBar: CustomAppBar(isShowBackBtn: false, title: MyStrings.investmentPlan.tr, bgColor: MyColor.getAppbarBgColor(),),
          body: controller.isLoading? const CustomLoader() : SingleChildScrollView(
            child: SingleChildScrollView(
              padding: Dimensions.screenPaddingHV,
              child: Column(
                children: [
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.planList.length,
                      separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                      itemBuilder: (context, index){
                        return PlanCard(index: index);
                      }
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
        ),
      ),
    ));
  }
}
