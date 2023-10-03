import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/util.dart';
import 'package:hyip_lab/data/controller/common/theme_controller.dart';
import 'package:hyip_lab/data/controller/faq_controller/faq_controller.dart';
import 'package:hyip_lab/data/repo/faq_repo/faq_repo.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import 'package:hyip_lab/view/components/appbar/custom_appbar.dart';
import 'package:hyip_lab/view/components/custom_loader/custom_loader.dart';
import 'package:hyip_lab/view/screens/faq/faq_widget.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {

  @override
  void initState() {
    ThemeController themeController = Get.put(ThemeController(sharedPreferences: Get.find()));
    MyUtils.allScreensUtils(themeController.darkTheme);
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FaqRepo(apiClient: Get.find()));
    final controller = Get.put(FaqController(faqRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar: CustomAppBar(isShowBackBtn: true, title: MyStrings.faq.tr, bgColor: MyColor.getAppbarBgColor()),
        body: GetBuilder<FaqController>(
          builder: (controller) => controller.isLoading? const CustomLoader():
          SingleChildScrollView(
            padding: Dimensions.screenPaddingHV,
            physics: const BouncingScrollPhysics(),
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.faqList.length,
              separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
              itemBuilder: (context, index) => FaqListItem(
                  answer: (controller.faqList[index].dataValues?.answer??'').tr,
                  question:  (controller.faqList[index].dataValues?.question??'').tr,
                  index: index,
                  press: (){
                    controller.changeSelectedIndex(index);
                  },
                  selectedIndex: controller.selectedIndex
              ),
              ),
            ),
          )
      ),
    );
  }
}
