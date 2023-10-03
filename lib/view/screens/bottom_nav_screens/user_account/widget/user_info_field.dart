import 'package:flutter/material.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/style.dart';

class UserInfoField extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  const UserInfoField({Key? key, required this.icon, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 32, width: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: MyColor.getScreenBgColor(), shape: BoxShape.circle),
          child: Image.asset(
            icon,
            color: MyColor.getPrimaryColor(),
            height: 16, width: 16,
          ),
        ),
        const SizedBox(width: Dimensions.space15),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: interRegularSmall.copyWith(color: MyColor.getLabelTextColor(), fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: Dimensions.space5),

            Text(
              value,
              style: interRegularDefault.copyWith(color: MyColor.getTextColor()),
            ),
          ],
        ),
      ],
    );
  }
}
