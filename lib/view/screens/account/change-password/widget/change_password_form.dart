import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/data/controller/account/change_password_controller.dart';
import 'package:hyip_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:hyip_lab/view/components/rounded_button.dart';
import 'package:hyip_lab/view/components/text-field/custom_text_field.dart';

class ChangePasswordForm extends StatefulWidget {

  const ChangePasswordForm({Key? key}) : super(key: key);

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ChangePasswordController>(
        builder: (controller) => Form(
          key: formKey,
          child: Column(
            children: [

              CustomTextField(
                labelText: MyStrings.currentPassword.tr,
                hintText: MyStrings.enterCurrentPassword.tr,
                onChanged: (value){
                  return ;
                },
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return  MyStrings.enterCurrentPass.tr;
                  } else {
                    return null;
                  }
                },
                controller: controller.currentPassController,
                isShowSuffixIcon: true,
                isPassword: true,
              ),
              const SizedBox(height: 20),

              CustomTextField(
                  labelText: MyStrings.newPassword.tr,
                  hintText: MyStrings.enterNewPassword.tr,
                  onChanged: (value){
                    return ;
                  },
                  validator: (value) {
                  if (value.toString().isEmpty) {
                    return  MyStrings.enterNewPass.tr;
                  } else {
                    return null;
                  }
                 },
                  controller: controller.passController,
                  isShowSuffixIcon: true,
                  isPassword: true,
              ),
              const SizedBox(height: 20),

              CustomTextField(
                  labelText: MyStrings.confirmPassword.tr,
                  hintText: MyStrings.enterConfirmPassword.tr,
                  onChanged: (value){
                    return ;
                  },
                  validator: (value) {
                    if (controller.confirmPassController.text != controller.passController.text) {
                      return  MyStrings.kMatchPassError.tr;
                    } else {
                      return null;
                    }
                  },
                  controller: controller.confirmPassController,
                  isShowSuffixIcon: true,
                  isPassword: true,
              ),
              const SizedBox(height: 30),

              controller.submitLoading?
              const RoundedLoadingBtn():
              RoundedButton(
                text: MyStrings.submit.tr,
                color: MyColor.getButtonColor(),
                textColor: MyColor.getButtonTextColor(),
                press: (){

                  if (formKey.currentState!.validate()) {
                    controller.changePassword();
                  }
                }
              )
            ],
          ),
        )
    );
  }
}
