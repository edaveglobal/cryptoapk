import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/core/utils/util.dart';
import 'package:hyip_lab/data/controller/common/theme_controller.dart';
import 'package:hyip_lab/data/controller/withdraw/withdraw_history_controller.dart';
import 'package:hyip_lab/data/repo/withdraw/withdraw_repo.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import 'package:hyip_lab/view/components/custom_no_data_found_class.dart';
import 'package:hyip_lab/view/components/bottom-sheet/bottom_sheet_bar.dart';
import 'package:hyip_lab/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:hyip_lab/view/components/no_data/no_data_widget.dart';
import 'package:hyip_lab/view/components/text-field/search_text_field.dart';
import 'package:hyip_lab/view/components/text/header_text.dart';
import 'package:hyip_lab/view/screens/withdraw/withdraw_log/widget/list_item.dart';
import 'package:hyip_lab/view/screens/withdraw/withdraw_money/add_withdraw_method.dart';

class WithdrawHistoryScreen extends StatefulWidget {
  const WithdrawHistoryScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawHistoryScreen> createState() => _WithdrawHistoryScreenState();
}

class _WithdrawHistoryScreenState extends State<WithdrawHistoryScreen> {

  @override
  void dispose() {
    ThemeController themeController = ThemeController(sharedPreferences: Get.find());
    MyUtils.allScreensUtils(themeController.darkTheme);

    Get.find<WithdrawHistoryController>().clearData();
    super.dispose();
  }

  @override
  void initState() {
    ThemeController themeController = ThemeController(sharedPreferences: Get.find());
    MyUtils.allScreensUtils(themeController.darkTheme);

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(WithdrawRepo(apiClient: Get.find()));
    Get.put(WithdrawHistoryController(repo: Get.find(),));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<WithdrawHistoryController>().initData();
      themeController.darkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawHistoryController>(
        builder: (controller) => SafeArea(child: Scaffold(
          backgroundColor: MyColor.getScreenBgColor(),
          appBar: AppBar(
            backgroundColor: MyColor.getAppbarBgColor(),
            elevation: 0,
            title: Text(MyStrings.withdrawHistory.tr, style: interRegularLarge.copyWith(color: MyColor.getAppbarTitleColor())),
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back, color: MyColor.getAppbarTitleColor(), size: 20)
            ),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onTap: (){
                      CustomBottomSheet(
                          backgroundColor: MyColor.getCardBg(),
                          isNeedMargin: true,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              BottomSheetBar(),
                              SizedBox(height: Dimensions.space15),
                              HeaderText(text: MyStrings.withdrawMoney, textAlign: TextAlign.center, textStyle: interRegularLarge),
                              SizedBox(height: Dimensions.space30),
                              AddWithdrawMethod(),
                            ],
                          )
                      ).customBottomSheet(context);
                    },
                    child: Container(
                      height: 30, width: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: MyColor.colorGrey.withOpacity(0.1),
                          shape: BoxShape.circle
                      ),
                      child: Icon(Icons.add, color: MyColor.getSelectedIconColor(), size: 15),
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(right: Dimensions.space15),
                child: GestureDetector(
                  onTap: (){
                    controller.changeSearchStatus();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 30, width: 30,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: MyColor.colorGrey.withOpacity(0.1)),
                    child: Icon(controller.isSearch ? Icons.clear : Icons.search, color: MyColor.getSelectedIconColor(), size: 15),
                  ),
                ),
              ),
            ],
          ),
          body: SizedBox(
            width: Get.width,
            height: Get.height,
            child: controller.isLoading? Center(
              child: CircularProgressIndicator(color: MyColor.getPrimaryColor()),
            ): Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.space20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: Dimensions.space15, right: Dimensions.space15),
                    child: Visibility(
                      visible: controller.isSearch,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal:  Dimensions.space15,vertical: Dimensions.space15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.defaultRadius1),
                          color: MyColor.getCardBg(),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(MyStrings.transactionNo, style: interRegularSmall.copyWith(color: MyColor.getLabelTextColor(), fontWeight: FontWeight.w500)),
                                      const SizedBox(height: Dimensions.space5),
                                      SizedBox(
                                        height: 45,
                                        width: MediaQuery.of(context).size.width,
                                        child: SearchTextField(
                                            needOutlineBorder: true,
                                            controller: controller.searchController,
                                            textInputType: TextInputType.text,
                                            onChanged: (value){

                                            })
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: Dimensions.space15),

                                InkWell(
                                  onTap: () {
                                    controller.filterData();
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(4),
                                      color: MyColor.getPrimaryColor(),
                                    ),
                                    child: Icon(Icons.search_outlined, color:  MyColor.getButtonTextColor(), size: 18),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: Dimensions.space20)
                          ],
                        ),
                      ),
                    ),
                  ),

                  controller.historyList.isEmpty && controller.filterLoading == false ? const Expanded(
                      child: NoDataWidget(title: MyStrings.noWithdrawFound)
                  ): controller.filterLoading ? const Center(
                    child: CircularProgressIndicator(color: MyColor.primaryColor),
                  ) : const WithdrawListItem()
                ],
              ),
            ),
          ),
        ))
    );
  }
}
