import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/view/components/text/show_more_text.dart';

class HeaderRow extends StatelessWidget {

  final String heading;
  final Callback onShowMorePress;
  final IconData icon;
  final bool isShowMoreVisible;

  const HeaderRow({Key? key,
    this.isShowMoreVisible=true,
    this.icon=Icons.play_arrow_outlined,
    required this.heading,
    required this.onShowMorePress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon,color: MyColor.getPrimaryColor(),size: 20,),
            const SizedBox(width: 10,),
            Text(heading,style: interSemiBoldDefault.copyWith(fontSize:Dimensions.fontLarge,color: Colors.white,),)
          ],
        ),
        isShowMoreVisible?GestureDetector(onTap: (){

        },child:ShowMoreText(onTap: onShowMorePress,)):const SizedBox(),
      ],
    );
  }
}
