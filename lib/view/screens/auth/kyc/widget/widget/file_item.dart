import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/data/controller/kyc_controller/kyc_controller.dart';
import 'package:hyip_lab/view/screens/withdraw/withdraw_money/confirm_withdraw_screen/widget/choose_file_list_item.dart';



import '../../../../../../data/model/kyc/kyc_response_model.dart';

class ConfirmWithdrawFileItem extends StatefulWidget {

  final int index;

  const ConfirmWithdrawFileItem({Key? key,required this.index}) : super(key: key);

  @override
  State<ConfirmWithdrawFileItem> createState() => _ConfirmWithdrawFileItemState();
}

class _ConfirmWithdrawFileItemState extends State<ConfirmWithdrawFileItem> {
  @override
  Widget build(BuildContext context) {

    return GetBuilder<KycController>(builder: (controller){
      FormModel? model=controller.formList[widget.index];
      return SizedBox(
        child:InkWell(
          onTap: (){
            controller.pickFile(widget.index);
          }, child: ChooseFileItem(fileName: model.selectedValue??MyStrings.chooseFile.tr,)),
      );
    });
  }
}
