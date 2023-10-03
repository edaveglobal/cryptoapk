import 'package:flutter/material.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/view/components/text/default_text.dart';
import 'package:hyip_lab/view/components/text/extra_small_text.dart';

class ClickableCard extends StatelessWidget {

  final VoidCallback onPressed;
  final String image;
  final String label;
  final double imageSize;
  final bool needHorizontal;
  final Color? backgroundColor;

  const ClickableCard({
    Key? key,
    required this.onPressed,
    required this.image,
    required this.label,
    this.imageSize = 25,
    this.needHorizontal = false,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: needHorizontal ? Dimensions.space15 : 0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12)
        ),
        child: needHorizontal ? Row(
          children: [
            Image.asset(image, color: MyColor.getSelectedIconColor(), height: imageSize, width: imageSize),
            const SizedBox(width: Dimensions.space10),
            DefaultText(text: label, textAlign: TextAlign.left, textColor: MyColor.getTextColor())
          ],
        ) : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, color: MyColor.getSelectedIconColor(), height: imageSize, width: imageSize),
            const SizedBox(height: Dimensions.space10),
            ExtraSmallText(text: label, textAlign: TextAlign.center, textStyle: interRegularExtraSmall.copyWith(color: MyColor.getTextColor()))
          ],
        ),
      ),
    );
  }
}
