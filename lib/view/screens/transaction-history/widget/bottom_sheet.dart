import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/helper/string_format_helper.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/data/controller/account/transaction_history_controller.dart';

showTrxBottomSheet(List<String>? list, int callFrom, {required BuildContext context}){

  if (list != null && list.isNotEmpty) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        isDismissible: true,
        builder: (BuildContext context) {

          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: MyColor.getCardBg(),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 5,
                        width: 50,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: MyColor.getTextColor().withOpacity(0.5),
                        ),
                      ),
                    ),

                    const SizedBox(height: Dimensions.space15),

                    SizedBox(
                      child: ListView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  String selectedValue = list[index];
                                  final controller= Get.find<TransactionController>();
                                  if(callFrom == 0){
                                    controller.changeSelectedWalletType(selectedValue);
                                    controller.filterData();
                                  } else if(callFrom==1){
                                    controller.changeSelectedTrxType(selectedValue);
                                    controller.filterData();
                                  }
                                  else if(callFrom==2){
                                    controller.changeSelectedRemark(selectedValue);
                                    controller.filterData();
                                  }
                                  Navigator.pop(context);

                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: MyColor.getScreenBgColor()
                                  ),
                                  child: Text(
                                    ' ${callFrom ==2 ? Converter.replaceUnderscoreWithSpace(list[index].capitalizeFirst??''):list[index]}',
                                    style: interSemiBoldSmall.copyWith(color: MyColor.getTextColor()),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                )
            ),
          );
        }
    );
  }
}