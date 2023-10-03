import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/helper/string_format_helper.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/data/controller/withdraw/withdraw_confirm_controller.dart';
import 'package:hyip_lab/data/model/withdraw/withdraw_request_response_model.dart';
import 'package:hyip_lab/data/repo/account/profile_repo.dart';
import 'package:hyip_lab/data/repo/withdraw/withdraw_repo.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import 'package:hyip_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:hyip_lab/view/components/checkbox/custom_check_box.dart';
import 'package:hyip_lab/view/components/custom_drop_down_button_with_text_field.dart';
import 'package:hyip_lab/view/components/custom_radio_button.dart';
import 'package:hyip_lab/view/components/form_row.dart';
import 'package:hyip_lab/view/components/rounded_button.dart';
import 'package:hyip_lab/view/components/text-field/custom_text_field.dart';
import 'package:hyip_lab/view/screens/withdraw/withdraw_money/confirm_withdraw_screen/widget/file_item.dart';

import '../../../../components/appbar/custom_appbar.dart';


class ConfirmWithdrawScreen extends StatefulWidget {
  const ConfirmWithdrawScreen({Key? key,required this.model}) : super(key: key);
  final WithdrawRequestResponseModel model;

  @override
  State<ConfirmWithdrawScreen> createState() => _ConfirmWithdrawScreenState();
}

class _ConfirmWithdrawScreenState extends State<ConfirmWithdrawScreen> {

  String gatewayName='';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {

    gatewayName =Get.arguments[1];
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(WithdrawRepo( apiClient: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));
    final controller = Get.put(WithdrawConfirmController(profileRepo:Get.find(),repo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadData(widget.model);
    });


  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawConfirmController>(
      builder: (controller) =>
          Scaffold(
            backgroundColor: MyColor.getScreenBgColor(),
            appBar: CustomAppBar(
              title: '${MyStrings.withdrawVia.tr} ${gatewayName.tr}',
            ),
            body: Stack(
              children: [

                controller.isLoading ? const Center(child: CircularProgressIndicator()) : Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(Dimensions.fontExtraLarge),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:MyColor.getScreenBgColor(),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: controller.formList.length,
                              itemBuilder: (ctx,index){
                                FormModel? model=controller.formList[index];
                                return Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      model.type=='text'?Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomTextField(
                                              hintText: '${((model.name??'').capitalizeFirst)?.tr}',
                                              needLabel: true,
                                              needOutlineBorder: true,
                                              labelText:( model.name??'').tr,
                                              needRequiredSign: model.isRequired=='optional'?false:true,
                                              onChanged: (value){
                                                controller.changeSelectedValue(value, index);
                                              }),
                                          const SizedBox(height: 10,),
                                        ],
                                      ):model.type=='textarea'?Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomTextField(
                                              needLabel: true,
                                              needOutlineBorder: true,
                                              labelText: (model.name??'').tr,
                                              needRequiredSign: model.isRequired=='optional'?false:true,
                                              hintText: '${((model.name??'').capitalizeFirst)?.tr}',
                                              onChanged: (value){
                                                controller.changeSelectedValue(value, index);
                                              }),
                                          const SizedBox(height: 10,),
                                        ],
                                      ):model.type=='select'?Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                                          CustomDropDownTextField(list: model.options??[],onChanged: (value){
                                            controller.changeSelectedValue(value,index);
                                          },selectedValue: model.selectedValue,),
                                        ],
                                      ):model.type=='radio'?Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                                          CustomRadioButton(title:model.name,selectedIndex:controller.formList[index].options?.indexOf(model.selectedValue??'')??0,list: model.options??[],onChanged: (selectedIndex){
                                            controller.changeSelectedRadioBtnValue(index,selectedIndex);
                                          },),
                                        ],
                                      ):model.type=='checkbox'?Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                                          CustomCheckBox(selectedValue:controller.formList[index].cbSelected,list: model.options??[],onChanged: (value){
                                            controller.changeSelectedCheckBoxValue(index,value);
                                          },),
                                        ],
                                      ):model.type=='file'?Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                            child: ConfirmWithdrawFileItem(
                                              index:index
                                            )
                                          )
                                        ],
                                      ):const SizedBox(),

                                      const SizedBox(height: 5,),

                                    ],
                                  ),
                                );
                              }
                          ),
                          Visibility(
                              visible: controller.isTFAEnable,
                              child: Column(
                                children: [
                                  const SizedBox(height: Dimensions.space15),
                                  CustomTextField(
                                    needRequiredSign: true,
                                    needOutlineBorder: true,
                                    labelText: MyStrings.gogoleAuthenticatorCode.tr,
                                    hintText: '',
                                    textInputType: TextInputType.number,
                                    inputAction: TextInputAction.next,
                                    controller: TextEditingController(text: ''),
                                    onChanged: (value){
                                      controller.twoFactorCode = value;
                                    },
                                  ),
                                ],
                              )),
                          const SizedBox(height: Dimensions.space25),
                          controller.submitLoading ?
                          const Center(child:RoundedLoadingBtn()) :
                          Center(
                            child: RoundedButton(
                              color: MyColor.getButtonColor(),
                              press: () {
                                controller.submitConfirmWithdrawRequest();
                              },
                              text: MyStrings.submit.tr,
                              textColor: MyColor.getButtonTextColor(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ),
    );
  }
}