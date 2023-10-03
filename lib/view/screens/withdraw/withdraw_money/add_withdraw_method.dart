import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/data/controller/withdraw/add_new_withdraw_controller.dart';
import 'package:hyip_lab/data/model/withdraw/withdraw_method_response_model.dart';
import 'package:hyip_lab/data/repo/withdraw/withdraw_repo.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import 'package:hyip_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:hyip_lab/view/components/custom_loader/custom_loader.dart';
import 'package:hyip_lab/view/components/rounded_button.dart';
import 'package:hyip_lab/view/components/text-field/custom_amount_text_field.dart';
import 'package:hyip_lab/view/components/text/label_text.dart';

import 'info_widget.dart';

class AddWithdrawMethod extends StatefulWidget {
  const AddWithdrawMethod({Key? key}) : super(key: key);

  @override
  State<AddWithdrawMethod> createState() => _AddWithdrawMethodState();
}

class _AddWithdrawMethodState extends State<AddWithdrawMethod> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(WithdrawRepo( apiClient: Get.find()));
    final controller = Get.put(AddNewWithdrawController(repo: Get.find(),));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadDepositMethod();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewWithdrawController>(
      builder: (controller) => controller.isLoading?
         const CustomLoader():
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelText(text: MyStrings.selectGateway.tr),
          const SizedBox(height: 8),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space10),
            decoration: BoxDecoration(
                color: MyColor.transparentColor,
                borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                border: Border.all(color: controller.withdrawMethod?.id.toString()=='-1'?
                MyColor.getFieldDisableBorderColor():
                MyColor.getPrimaryColor(), width: 0.5)
            ),
            child: DropdownButton<WithdrawMethod>(
              dropdownColor: MyColor.getScreenBgColor(),
              value: controller.withdrawMethod,
              elevation: 8,
              icon: Icon(Icons.keyboard_arrow_down,
                  color: controller.withdrawMethod?.id.toString()=='-1'? MyColor.getFieldDisableBorderColor():
                  MyColor.getPrimaryColor()),
              iconDisabledColor: Colors.red,
              iconEnabledColor : MyColor.getPrimaryColor(),
              isExpanded: true,
              underline: Container(height: 0, color: MyColor.getAppbarBgColor()),
              onChanged: (WithdrawMethod? newValue) {
                controller.setWithdrawMethod(newValue);
              },
              items: controller.withdrawMethodList.map((WithdrawMethod method) {
                return DropdownMenuItem<WithdrawMethod>(
                  value: method,
                  child: Text((method.name??'').tr, style: interRegularDefault.copyWith(color: MyColor.getTextColor())),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: Dimensions.space15),
          CustomAmountTextField(
            labelText: MyStrings.amount.tr,
            hintText: MyStrings.enterAmount.tr,
            inputAction: TextInputAction.done,
            currency: controller.currency,
            controller: controller.amountController,
            onChanged: (value) {
              if(value.toString().isEmpty){
                controller.changeInfoWidgetValue(0);
              }else{
                double amount = double.tryParse(value.toString())??0;
                controller.changeInfoWidgetValue(amount);
              }
              return;
            },
          ),

          controller.mainAmount>0?const InfoWidget():const SizedBox(),
          const SizedBox(height: Dimensions.btnSpace,),
          controller.submitLoading? const RoundedLoadingBtn():
          RoundedButton(
            color: MyColor.getButtonColor(),
            text: MyStrings.submit.tr,
            textColor: MyColor.getButtonTextColor(),
            press: () {
              controller.submitWithdrawRequest();
            },
          ),
        ],
      ),
    );
  }
}
