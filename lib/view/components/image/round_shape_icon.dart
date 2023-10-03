import 'package:flutter/material.dart';
import 'package:hyip_lab/core/utils/my_color.dart';

class RoundShapeIcon extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final String? icon;
  final VoidCallback? onPressed;
  final double size;

  const RoundShapeIcon({
    Key? key,
    this.backgroundColor = MyColor.transparentColor,
    this.borderColor = MyColor.primaryColor,
    this.iconColor = MyColor.colorWhite,
    this.onPressed,
    this.size = 30.00,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: 0.5)
      ),
      child: Image.asset(icon.toString(), color: iconColor, height: size / 2, width: size / 2),
    );
  }
}
