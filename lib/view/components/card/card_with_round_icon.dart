import 'package:flutter/material.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/style.dart';

class CardWithRoundIcon extends StatelessWidget {

  final VoidCallback? onPressed;
  final String icon;
  final String titleText;
  final String trailText;
  final Color? backgroundColor;
  final Color titleColor;
  final Color trailColor;

  const CardWithRoundIcon({
    Key? key,
    this.onPressed,
    required this.titleText,
    required this.trailText,
    required this.icon,
    this.backgroundColor,
    this.titleColor = MyColor.colorWhite,
    this.trailColor = MyColor.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 40, width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: MyColor.colorGrey.withOpacity(0.1),
                  shape: BoxShape.circle),
                child: Image.asset(icon, color: MyColor.getSelectedIconColor(), height: 20, width: 20)
            ),
            const SizedBox(height: 10),
            Text(
              titleText,
              style: interSemiBoldSmall.copyWith(color: MyColor.getTextColor()),
            ),
            const SizedBox(height: Dimensions.space5),
            Text(
              trailText,
              style: interRegularLarge.copyWith(fontSize:Dimensions.fontDefault,color: MyColor.getTextColor().withOpacity(.6)),
            ),
          ],
        ),
      ),
    );
  }
}
