import 'package:flutter/material.dart';
import 'package:hyip_lab/core/utils/my_color.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({Key? key,this.isShowIcon=true,required this.press,this.isShowText=true,this.text='', this.icon=Icons.add}) : super(key: key);
  final String text;
  final IconData icon;
  final bool isShowText;
  final bool isShowIcon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
      return isShowText&&isShowIcon?FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        foregroundColor: Colors.white,
        backgroundColor: MyColor.getPrimaryColor(),
        icon: Icon(icon),
        label: Text(text),
        onPressed: press
      ):!isShowIcon?
      FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          foregroundColor: Colors.white,
          backgroundColor: MyColor.getPrimaryColor(),
          label: Text(text),
          onPressed: press
      ):
      FloatingActionButton(onPressed: press, child:Icon(icon));
    }

}
