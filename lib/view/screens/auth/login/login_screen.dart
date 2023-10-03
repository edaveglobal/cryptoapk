import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/routes/route.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/data/controller/auth/login_controller.dart';
import 'package:hyip_lab/data/repo/auth/login_repo.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import 'package:hyip_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:hyip_lab/view/components/rounded_button.dart';
import 'package:hyip_lab/view/components/text-field/custom_text_field.dart';
import 'package:hyip_lab/view/components/text/default_text.dart';
import 'package:hyip_lab/view/components/text/header_text.dart';
import 'package:hyip_lab/view/components/will_pop_widget.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {


    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    Get.put(LoginController(loginRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<LoginController>().remember = false;
    });

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopWidget(
      nextRoute: '',
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.getScreenBgColor(),
          body: GetBuilder<LoginController>(
            builder: (controller) => SingleChildScrollView(
              padding: Dimensions.screenPaddingHV,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: Dimensions.space30),
                  HeaderText(text: MyStrings.welcomeBack.tr),
                  const SizedBox(height: 15),
                  Padding(padding: const EdgeInsets.only(right: 55),
                  child:  DefaultText(text: MyStrings.subTittle, textStyle: interRegularDefault.copyWith(color: MyColor.getTextColor().withOpacity(0.8))),),
                  const SizedBox(height: 40),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomTextField(
                          controller: controller.emailController,
                          labelText: MyStrings.usernameOrEmail.tr,
                          hintText: MyStrings.usernameOrEmailHint.tr,
                          onChanged: (value){},
                          focusNode: controller.emailFocusNode,
                          nextFocus: controller.passwordFocusNode,
                          textInputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return MyStrings.fieldErrorMsg.tr;
                            } else {
                              return null;
                            }
                          },
                        ),

                        const SizedBox(height: 35),

                        CustomTextField(
                          labelText: MyStrings.password.tr,
                          hintText: MyStrings.passwordHint.tr,
                          controller: controller.passwordController,
                          focusNode: controller.passwordFocusNode,
                          onChanged: (value){},
                          isShowSuffixIcon: true,
                          isPassword: true,
                          textInputType: TextInputType.text,
                          inputAction: TextInputAction.done,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return MyStrings.fieldErrorMsg.tr;
                            } else {
                              return null;
                            }
                          },
                        ),

                        const SizedBox(height: 25),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: Checkbox(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                                        activeColor: MyColor.transparentColor,
                                        checkColor: MyColor.getPrimaryColor(),
                                        value: controller.remember,
                                        side: MaterialStateBorderSide.resolveWith(
                                              (states) => BorderSide(
                                              width: 1.0,
                                              color: controller.remember ? MyColor.getFieldEnableBorderColor() : MyColor.getFieldDisableBorderColor()
                                          ),
                                        ),
                                        onChanged: (value){
                                          controller.changeRememberMe();
                                        }
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  DefaultText(text: MyStrings.rememberMe.tr, textColor: MyColor.getTextColor())
                                ],
                              ),
                            ),
                            Expanded(child: TextButton(
                              onPressed: (){
                                controller.clearTextField();
                                Get.toNamed(RouteHelper.forgetPasswordScreen);
                              },
                              child: DefaultText(text: MyStrings.forgotPassword.tr, textColor: MyColor.getTextColor()),
                            ))
                          ],
                        ),
                        const SizedBox(height: 25),

                        controller.isSubmitLoading ? const RoundedLoadingBtn() : RoundedButton(
                            text: MyStrings.signIn.toUpperCase().tr,
                            color: MyColor.getButtonColor(),
                            textColor: MyColor.getButtonTextColor(),
                            press: (){
                              if(formKey.currentState!.validate()){
                                controller.loginUser();
                              }
                            }
                        ),
                        const SizedBox(height: 35),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(MyStrings.notRegistered.tr, overflow:TextOverflow.ellipsis,style: interRegularLarge.copyWith(color: MyColor.getTextColor2(), fontWeight: FontWeight.w500)),
                            const SizedBox(width: Dimensions.space5),
                            TextButton(
                              onPressed: (){
                                Get.offAndToNamed(RouteHelper.registrationScreen);
                              },
                              child: Text(MyStrings.signUp.tr, maxLines: 2, overflow:TextOverflow.ellipsis,style: interRegularLarge.copyWith(color: MyColor.getPrimaryColor())),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
