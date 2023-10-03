import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/routes/route.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_images.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/view/components/card/clickable_card.dart';
import 'package:hyip_lab/view/components/divider/custom_divider.dart';

class HistoryBottomSheetItems extends StatelessWidget {
  const HistoryBottomSheetItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 50,
            height: 4,
            decoration: BoxDecoration(color: MyColor.getTextColor().withOpacity(0.4), borderRadius: BorderRadius.circular(5)),
          ),
        ),
        const SizedBox(height: Dimensions.space15),

        ClickableCard(
          backgroundColor: MyColor.getTextColor().withOpacity(0.05),
          needHorizontal: true,
          onPressed: (){
            Navigator.pop(context);
            Get.toNamed(RouteHelper.depositScreen);
          },
          image: MyImages.depositWallet,
          label: MyStrings.deposit.tr
        ),

        const CustomDivider(space: Dimensions.space15),

        ClickableCard(
            backgroundColor: MyColor.getTextColor().withOpacity(0.05),
            needHorizontal: true,
            onPressed: (){
              Navigator.pop(context);
              Get.toNamed(RouteHelper.withdrawHistoryScreen);
            },
            image: MyImages.withdrawLight,
            label: MyStrings.withdraw.tr
        ),
      ],
    );
  }
}
