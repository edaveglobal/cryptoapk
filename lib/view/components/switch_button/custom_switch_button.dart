import 'package:flutter/material.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/view/components/switch_button/my_switch_widget.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MySwitchWidget(
    activeIcon: const Icon(Icons.nightlight,size: 18,color: MyColor.primaryColor),
    inactiveIcon: const Icon(Icons.sunny,size: 18,color: MyColor.colorGrey),
    width: 55.0,
    height: 30.0,
    valueFontSize: 11.0,
    toggleSize: 20.0,
    value: value,
    borderRadius: 30.0,
    toggleColor: value?MyColor.backgroundColor:MyColor.colorWhite,
    activeColor: MyColor.primaryColor,
    inactiveColor: MyColor.getScreenBgColor(),
    padding: 4.0,
    showOnOff: false,
    onToggle: onChanged);
  }
}