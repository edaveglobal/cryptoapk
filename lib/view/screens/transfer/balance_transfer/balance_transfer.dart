import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/data/controller/transfer/transfer_controller.dart';
import 'package:hyip_lab/data/repo/account/profile_repo.dart';
import 'package:hyip_lab/data/repo/balance_transfer_repo/balance_transfer_repo.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import 'package:hyip_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:hyip_lab/view/components/custom_loader/custom_loader.dart';
import 'package:hyip_lab/view/components/rounded_button.dart';
import 'package:hyip_lab/view/components/text-field/custom_amount_text_field.dart';
import 'package:hyip_lab/view/components/text-field/custom_text_field.dart';
import 'package:hyip_lab/view/components/text/label_text.dart';

class BalanceTransfer extends StatefulWidget {
  const BalanceTransfer({Key? key}) : super(key: key);

  @override
  State<BalanceTransfer> createState() => _BalanceTransferState();
}

class _BalanceTransferState extends State<BalanceTransfer> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));
    Get.put(BalanceTransferRepo(apiClient: Get.find()));
    final controller = Get.put(BalanceTransferController(repo: Get.find(),profileRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadData();
    });

  }

  @override
  void dispose() {
    Get.find<BalanceTransferController>().clearInputField();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<BalanceTransferController>(
      builder: (controller) => controller.isLoading ?
        const CustomLoader(): Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelText(text: MyStrings.wallet.tr),
          const SizedBox(height: 8),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space10),
            decoration: BoxDecoration(
                color: MyColor.transparentColor,
                borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                border: Border.all(color: MyColor.getPrimaryColor(), width: 0.5)
            ),
            child: DropdownButton(
              dropdownColor: MyColor.getScreenBgColor(),
              value: controller.selectedWallet,
              elevation: 8,
              icon: Icon(Icons.keyboard_arrow_down, color: MyColor.getPrimaryColor()),
              iconDisabledColor: Colors.red,
              iconEnabledColor : MyColor.getPrimaryColor(),
              isExpanded: true,
              underline: Container(height: 0, color: MyColor.getAppbarBgColor()),
              onChanged: (value) {
                if(value != null){
                  controller.changeWallet(value);
                }
              },
              items: controller.walletList.map((method) {
                return DropdownMenuItem(
                  value: method,
                  child: Text(method.tr, style: interRegularDefault.copyWith(color: MyColor.getTextColor())),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: Dimensions.space15),

          CustomAmountTextField(
            labelText: '${MyStrings.amount.tr} ${controller.amtText}',
            hintText: MyStrings.enterAmount.tr,
            inputAction: TextInputAction.done,
            controller: controller.amountController,
            currency: controller.currency,
            onChanged: (value) {
              if(value.toString().isNotEmpty){
                controller.changeTotalAmount(value);
              }else{
                controller.changeTotalAmount('');
              }
              return;
            },
          ),
          Visibility(visible:controller.chargeText.isEmpty?false:true,child:  const SizedBox(height: 5,),),
          Visibility(visible:controller.chargeText.isEmpty?false:true,child: Text(controller.chargeText,style: interRegularDefault.copyWith(fontSize:Dimensions.fontSmall,color: MyColor.redCancelTextColor),overflow: TextOverflow.ellipsis,),),

          const SizedBox(height: Dimensions.space15),

          CustomTextField(
            needOutlineBorder: true,
            labelText: MyStrings.username.tr,
            hintText: MyStrings.enterUsername.tr,
            textInputType: TextInputType.text,
            inputAction: TextInputAction.next,
            controller: controller.usernameController,
            onChanged: (value){},
          ),
          Visibility(
            visible: controller.isTFAEnable,
            child: Column(
            children: [
              const SizedBox(height: Dimensions.space15),
              CustomTextField(
                needOutlineBorder: true,
                needRequiredSign: true,
                labelText: MyStrings.gogoleAuthenticatorCode.tr,
                hintText: '',
                textInputType: TextInputType.text,
                inputAction: TextInputAction.next,
                controller: controller.twoFactorController,
                onChanged: (value){
                  controller.twoFactorCode = value;
                },
              ),
            ],
          )),
          const SizedBox(height: Dimensions.space25),
          controller.submitLoading? const RoundedLoadingBtn():RoundedButton(
            color: MyColor.getButtonColor(),
            text: MyStrings.transfer.tr,
            textColor: MyColor.getButtonTextColor(),
            press: () {
              controller.submitBalanceTransfer();
            },
          ),
        ],
      ),
    );
  }
}
