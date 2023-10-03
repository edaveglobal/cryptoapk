import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/view/components/text/default_text.dart';
import 'package:hyip_lab/view/components/text/small_text.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ActivePlanCard extends StatelessWidget {

  const ActivePlanCard({Key? key,
    required this.name,
    required this.nextReturn,
    required this.totalReturn,
    required this.invested,
    required this.message,
    required this.percent,
    this.isActive = true,
    this.hasCapital = false
  }) : super(key: key);

  final String name;
  final String nextReturn;
  final String totalReturn;
  final String invested;
  final String message;
  final bool isActive;
  final double percent;
  final bool hasCapital;

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

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("$name - $message", style: interSemiBoldDefault.copyWith(color: MyColor.getTextColor())),
                    Visibility(
                        visible: isActive,
                        child: Row(
                          children: [
                            CircularPercentIndicator(
                              radius: 18.0,
                              lineWidth: 4.0,
                              percent: percent,
                              backgroundColor: MyColor.getTextColor(),
                              progressColor: MyColor.greenSuccessColor,
                            ),
                            const SizedBox(width: Dimensions.space10),
                          ],
                        )),
                  ],
                ),
                const SizedBox(height: Dimensions.space5),
                RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(text: "${MyStrings.invested.tr}: ", style: interRegularExtraSmall.copyWith(color: MyColor.getTextColor())),
                        TextSpan(text: invested, style: interRegularExtraSmall.copyWith(color: MyColor.getPrimaryColor())),
                        TextSpan(text: hasCapital?" (${MyStrings.capitalBack})":'', style: interRegularExtraSmall.copyWith(color: MyColor.getTextColor())),
                      ]
                  ),
                ),
                const SizedBox(height: Dimensions.space15),
                SizedBox(
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallText(text: MyStrings.nextReturn, textStyle: interRegularExtraSmall.copyWith(color: MyColor.getTextColor3())),
                              const SizedBox(height: Dimensions.space5),
                              SmallText(text: nextReturn, textStyle: interRegularSmall.copyWith(color: MyColor.getTextColor()))
                            ],
                          ),
                        ),


                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SmallText(text: MyStrings.totalReturn, textStyle: interRegularExtraSmall.copyWith(color: MyColor.getTextColor3())),
                              const SizedBox(height: Dimensions.space5),
                              //Expanded(child: SmallText(text: totalReturn, textStyle: interRegularSmall.copyWith(color: MyColor.getTextColor())))
                              Expanded(child: Text(totalReturn, style: interRegularSmall.copyWith(color: MyColor.getTextColor()),overflow: TextOverflow.ellipsis,maxLines: 2,))
                            ],
                          ),
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
