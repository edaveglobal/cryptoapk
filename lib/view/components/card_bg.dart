
import 'package:flutter/material.dart';
import 'package:hyip_lab/core/utils/my_color.dart';


class RadiusCardShape extends StatelessWidget {

  final double padding;
  final double margin;
  final double cardRadius;
  final Color? cardBgColor;
  final Widget widget;
  final double height;
  final double width;
  final bool isCircle;
  const RadiusCardShape(
      {Key? key,
      this.height = 0,
      this.width = 0,
      this.isCircle = false,
      this.padding = 12.0,
      this.margin = 0,
      this.cardRadius = 20,
      this.cardBgColor,
      required this.widget})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return !isCircle
        ? Container(
            padding: EdgeInsets.all(padding),
            margin: EdgeInsets.all(margin),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(cardRadius),
              color: cardBgColor ?? MyColor.getCardBg(),
            ),
            child: widget,
          )
        : Container(
            height: height,
            width: width,
            padding: EdgeInsets.all(padding),
            margin: EdgeInsets.all(margin),
            decoration: BoxDecoration(
                color: cardBgColor ?? MyColor.getCardBg(),
                shape: BoxShape.circle),
            child: widget,
          );
  }
}
