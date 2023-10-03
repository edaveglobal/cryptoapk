import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/view/components/text/default_text.dart';

import '../../components/animated_widget/expanded_widget.dart';

class FaqListItem extends StatelessWidget {

  final String question;
  final String answer;
  final int index;
  final int selectedIndex;
  final VoidCallback press;

  const FaqListItem({Key? key,
    required this.answer,
    required this.question,
    required this.index,
    required this.press,
    required this.selectedIndex
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space15),
      decoration: BoxDecoration(
        color: MyColor.getCardBg(),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: DefaultText(
                  text: question.tr,
                  textStyle: interSemiBoldDefault,
                  textColor: MyColor.getTextColor(),
                ),
              ),
              SizedBox(
                  height: 30, width: 30,
                  child: IconButton(
                      onPressed:press,

                      icon:Icon( index == selectedIndex ? Icons.keyboard_arrow_up: Icons.keyboard_arrow_down,
                          color: MyColor.getPrimaryColor(),
                          size: 20)
                  )
              )
            ],
          ),

         ExpandedSection(
            expand:index==selectedIndex,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Dimensions.space10),
                Text(answer.tr,
                  style: interRegularSmall.copyWith(color: MyColor.getLabelTextColor()),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
