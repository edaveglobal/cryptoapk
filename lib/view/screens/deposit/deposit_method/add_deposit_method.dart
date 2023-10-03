import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/data/controller/deposit_controller/add_new_deposit_controller.dart';
import 'package:hyip_lab/data/model/authorized/deposit/deposit_method_response_model.dart';
import 'package:hyip_lab/data/repo/deposit_repo.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import 'package:hyip_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:hyip_lab/view/components/rounded_button.dart';
import 'package:hyip_lab/view/components/text-field/custom_amount_text_field.dart';
import 'package:hyip_lab/view/components/text/label_text.dart';

import 'info_widget.dart';

class AddDepositMethod extends StatefulWidget {
  const AddDepositMethod({Key? key}) : super(key: key);

  @override
  State<AddDepositMethod> createState() => _AddDepositMethodState();
}

class _AddDepositMethodState extends State<AddDepositMethod> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DepositRepo( apiClient: Get.find()));
    final controller = Get.put(AddNewDepositController(depositRepo: Get.find(),));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
     controller.beforeInitLoadData();
    });

  }

  @override
  void dispose() {
    Get.find<AddNewDepositController>().clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewDepositController>(
      builder: (controller) => controller.isLoading ? Center(
        child: CircularProgressIndicator(color: MyColor.getPrimaryColor())
      ) : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           LabelText(text: MyStrings.selectGateway.tr),
          const SizedBox(height: 8),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: 0),
            decoration: BoxDecoration(
                color: MyColor.transparentColor,
                borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                border: Border.all(color: MyColor.getPrimaryColor(), width: 0.5)
            ),
            child: DropdownButton<Methods>(
              dropdownColor: MyColor.getScreenBgColor(),
              value: controller.paymentMethod,
              elevation: 8,
              icon: Icon(Icons.keyboard_arrow_down, color: MyColor.getPrimaryColor()),
              iconDisabledColor: Colors.red,
              iconEnabledColor : MyColor.getPrimaryColor(),
              isExpanded: true,
              underline: Container(height: 0, color: MyColor.getAppbarBgColor()),
              onChanged: (Methods? newValue) {
                controller.setPaymentMethod(newValue);
              },
              items: controller.paymentMethodList.map((Methods method) {
                return DropdownMenuItem<Methods>(
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
            controller: controller.amountController,
            currency: controller.currency,
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

          const SizedBox(height: Dimensions.space15,),
          controller.mainAmount>0?const InfoWidget():const SizedBox(),
          const SizedBox(height: 30,),

          controller.submitLoading? const RoundedLoadingBtn():RoundedButton(
            color: MyColor.getButtonColor(),
            text: MyStrings.submit.tr,
            textColor: MyColor.getButtonTextColor(),
            press: () {
              controller.submitDeposit();
            },
          ),
        ],
      ),
    );
  }
}
