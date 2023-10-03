import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/helper/string_format_helper.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_images.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/core/utils/url.dart';
import 'package:hyip_lab/data/controller/referral/referral_controller.dart';
import 'package:hyip_lab/data/repo/referral/referral_repo.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import 'package:hyip_lab/view/components/appbar/custom_appbar.dart';
import 'package:hyip_lab/view/components/custom_loader/custom_loader.dart';
import 'package:hyip_lab/view/components/no_data/no_data_widget.dart';
import 'package:hyip_lab/view/components/show_custom_snackbar.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({Key? key}) : super(key: key);

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {

  final ScrollController scrollController = ScrollController();

  void scrollListener(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(Get.find<ReferralController>().hasNext()){
        Get.find<ReferralController>().loadPaginationData();
      }
    }
  }

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ReferralRepo(apiClient: Get.find()));
    final controller = Get.put(ReferralController(referralRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.page = 0;
      controller.initData();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReferralController>(builder: (controller)=>SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar: const CustomAppBar(title: MyStrings.referral),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: Dimensions.space20),
                padding: const EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space15),
                decoration: BoxDecoration(color: MyColor.getCardBg(), borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 30, width: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: MyColor.getTextColor().withOpacity(0.04), shape: BoxShape.circle),
                          child: Image.asset(MyImages.referral.tr, color: Colors.grey, height: 15, width: 15),
                        ),
                        const SizedBox(width: Dimensions.space15),

                        Text(
                          MyStrings.referralLink.tr,
                          textAlign: TextAlign.left,
                          style: interRegularDefault.copyWith(color: MyColor.getTextColor()),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.space10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: DottedBorder(
                              color: MyColor.getTextColor().withOpacity(0.22),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    "${UrlContainer.domainUrl}?reference=${controller.referralRepo.apiClient.getCurrencyOrUsername(isCurrency: false)}",
                                    textAlign: TextAlign.start,
                                    style: interRegularSmall.copyWith(color: MyColor.getTextColor()),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: Dimensions.space20),

                        GestureDetector(
                          onTap: (){
                            Clipboard.setData(ClipboardData(text:  "${UrlContainer.domainUrl}?reference=${controller.referralRepo.apiClient.getCurrencyOrUsername(isCurrency: false)}"));
                            CustomSnackBar.showCustomSnackBar(errorList: [], msg: [MyStrings.copyLink], isError: false);
                          },
                          child: Icon(Icons.copy, color: MyColor.getPrimaryColor(), size: 20),
                        )
                      ],
                    ),
                  ],
                ),
              ),

              controller.isLoading?const Expanded(child:  CustomLoader()):
              controller.dataList.isEmpty?const Expanded(child: NoDataWidget()):Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.separated(
                      shrinkWrap: true,
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: controller.dataList.length+1,
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {

                        if(controller.dataList.length==index){
                          return controller.hasNext()?
                          const CustomLoader(isPagination: true,) : const SizedBox();
                        }

                        return Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                          decoration: BoxDecoration(
                              color: MyColor.getCardBg(),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 50, width: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: MyColor.getTextColor().withOpacity(0.04), borderRadius: BorderRadius.circular(10)
                                ),
                                child: Text(
                                  Converter.addLeadingZero(controller.dataList[index].level),
                                  textAlign: TextAlign.center,
                                  style: interRegularLarge.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(width: Dimensions.space10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(MyStrings.username.tr,
                                          style: interRegularDefault.copyWith(color: MyColor.getPrimaryColor(), fontWeight: FontWeight.w600),
                                        ),
                                        Text(MyStrings.level.tr,
                                          style: interRegularDefault.copyWith(color: MyColor.getPrimaryColor(), fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.dataList[index].username,
                                          style: interRegularDefault.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                         Converter.getTrailingExtension(int.tryParse(controller.dataList[index].level)??0),
                                          style: interRegularDefault.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: Dimensions.space5),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
