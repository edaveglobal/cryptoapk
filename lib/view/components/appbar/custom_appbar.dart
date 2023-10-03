import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/routes/route.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_icons.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import '../dialog/exit_dialog.dart';


class CustomAppBar extends StatefulWidget implements PreferredSizeWidget{

  final String title;
  final bool isShowBackBtn;
  final Color bgColor;
  final bool isShowActionBtn;
  final bool isTitleCenter;
  final bool fromAuth;
  final bool isProfileCompleted;

  const CustomAppBar({Key? key,
    this.isProfileCompleted=false,
    this.fromAuth = false,
    this.isTitleCenter = false,
    this.bgColor = Colors.transparent,
    this.isShowBackBtn=true,
    required this.title,
    this.isShowActionBtn=false}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool hasNotification =false;
  @override
  void initState() {
   Get.put(ApiClient(sharedPreferences: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isShowBackBtn?AppBar(
      elevation: 0,
      leading:widget.isShowBackBtn?IconButton(onPressed: (){
        if(widget.fromAuth){
          Get.offAllNamed(RouteHelper.loginScreen);
        }else if(widget.isProfileCompleted){
          showExitDialog(Get.context!);
        }
        else{
          String previousRoute=Get.previousRoute;
          if(previousRoute=='/splash-screen'){
            Get.offAndToNamed(RouteHelper.homeScreen);
          }else{
            Get.back();
          }
        }
      },icon: Icon(Icons.arrow_back,color: MyColor.getTextColor(), size: 20)):const SizedBox.shrink(),
      backgroundColor: widget.bgColor,
      title: Text(widget.title,style: interRegularLarge.copyWith(color: MyColor.getAppbarTitleColor())),
      centerTitle: widget.isTitleCenter,
      actions: [
        widget.isShowActionBtn?Container(
          height: 30,width: 30,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: MyColor.transparentColor
          ),
          child: InkWell(
            onTap: (){
              Get.toNamed(RouteHelper.notificationScreen) ?.then((value) {
              setState(() {
                hasNotification=false;
              });
          });},child: SvgPicture.asset(hasNotification?MyIcons.activeNotificationIcon:MyIcons.inActiveNotificationIcon,height: 25,width: 25,)),
        ):const SizedBox.shrink(),
        const SizedBox(width: 10,)
      ],
    ):AppBar(
      elevation: 0,
      backgroundColor: widget.bgColor,
      title:Text(widget.title,style: interRegularLarge.copyWith(color: MyColor.getTextColor())),
      actions: [
        widget.isShowActionBtn?InkWell(onTap: (){Get.toNamed(RouteHelper.notificationScreen)?.then((value){
          setState(() {
            hasNotification=false;
          });
        });},child: SvgPicture.asset(hasNotification?MyIcons.activeNotificationIcon:MyIcons.inActiveNotificationIcon,height: 28,width: 28,)):const SizedBox.shrink(),
        const SizedBox(width: 10)],
      automaticallyImplyLeading: false,
    );
  }


}
