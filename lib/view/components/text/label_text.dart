import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/view/components/form_row.dart';

class LabelText extends StatelessWidget {

  final String text;
  final TextAlign? textAlign;
  final bool required;

  const LabelText({
    Key? key,
    required this.text,
    this.textAlign,
    this.required = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return required?FormRow(label: text.tr, isRequired: true):Text(
      text.tr,
      textAlign: textAlign,
      style: interRegularDefault.copyWith(color: MyColor.getLabelTextColor()),
    );
  }
}
