import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/routes/route.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_images.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/data/controller/dashboard/dashboard_controller.dart';
import 'package:hyip_lab/view/components/image/round_shape_icon.dart';
import 'package:hyip_lab/view/components/text/small_text.dart';

class HomeTopSection extends StatelessWidget {
  const HomeTopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(builder: (controller)=>Padding(
      padding: Dimensions.screenPaddingHV,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              Get.toNamed(RouteHelper.userAccountScreen);
            },
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(MyImages.userImage),
                  radius: 20,
                ),
                const SizedBox(width: Dimensions.space15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.username, style: interRegularLarge.copyWith(color: MyColor.getTextColor())),
                    const SizedBox(height: Dimensions.space5),
                    SmallText(text: controller.email, textStyle: interRegularSmall.copyWith(color: MyColor.colorGrey.withOpacity(0.8)))
                  ],
                )
              ],
            ),
          ),
          Visibility(
            visible: false,
            child: RoundShapeIcon(
            icon: MyImages.bellImage,
            borderColor: MyColor.getPrimaryColor(),
            iconColor: MyColor.getTextColor(),
            ),
          )
        ],
      ),
    ));
  }
}
