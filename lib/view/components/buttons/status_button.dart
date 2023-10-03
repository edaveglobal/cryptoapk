import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/style.dart';

class StatusButton extends StatelessWidget {

  final String text;
  final Color bgColor;
  final bool isShowBg;
  final double minWidth;
  final double minHeight;
  final bool isCircle;

  const StatusButton({Key? key,
    this.minWidth=45,
    this.minHeight=10,
    this.isShowBg=true,
    this.isCircle = false,
    required this.text,
    required this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCircle?
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: bgColor.withOpacity(.05),
        border: Border.all(color: bgColor)
      ),
      child: Text(
        text.tr,
        style: interRegularDefault.copyWith(
            fontSize: Dimensions.fontExtraSmall,
            color: bgColor),
      ),
    ):
    Text(
      text,
      style: interRegularDefault.copyWith(
          fontSize: Dimensions.fontDefault,
          color: bgColor),
    );
  }
}
