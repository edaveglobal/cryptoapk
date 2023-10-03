import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyip_lab/core/routes/route.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/data/controller/auth/auth/registration_controller.dart';
import 'package:hyip_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:hyip_lab/view/components/rounded_button.dart';
import 'package:hyip_lab/view/components/text-field/custom_text_field.dart';
import 'package:hyip_lab/view/screens/auth/registration/widget/country_bottom_sheet.dart';
import 'package:hyip_lab/view/screens/auth/registration/widget/validation_widget.dart';

import 'country_text_field.dart';

class RegistrationForm extends StatefulWidget {

  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (controller){
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                labelText: MyStrings.username.tr,
                hintText: MyStrings.enterYourUsername.tr,
                controller: controller.userNameController,
                focusNode: controller.userNameFocusNode,
                textInputType: TextInputType.text,
                nextFocus: controller.emailFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return MyStrings.enterYourUsername.tr;
                  } else if(value.length<6){
                    return MyStrings.kShortUserNameError.tr;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  return;
                },
              ),
              const SizedBox(height: 25),
              CustomTextField(
                labelText: MyStrings.email.tr,
                hintText: MyStrings.enterYourEmail.tr,
                controller: controller.emailController,
                focusNode: controller.emailFocusNode,
                textInputType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                validator: (value) {
                  if (value!=null && value.isEmpty) {
                    return MyStrings.enterYourEmail.tr;
                  } else if(!MyStrings.emailValidatorRegExp.hasMatch(value??'')) {
                    return MyStrings.invalidEmailMsg.tr;
                  }else{
                    return null;
                  }
                },
                onChanged: (value) {
                  return;
                },
              ),
              const SizedBox(height: 25),
              CountryTextField(
                press: (){
                  CountryBottomSheet.bottomSheet(context, controller);
                },
                text:controller.countryName == null?MyStrings.selectACountry.tr:(controller.countryName)!.tr,
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child:CustomTextField(
                      labelText: MyStrings.phone,
                      controller: TextEditingController(text: controller.mobileCode!=null?'+${controller.mobileCode}':''),
                      textInputType: TextInputType.phone,
                      disableColor: controller.hasMobileFocus?MyColor.primaryColor:MyColor.borderColor,
                      isEnable: false,
                      onChanged: (value) {
                        return;
                      },
                    ),),
                  const SizedBox(width: 8,),
                  Expanded(
                      flex: 6,
                      child: Focus(
                        onFocusChange: (hasFocus){
                          controller.changeMobileFocus(hasFocus);
                        },
                        child:  CustomTextField(
                          labelText: '',
                          hintText: '',
                          controller: controller.mobileController,
                          focusNode: controller.mobileFocusNode,
                          textInputType: TextInputType.phone,
                          inputAction: TextInputAction.next,
                          onChanged: (value) {
                            return;
                          },
                          validator: (value){
                            if(value.toString().isEmpty){
                              return MyStrings.enterYourPhoneNumber.tr;
                            }
                            return null;
                          },
                        ),
                      )),
                ],
              ),
              Visibility(
                  visible: controller.hasPasswordFocus && controller.checkPasswordStrength,
                  child: ValidationWidget(list: controller.passwordValidationRulse,)),
              const SizedBox(height: 25),
              Focus(
                  onFocusChange: (hasFocus){
                    controller.changePasswordFocus(hasFocus);
                  },
                  child: CustomTextField(
                    isShowSuffixIcon: true,
                    isPassword: true,
                    labelText: MyStrings.password.tr,
                    controller: controller.passwordController,
                    focusNode: controller.passwordFocusNode,
                    nextFocus: controller.confirmPasswordFocusNode,
                    hintText: MyStrings.enterYourPassword_.tr,
                    textInputType: TextInputType.text,
                    onChanged: (value) {
                      if(controller.checkPasswordStrength){
                        controller.updateValidationList(value);
                      }
                    },
                    validator: (value) {
                      return controller.validatPassword(value ?? '');
                    },
                  )),
              const SizedBox(height: 25),
              CustomTextField(
                labelText: MyStrings.confirmPassword.tr,
                hintText: MyStrings.confirmYourPassword.tr,
                controller: controller.cPasswordController,
                focusNode: controller.confirmPasswordFocusNode,
                inputAction: TextInputAction.done,
                isShowSuffixIcon: true,
                isPassword: true,
                onChanged: (value) {},
                validator: (value) {
                  if (controller.passwordController.text.toLowerCase() != controller.cPasswordController.text.toLowerCase()) {
                    return MyStrings.kMatchPassError.tr;
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 25),
              Visibility(
                visible: controller.needAgree,
                child: Row(
                children: [
                  SizedBox(
                    width: 25,
                    height: 25,
                    child: Checkbox(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                        activeColor: MyColor.transparentColor,
                        checkColor: MyColor.getPrimaryColor(),
                        value: controller.agreeTC,
                        side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(
                              width: 1.0,
                              color: controller.agreeTC ? MyColor.getFieldEnableBorderColor() : MyColor.getFieldDisableBorderColor()
                          ),
                        ),
                        onChanged: (bool? value) {
                          controller.updateAgreeTC();
                        },
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Row(
                    children: [
                      Text(MyStrings.iAgreeWith.tr, style: interRegularDefault.copyWith(color: MyColor.getTextColor2())),
                      const SizedBox(width: 3),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(RouteHelper.privacyScreen);
                        },
                        child: Text(MyStrings.policies.tr.toLowerCase(), style: GoogleFonts.inter(
                            color: MyColor.getPrimaryColor(),
                            decoration: TextDecoration.underline,
                            decorationColor: MyColor.getPrimaryColor()
                        )),
                      ),
                      const SizedBox(width: 3),
                    ],
                  ),
                ],
              )),
              const SizedBox(height: 35),

              controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
                  text: MyStrings.signUp.toUpperCase().tr,
                  textColor: MyColor.getButtonTextColor(),
                  color: MyColor.getButtonColor(),
                  press: (){
                    if (formKey.currentState!.validate()) {
                      controller.signUpUser();
                    }
                  }
              ),
              const SizedBox(height: Dimensions.space35),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(MyStrings.alreadyAccount.tr, style: interRegularLarge.copyWith(color: MyColor.getTextColor2(), fontWeight: FontWeight.w500)),
                  const SizedBox(width: Dimensions.space5),
                  TextButton(
                    onPressed: (){
                      controller.clearAllData();
                      Get.offAndToNamed(RouteHelper.loginScreen);
                    },
                    child: Text(MyStrings.signIn.tr, style: interRegularLarge.copyWith(color: MyColor.getPrimaryColor())),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}