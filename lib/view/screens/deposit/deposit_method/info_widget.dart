import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/data/controller/deposit_controller/add_new_deposit_controller.dart';
import 'package:hyip_lab/view/components/row_item/custom_row.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewDepositController>(builder: (controller){
      bool showRate = controller.isShowRate();
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
            border: Border.all(color: MyColor.borderColor)
        ),
        child: Column(
          children: [
            const SizedBox(height: 15,),
            CustomRow(firstText: MyStrings.depositLimit.tr, lastText: controller.depositLimit,),
            CustomRow(firstText: MyStrings.charge.tr, lastText: controller.charge,),
            CustomRow(firstText: MyStrings.payable.tr, lastText: controller.payableText,showDivider: showRate,),
            showRate?CustomRow(firstText: MyStrings.conversionRate.tr, lastText: controller.conversionRate,showDivider: showRate,): const SizedBox.shrink(),
            showRate?CustomRow(firstText: '${MyStrings.in_.tr} ${controller.paymentMethod?.currency}', lastText: controller.inLocal,showDivider: false,):const SizedBox.shrink()

          ],
        ),
      );
    });
  }
}
