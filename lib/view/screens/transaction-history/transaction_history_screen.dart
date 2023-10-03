import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/helper/date_converter.dart';
import 'package:hyip_lab/core/helper/string_format_helper.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_images.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/data/controller/account/transaction_history_controller.dart';
import 'package:hyip_lab/data/repo/account/transaction_log_repo.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import 'package:hyip_lab/view/components/custom_loader/custom_loader.dart';
import 'package:hyip_lab/view/components/no_data/no_data_widget.dart';
import 'package:hyip_lab/view/components/text-field/search_text_field.dart';
import 'package:hyip_lab/view/screens/transaction-history/widget/bottom_sheet.dart';
import 'package:hyip_lab/view/screens/transaction-history/widget/custom_transaction_card.dart';
import 'package:hyip_lab/view/screens/transaction-history/widget/filter_row_widget.dart';



class TransactionHistoryScreen extends StatefulWidget {

  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {

  final ScrollController _controller = ScrollController();


  fetchData() {
    Get.find<TransactionController>().loadPaginationData();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<TransactionController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {

    String? arg = Get.arguments;
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TransactionRepo(apiClient: Get.find()));
    final controller = Get.put(TransactionController(transactionRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initData(arg);
      _controller.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child:  GetBuilder<TransactionController>(
        builder: (controller) => Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar: AppBar(
          title: Text(MyStrings.transactionHistory.tr, style: interRegularLarge.copyWith(color: MyColor.getAppbarTitleColor())),
          backgroundColor: MyColor.getAppbarBgColor(),
          elevation: 0,
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: MyColor.getAppbarTitleColor(), size: 20),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: Dimensions.space15),
              child: GestureDetector(
                onTap: (){
                  controller.changeFilterOrSearchStatus(filter: false);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 30, width: 30,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: MyColor.colorGrey.withOpacity(0.1)),
                  child: Icon(controller.isSearch?Icons.clear:Icons.search, color: MyColor.getSelectedIconColor(), size: 15),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: Dimensions.space15),
              child: GestureDetector(
                onTap: (){
                 controller.changeFilterOrSearchStatus(filter: true);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 30, width: 30,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: MyColor.colorGrey.withOpacity(0.1)),
                  child: Image.asset(MyImages.filter, color: controller.isFilter ? MyColor.getPrimaryColor() : MyColor.getSelectedIconColor(), height: 15, width: 15),
                ),
              ),
            ),
          ],
        ),
        body: controller.isLoading ? const CustomLoader() : Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: controller.isFilter,
                    child: SizedBox(
                      height: 95, width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(MyStrings.type.tr, style: interRegularSmall.copyWith(color: MyColor.getTextColor())),

                                    const SizedBox(height: Dimensions.space15),

                                    SizedBox(
                                      height: 40, width: 150,
                                      child: FilterRowWidget(
                                          iconColor: MyColor.getTextColor(),
                                          bgColor: MyColor.getScreenBgColor(),
                                          fromTrx: true,
                                          text: controller.selectedTrxType.isEmpty ? MyStrings.trxType.tr : controller.selectedTrxType.tr,
                                          press: () {
                                            showTrxBottomSheet(controller.transactionTypeList,1,context: context);
                                          }),
                                    ),
                                  ],
                                ),

                                const SizedBox(width: Dimensions.space15),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(MyStrings.remark.tr, style: interRegularSmall.copyWith(color: MyColor.getTextColor())),

                                    const SizedBox(height: Dimensions.space15),

                                    SizedBox(
                                      height: 40, width: 170,
                                      child:  FilterRowWidget(
                                            iconColor: MyColor.getTextColor(),
                                            bgColor: MyColor.getScreenBgColor(),
                                            fromTrx: true,
                                            text: Converter.replaceUnderscoreWithSpace(controller.selectedRemark.isEmpty?MyStrings.any.tr:controller.selectedRemark.tr),
                                            press: () {
                                              showTrxBottomSheet(controller.remarksList.map((e) => e.remark.toString()).toList(),2,context: context);
                                            }
                                        ),
                                    ),
                                  ],
                                ),

                                const SizedBox(width: Dimensions.space15),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(MyStrings.walletType.tr, style: interRegularSmall.copyWith(color: MyColor.getTextColor())),

                                    const SizedBox(height: Dimensions.space15),

                                    SizedBox(
                                      height: 40, width: 170,
                                      child:  FilterRowWidget(
                                          iconColor: MyColor.getTextColor(),
                                          bgColor: MyColor.getScreenBgColor(),
                                          fromTrx: true,
                                          text: Converter.replaceUnderscoreWithSpace(controller.selectedWalletType.isEmpty?MyStrings.any.tr:controller.selectedWalletType.tr),
                                          press: () {
                                            showTrxBottomSheet(controller.walletTypeList.map((e) => e.toString()).toList(),0,context: context);
                                          }
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            controller.isSearch ? const SizedBox(height: Dimensions.space10) : const SizedBox(height: Dimensions.space20),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Visibility(
                    visible: controller.isSearch,
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
                                  Text(MyStrings.transactionNo.tr, style: interRegularSmall.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w500)),
                                  const SizedBox(height: Dimensions.space5),
                                  SizedBox(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width,
                                    child: SearchTextField(
                                      needOutlineBorder: true,
                                      controller: controller.trxController,
                                      hintText: MyStrings.searchByTrxId.tr,
                                      onChanged: (value){
                                        return;
                                     },
                                    ),
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

                  Expanded(
                      child: controller.transactionList.isEmpty && controller.filterLoading == false
                          ? NoDataWidget(title: MyStrings.noTrxFound.tr,) : controller.filterLoading ? Center(
                        child: CircularProgressIndicator(color: MyColor.getPrimaryColor()),
                      ) : SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.separated(
                          controller: _controller,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: controller.transactionList.length + 1,
                          separatorBuilder: (context, index) => const SizedBox(height: 15),
                          itemBuilder: (context, index){
                            if(controller.transactionList.length == index){
                              return controller.hasNext() ? SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: CircularProgressIndicator(color: MyColor.getPrimaryColor()),
                                ),
                              ) : const SizedBox();
                            }
                            return  GestureDetector(
                              onTap: (){},
                              child: CustomTransactionCard(
                                  index: index,
                                  detailsText: (controller.transactionList[index].details ?? "").tr,
                                  trxData: controller.transactionList[index].trx ?? "",
                                  dateData: DateConverter.isoStringToLocalDateOnly(controller.transactionList[index].createdAt ?? ""),
                                  amountData: "${controller.transactionList[index].trxType} ${Converter.twoDecimalPlaceFixedWithoutRounding(controller.transactionList[index].amount.toString())} ${controller.currency}",
                                  postBalanceData: "${Converter.twoDecimalPlaceFixedWithoutRounding(controller.transactionList[index].postBalance.toString())} ${controller.currency}"
                              ),
                            );
                          },
                        ),
                      )
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
