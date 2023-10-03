import 'package:flutter/material.dart';

class CustomSizedBox extends StatelessWidget {
  final double  width;
  final double height;
  const CustomSizedBox({Key? key,this.height=10,this.width=0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height,width: width,);
  }
}
