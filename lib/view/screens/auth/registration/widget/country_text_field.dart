import 'package:flutter/material.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/style.dart';

class CountryTextField extends StatelessWidget {

  final String text;
  final VoidCallback press;

  const CountryTextField({Key? key,
    required this.text,
    required this.press
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
            Text(text,style: interRegularDefault.copyWith(color: MyColor.getTextColor()),),
            Icon(Icons.expand_more_rounded,color: MyColor.getPrimaryColor(),size: 20,)
          ],
          ),
          const SizedBox(height: 12,),
          Container(
            decoration: BoxDecoration(
            border: Border(bottom:BorderSide(color: MyColor.getFieldDisableBorderColor()) )
            ),

          ),
        ],
      ),
    );
  }
}
