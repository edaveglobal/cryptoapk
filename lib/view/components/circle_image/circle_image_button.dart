import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_images.dart';

class CircleImageWidget extends StatelessWidget {

  final double height;
  final double width;
  final String imagePath;
  final bool isAsset;
  final Callback? press;
  final double border;

  const CircleImageWidget({Key? key,
  this.border=0,
  this.height=30,
  this.width=30,
  this.isAsset=true,
  required this.imagePath,
  this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return border>0?ClipOval(
      child: Container(
        decoration: BoxDecoration(
          color: MyColor.transparentColor,
          border: Border.all(color: MyColor.borderColor,width: 1),
        ),
        child: FadeInImage.assetNetwork(
          image: imagePath,
          fit: BoxFit.cover,
          width: height,
          height: width,
          imageErrorBuilder: (ctx,object,trx){
            return Image.asset(
              MyImages.placeHolderImage,
              fit: BoxFit.cover,
              width: height,
              height: width,
            );
          }, placeholder: MyImages.placeHolderImage,
        ),
      ),
    ):ClipOval(
      child: isAsset?Image.asset(
        imagePath,
        fit: BoxFit.cover,
        width: height,
        height: width,
      ):ClipOval(
        child: FadeInImage.assetNetwork(
          image: imagePath,
          fit: BoxFit.cover,
          width: height,
          height: width,
          placeholder: MyImages.placeHolderImage,
          imageErrorBuilder: (ctx,object,trx){
            return Image.asset(
              MyImages.placeHolderImage,
              fit: BoxFit.cover,
              width: height,
              height: width,
            );
          },
        ),
      )
    );
  }
}
