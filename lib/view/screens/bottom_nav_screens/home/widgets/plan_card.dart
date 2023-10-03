import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/view/components/text/small_text.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PlanCard extends StatelessWidget {

  const PlanCard({Key? key,
    required this.returnAmount,
    required this.planName,
    required this.receivedAmount,
    required this.nextPayment,
    required this.investingAmount,
    required this.currency
  }) : super(key: key);

  final String returnAmount;
  final String planName;
  final String receivedAmount;
  final String nextPayment;
  final String investingAmount;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: Dimensions.space10 + 2, horizontal: Dimensions.space15),
      decoration: BoxDecoration(
        color: MyColor.getCardBg(),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircularPercentIndicator(
            radius: 20.0,
            lineWidth: 2.0,
            percent: 0.8,
            backgroundColor: MyColor.transparentColor,
            progressColor: MyColor.getPrimaryColor(),
          ),
          const SizedBox(width: Dimensions.space15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(returnAmount,style: interSemiBoldDefault.copyWith(color:MyColor.getTextColor()),maxLines: 2,),
                const SizedBox(height: Dimensions.space5),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "${MyStrings.invested.tr}: ", style: interRegularExtraSmall.copyWith(color: MyColor.getTextColor())),
                      TextSpan(text: "$investingAmount $currency", style: interRegularExtraSmall.copyWith(color: MyColor.getPrimaryColor())),
                   // TextSpan(text: "(capital will be back)", style: interRegularExtraSmall.copyWith(color: MyColor.getTextColor())),
                    ]
                  ),
                ),
                const SizedBox(height: Dimensions.space15),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .65,
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallText(text: MyStrings.nextReturn.tr, textStyle: interRegularExtraSmall.copyWith(color: MyColor.getTextColor1(),fontWeight: FontWeight.w600)),
                              const SizedBox(height: Dimensions.space5),
                              SmallText(text:nextPayment.split(' ').first.tr, textStyle: interRegularSmall.copyWith(color: MyColor.getTextColor()))
                            ],
                          ),
                        ),
                        const SizedBox(
                            height: 30,
                            child: VerticalDivider(color: MyColor.bottomNavBgColor, thickness: 1)
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SmallText(text: MyStrings.totalReturn.tr, textStyle: interRegularExtraSmall.copyWith(color: MyColor.getTextColor1(),fontWeight: FontWeight.w600)),
                            const SizedBox(height: Dimensions.space5),
                            SmallText(text: receivedAmount, textStyle: interRegularSmall.copyWith(color: MyColor.getTextColor()))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
