import 'package:flutter/material.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/style.dart';


class CustomDropDownTextField extends StatefulWidget {
  final String? title, selectedValue;
  final List<String>? list;
  final ValueChanged? onChanged;
  const CustomDropDownTextField({Key? key,
    this.title,
    this.selectedValue,
    this.list,
    this.onChanged, }) : super(key: key);

  @override
  State<CustomDropDownTextField> createState() => _CustomDropDownTextFieldState();
}

class _CustomDropDownTextFieldState extends State<CustomDropDownTextField> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    widget.list?.removeWhere((element) => element.isEmpty);
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height:45,
            decoration: BoxDecoration(
                color: MyColor.getCardBg(),
                borderRadius:const  BorderRadius.all(Radius.circular(5)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left:10,
                  right: 5,
                  top: 5,
                  bottom: 5
              ),
              child: DropdownButton(
                isExpanded: true,
                underline: Container(),
                hint: Text(
                  widget.selectedValue??'',
                  style:interSemiBoldDefault.copyWith(color: MyColor.getTextColor()),
                ), // Not necessary for Option 1
                value: widget.selectedValue,
                dropdownColor: MyColor.getCardBg(),
                onChanged: widget.onChanged,
                items: widget.list!.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: interSemiBoldDefault.copyWith(color: MyColor.getTextColor()),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
