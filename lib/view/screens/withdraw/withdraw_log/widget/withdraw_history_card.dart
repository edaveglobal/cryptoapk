import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/helper/date_converter.dart';
import 'package:hyip_lab/core/helper/string_format_helper.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/data/controller/withdraw/withdraw_history_controller.dart';
import 'package:hyip_lab/view/components/divider/custom_divider.dart';

class WithdrawHistoryCard extends StatelessWidget {

  final int index;

  const WithdrawHistoryCard(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawHistoryController>(
      builder: (controller) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
        decoration: BoxDecoration(
            color: MyColor.getCardBg(),
            borderRadius: BorderRadius.circular(5)
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        MyStrings.trx,
                        style: interLightDefault.copyWith(color: MyColor.getLabelTextColor(), fontWeight: FontWeight.w400, fontSize: Dimensions.fontSmall)
                    ),
                    const SizedBox(height: 8),
                    Text(
                        controller.historyList[index].trx.toString(),
                        style: interRegularDefault.copyWith(color: MyColor.getPrimaryColor(), fontSize: Dimensions.fontDefault)
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(MyStrings.date.tr, style: interLightDefault.copyWith(color: MyColor.getLabelTextColor(), fontWeight: FontWeight.w400, fontSize: Dimensions.fontSmall)),
                    const SizedBox(height: 8),
                    Text(
                        DateConverter.formatDepositTimeWithAmFormat(controller.historyList[index].createdAt.toString()),
                        style: interRegularDefault.copyWith(color: MyColor.getTextColor(), fontSize: Dimensions.fontDefault)
                    ),
                  ],
                ),
              ],
            ),

            const CustomDivider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(MyStrings.amount, style: interLightDefault.copyWith(color: MyColor.getLabelTextColor(), fontWeight: FontWeight.w400, fontSize: Dimensions.fontSmall)),
                    const SizedBox(height: 8),
                    Text(
                        "${Converter.twoDecimalPlaceFixedWithoutRounding(controller.historyList[index].amount.toString())} USD",
                        style: interRegularDefault.copyWith(color: MyColor.getTextColor(), fontSize: Dimensions.fontDefault)
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(MyStrings.gateway.tr, style: interLightDefault.copyWith(color: MyColor.getLabelTextColor(), fontWeight: FontWeight.w400, fontSize: Dimensions.fontSmall)),
                    const SizedBox(height: 8),
                    Text(
                        controller.historyList[index].method?.name.toString() ?? "",
                        style: interRegularDefault.copyWith(color: MyColor.getPrimaryColor(), fontSize: Dimensions.fontDefault)
                    ),
                  ],
                ),
              ],
            ),

            const CustomDivider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(MyStrings.conversion.tr, style: interLightDefault.copyWith(color: MyColor.getLabelTextColor(), fontWeight: FontWeight.w400, fontSize: Dimensions.fontSmall)),
                    const SizedBox(height: 8),
                    Text(
                        Converter.twoDecimalPlaceFixedWithoutRounding(controller.historyList[index].amount.toString()),
                        style: interRegularDefault.copyWith(color: MyColor.getTextColor(), fontSize: Dimensions.fontDefault)
                    ),
                  ],
                ),

                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(width: 0.5, color: controller.historyList[index].status == '1' ? Colors.green
                          : controller.historyList[index].status == '2' ? Colors.orangeAccent
                          : controller.historyList[index].status == '3' ? Colors.red : Colors.green
                      )
                  ),
                  child: Text(
                    controller.historyList[index].status == '1' ? MyStrings.approved.tr
                        : controller.historyList[index].status == '2' ? MyStrings.pending.tr
                        : controller.historyList[index].status == '3' ? MyStrings.rejected.tr
                        : "",
                    textAlign: TextAlign.center,
                    style: interRegularDefault.copyWith(
                        color: controller.historyList[index].status == '1' ? Colors.green
                            : controller.historyList[index].status == '2' ? Colors.orangeAccent
                            : controller.historyList[index].status == '3' ? Colors.red
                            : Colors.green,
                        fontSize: Dimensions.fontExtraSmall
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
