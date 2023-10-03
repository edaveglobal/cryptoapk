import 'package:flutter/material.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import '../../core/utils/my_color.dart';


class DropDownTextFieldContainer extends StatelessWidget {

  final Widget child;
  final Color color;

  const DropDownTextFieldContainer({
    Key? key,
    required this.child,
    this.color = MyColor.primaryColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
