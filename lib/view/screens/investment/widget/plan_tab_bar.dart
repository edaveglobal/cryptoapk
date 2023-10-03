import 'package:flutter/material.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/style.dart';

class PlanTabBar extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback press;

  const PlanTabBar({
    Key? key,
    required this.text,
    required this.isActive,
    required this.press
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
          onTap:press,
          child: isActive ? Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
            decoration: BoxDecoration(
                color: isActive ? MyColor.getPrimaryColor() : MyColor.getCardBg(),
                borderRadius: BorderRadius.circular(20)
            ),
            child: Text(text, textAlign: TextAlign.center, style: interRegularSmall.copyWith(color: isActive ? MyColor.getButtonTextColor() : MyColor.getButtonColor())),
          ) : Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: Dimensions.space15 , horizontal: Dimensions.space15),
            decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(20)),
            child: Text(text, textAlign: TextAlign.center, style: interRegularSmall.copyWith(color: MyColor.getTextColor())),
          )
      );
  }
}
