import 'package:flutter/material.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/style.dart';


class CustomBackSupportAppBar extends StatelessWidget {

  final VoidCallback press;
  final VoidCallback? press2;
  final bool isShowActionBtn;
  final Color backBtnBgColor;
  final Color backBtnIconColor;
  final String title;
  final String actionString;
  final bool showActionIconInStart;
  final IconData actionIconData;

 const CustomBackSupportAppBar({Key? key,
   this.showActionIconInStart = false,
   this.actionIconData = Icons.logout,
   this.actionString = 'Create Voucher',
   this.title = '',
   this.backBtnIconColor = MyColor.colorWhite,
   this.backBtnBgColor = MyColor.primaryColor,
   required this.press,
   this.isShowActionBtn = false,
   this.press2, }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.transparent,
          padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom:10),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: press,
                        child: Container(
                          height: 40,
                          width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: MyColor.transparentColor
                            ),
                            child:  const Icon(Icons.arrow_back_outlined,color: MyColor.colorBlack,),
                        ),
                      ),
                    ),
                    const SizedBox(width: 50,),
                    Text(title,style: interSemiBoldDefault.copyWith(fontSize:Dimensions.fontLarge,color: MyColor.colorBlack),),
                    const Spacer(),
                    isShowActionBtn? GestureDetector(
                      onTap: press2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children:  [
                            showActionIconInStart? Icon(actionIconData):const SizedBox.shrink(),
                            Text(
                              actionString,
                              style: interRegularDefault.copyWith(fontSize: Dimensions.fontSmall)
                            ),
                            const SizedBox(width: 5),
                            showActionIconInStart?const SizedBox.shrink():const Icon(Icons.logout),
                          ],
                        ),
                      ),
                    ) : const SizedBox()
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}