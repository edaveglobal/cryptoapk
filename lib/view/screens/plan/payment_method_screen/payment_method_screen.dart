import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/helper/string_format_helper.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/data/controller/plan_payment_method_screen/payment_method_controller.dart';
import 'package:hyip_lab/data/model/authorized/deposit/deposit_method_response_model.dart';
import 'package:hyip_lab/data/repo/deposit_repo.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import 'package:hyip_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:hyip_lab/view/components/custom_loader/custom_loader.dart';
import 'package:hyip_lab/view/components/rounded_button.dart';
import 'package:hyip_lab/view/components/text-field/custom_amount_text_field.dart';
import 'package:hyip_lab/view/components/text/label_text.dart';

import '../../../../data/model/plan/plan_model.dart';
import 'widget/payment_method_info.dart';

class PaymentMethodScreen extends StatefulWidget {
  final Plans plan;
  const PaymentMethodScreen({Key? key,required this.plan}) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {


  @override
  void dispose() {
    Get.find<PaymentMethodController>().clearData();
    super.dispose();
  }

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DepositRepo( apiClient: Get.find()));
    final controller = Get.put(PaymentMethodController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadData(widget.plan);
    });

  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentMethodController>(
      builder: (controller) =>
            SizedBox(
               child:
               controller.isLoading?const CustomLoader():Column(
                 mainAxisSize: MainAxisSize.min,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const SizedBox(
                     height: 20,
                   ),
                   CustomAmountTextField(
                     labelText: MyStrings.enterAmount.tr,
                     currency: controller.currency,
                     hintText: '0.0',
                     readOnly: controller.isFixed,
                     inputAction: TextInputAction.done,
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
                   const SizedBox(
                     height: 20,
                   ),
                   LabelText(text: MyStrings.selectWallet.tr),
                   const SizedBox(height: 8),
                   Container(
                       width: MediaQuery.of(context).size.width,
                       padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: 0),
                       decoration: BoxDecoration(
                           color: MyColor.transparentColor,
                           borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                           border: Border.all(color: controller.paymentMethod?.id.toString()=='-1'? MyColor.getFieldDisableBorderColor():MyColor.getPrimaryColor(), width: 0.5)
                       ),
                       child: DropdownButton<Methods>(
                         hint:  Text(MyStrings.selectOne.tr),
                         value: controller.paymentMethod,
                         elevation: 8,
                         icon: Icon(Icons.keyboard_arrow_down,
                         color: controller.paymentMethod?.id.toString()=='-1'? MyColor.getFieldDisableBorderColor():
                         MyColor.getPrimaryColor()),
                         iconDisabledColor: Colors.red,
                         iconEnabledColor:MyColor.primaryColor,
                         dropdownColor: MyColor.getCardBg(),
                         isExpanded: true,
                         underline: Container(
                           height: 0,
                           color: Colors.deepPurpleAccent,
                         ),
                         onChanged: (Methods? newValue) {
                           controller.setPaymentMethod(newValue);
                         },
                         items: controller.paymentMethodList.map((Methods method) {
                           return DropdownMenuItem<Methods>(
                             value: method,
                             child: Text(
                               Converter.replaceUnderscoreWithSpace(method.name.toString()).tr,
                               overflow: TextOverflow.ellipsis,
                               style: interRegularDefault.copyWith(color: MyColor.getTextColor())
                             ),
                           );
                         }).toList(),
                       )),
                   const SizedBox(height: 15,),
                   controller.isShowPreview()?const InfoWidget():const SizedBox(),
                   const SizedBox(height: 30,),
                   controller.submitLoading
                       ? const RoundedLoadingBtn() :
                   Center(
                     child: RoundedButton(
                       press: () {
                         controller.submitDeposit();
                       },
                       text: MyStrings.submit.tr,
                     ),
                   ),
                 ],
               )
           ),
    );
  }
}
