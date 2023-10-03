import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/helper/date_converter.dart';
import 'package:hyip_lab/core/helper/string_format_helper.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/data/controller/deposit_controller/deposit_controller.dart';
import 'package:hyip_lab/data/repo/deposit_repo.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import 'package:hyip_lab/view/components/bottom-sheet/bottom_sheet_bar.dart';
import 'package:hyip_lab/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:hyip_lab/view/components/custom_loader/custom_loader.dart';
import 'package:hyip_lab/view/components/no_data_found_screen.dart';
import 'package:hyip_lab/view/components/text/header_text.dart';
import 'package:hyip_lab/view/screens/deposit/deposit-history/widget/custom_deposit_card.dart';
import 'package:hyip_lab/view/screens/deposit/deposit-history/widget/deposit_history_top.dart';
import 'package:hyip_lab/view/screens/deposit/deposit_method/add_deposit_method.dart';

class DepositHistoryScreen extends StatefulWidget {
  const DepositHistoryScreen({Key? key}) : super(key: key);

  @override
  State<DepositHistoryScreen> createState() => _DepositHistoryScreenState();
}

class _DepositHistoryScreenState extends State<DepositHistoryScreen> {

  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<DepositController>().fetchNewList();
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if(Get.find<DepositController>().hasNext()){
        fetchData();
      }

    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DepositRepo(apiClient: Get.find()));
    final controller = Get.put(DepositController(depositRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.beforeInitLoadData();
      scrollController.addListener(_scrollListener);
    });

  }

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<DepositController>(
        builder: (controller) => SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.getScreenBgColor(),
          appBar: AppBar(
            title: Text(MyStrings.depositHistory.tr, style: interRegularLarge.copyWith(color: MyColor.getAppbarTitleColor())),
            backgroundColor: MyColor.getAppbarBgColor(),
            elevation: 0,
            leading: IconButton(
                onPressed: (){
                  Get.back();
                },
                icon: Icon(Icons.arrow_back, color: MyColor.getAppbarTitleColor(), size: 20),
              ),
            actions: [
              GestureDetector(
                onTap: (){
                  CustomBottomSheet(
                      backgroundColor: MyColor.getCardBg(),
                      isNeedMargin: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          BottomSheetBar(),
                          SizedBox(height: Dimensions.space15),
                          HeaderText(text: MyStrings.depositMoney, textAlign: TextAlign.center, textStyle: interRegularLarge),
                          SizedBox(height: Dimensions.space30),
                          AddDepositMethod(),
                        ],
                      )
                  ).customBottomSheet(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: Dimensions.space20),
                  height: 30, width: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: MyColor.colorGrey.withOpacity(0.2), shape: BoxShape.circle),
                  child: Icon(Icons.add, color: MyColor.getSelectedIconColor(), size: 15),
                ),
              ),

              GestureDetector(
                onTap: () {
                 controller.changeIsPress();
                },
                child: Container(
                  margin: const EdgeInsets.only(right: Dimensions.space15),
                  height: 30, width: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: MyColor.colorGrey.withOpacity(0.2), shape: BoxShape.circle),
                  child: Icon(controller.isSearch ? Icons.clear : Icons.search, color: MyColor.getSelectedIconColor(), size: 15),
                ),
              ),
            ],
          ),

          body: controller.isLoading ? Center(
              child: CircularProgressIndicator(color: MyColor.getPrimaryColor()),
            ) : Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: controller.isSearch,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        DepositHistoryTop(),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),

                  Expanded(
                    child: controller.depositList.isEmpty && controller.searchLoading == false ? NoDataFoundScreen(title:MyStrings.noDepositFound,height:controller.isSearch?0.75:0.8) :
                    controller.searchLoading ? const Center(
                      child: CustomLoader(),
                    ) :
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.separated(
                        shrinkWrap: true,
                        controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: controller.depositList.length + 1,
                        separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                        itemBuilder: (context, index){
                          if(controller.depositList.length == index){
                            return controller.hasNext() ? const CustomLoader(isPagination:true) : const SizedBox();
                          }

                          return CustomDepositCard(
                              trxData: controller.depositList[index].trx ?? "",
                              initiatedData: DateConverter.isoStringToLocalDateOnly(controller.depositList[index].createdAt ?? ""),
                              gatewayData: controller.depositList[index].gateway?.name ?? "",
                              conversionData: "${Converter.twoDecimalPlaceFixedWithoutRounding(controller.depositList[index].finalAmo ?? "")} ${controller.depositList[index].methodCurrency}",
                              amountConversion: "1 ${controller.currency} = ${Converter.twoDecimalPlaceFixedWithoutRounding(controller.depositList[index].rate ?? "")} ${controller.depositList[index].methodCurrency}",
                              amountData: "${double.parse(Converter.twoDecimalPlaceFixedWithoutRounding(controller.depositList[index].amount ?? "")) + double.parse(Converter.twoDecimalPlaceFixedWithoutRounding(controller.depositList[index].charge ?? ""))} ${controller.currency}",
                              statusData: controller.getStatus(index),
                              statusColor: controller.getStatusColor(index),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
