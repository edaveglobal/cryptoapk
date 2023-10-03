import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/view/components/text/label_text.dart';

class CustomAmountTextField extends StatefulWidget {

  const CustomAmountTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.chargeText='',
    required this.currency,
    required this.onChanged,
    this.autoFocus = false,
    this.inputAction,
    this.readOnly = false
  }) : super(key: key);

  final String chargeText;
  final String labelText;
  final String hintText;
  final String currency;
  final bool autoFocus;
  final bool readOnly;
  final Function(String) onChanged;
  final TextEditingController? controller;
  final TextInputAction? inputAction;

  @override
  State<CustomAmountTextField> createState() => _CustomAmountTextFieldState();
}

class _CustomAmountTextFieldState extends State<CustomAmountTextField> {

  bool isFocus = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelText(text: widget.labelText.tr),
        const SizedBox(height: 8),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: 8),
          decoration: BoxDecoration(
            color: MyColor.transparentColor,
            border: Border.all(color: isFocus ? MyColor.getFieldEnableBorderColor() : MyColor.getFieldDisableBorderColor(), width: 0.5),
            borderRadius: BorderRadius.circular(Dimensions.defaultRadius)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: FocusScope(
                  child: Focus(
                    onFocusChange: (focus){
                      setState(() {
                        isFocus = focus;
                      });
                    },
                    child: TextField(
                      cursorColor: MyColor.getTextColor(),
                      readOnly: widget.readOnly,
                      controller: widget.controller,
                      autofocus: widget.autoFocus,
                      style: interRegularDefault.copyWith(color: MyColor.getTextColor()),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.number,
                      textInputAction: widget.inputAction,
                      onChanged: widget.onChanged,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 16),
                          hintText: widget.hintText,
                          hintStyle: interRegularSmall.copyWith(color: MyColor.hintTextColor, height: 1.452),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          errorBorder: InputBorder.none
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 48,
                padding: const EdgeInsets.all(Dimensions.space5),
                decoration: BoxDecoration(color: MyColor.getTextColor().withOpacity(0.04), borderRadius: BorderRadius.circular(5)),
                alignment: Alignment.center,
                child: Text(widget.currency, textAlign: TextAlign.center, style: interRegularDefault.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w500)),
              )
            ],
          ),
        ),
      ],
    );
  }
}
