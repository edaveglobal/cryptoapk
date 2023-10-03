import 'package:flutter/material.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/view/components/text/default_text.dart';

class MenuRowWidget extends StatelessWidget {

  final String image;
  final String label;
  final VoidCallback onPressed;

  const MenuRowWidget({
    Key? key,
    required this.image,
    required this.label,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(image, color: MyColor.getSelectedIconColor(), height: 20, width: 20,fit: BoxFit.cover,),
              const SizedBox(width: Dimensions.space15),
              DefaultText(text: label, textColor: MyColor.getTextColor())
            ],
          ),

          Container(
            alignment: Alignment.center,
            height: 30, width: 30,
            decoration: const BoxDecoration(color: MyColor.transparentColor, shape: BoxShape.circle),
            child: Icon(Icons.arrow_forward_ios_rounded, color: MyColor.getTextColor(), size: 15),
          )
        ],
      ),
    );
  }
}
