import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/routes/route.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/core/utils/util.dart';
import 'package:hyip_lab/data/controller/auth/forget_password/reset_password_controller.dart';
import 'package:hyip_lab/data/controller/common/theme_controller.dart';
import 'package:hyip_lab/data/repo/auth/login_repo.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import 'package:hyip_lab/view/components/appbar/custom_appbar.dart';
import 'package:hyip_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:hyip_lab/view/components/rounded_button.dart';
import 'package:hyip_lab/view/components/text-field/custom_text_field.dart';
import 'package:hyip_lab/view/components/text/default_text.dart';
import 'package:hyip_lab/view/components/text/header_text.dart';
import 'package:hyip_lab/view/components/will_pop_widget.dart';
import 'package:hyip_lab/view/screens/auth/registration/widget/validation_widget.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ThemeController themeController = ThemeController(sharedPreferences: Get.find());
    MyUtils.allScreensUtils(themeController.darkTheme);
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient:Get.find()));
    final controller =Get.put(ResetPasswordController(loginRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.email = Get.arguments[0];
      controller.code = Get.arguments[1];
    });

  }

  @override
  void dispose() {
    ThemeController themeController = ThemeController(sharedPreferences: Get.find());
    MyUtils.allScreensUtils(themeController.darkTheme);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.loginScreen,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: MyColor.getScreenBgColor(),
            appBar: CustomAppBar(title:MyStrings.resetPassword.tr, fromAuth: true, bgColor: MyColor.getAppbarBgColor()),
            body: GetBuilder<ResetPasswordController>(
              builder: (controller) => SingleChildScrollView(
                padding: Dimensions.screenPaddingHV,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: Dimensions.space30),
                      HeaderText(text: MyStrings.resetPassword.tr),
                      const SizedBox(height: Dimensions.space15),
                      DefaultText(text: MyStrings.resetPassContent.tr, textStyle: interRegularDefault.copyWith(color: MyColor.getTextColor().withOpacity(0.8))),
                      const SizedBox(height: Dimensions.space20),
                      Visibility(
                          visible: controller.hasPasswordFocus && controller.checkPasswordStrength,
                          child: ValidationWidget(list: controller.passwordValidationRulse, heightBottom: 15)),
                      Focus(
                        onFocusChange: (hasFocus){
                          controller.changePasswordFocus(hasFocus);
                        },
                        child: CustomTextField(
                            labelText: MyStrings.password.tr,
                            focusNode: controller.passwordFocusNode,
                            nextFocus: controller.confirmPasswordFocusNode,
                            hintText: MyStrings.passwordHint.tr,
                            isShowSuffixIcon: true,
                            isPassword: true,
                            textInputType: TextInputType.text,
                            controller: controller.passController,
                            validator: (value) {
                              return controller.validatPassword(value ?? '');
                            },
                            onChanged: (value) {
                              if(controller.checkPasswordStrength){
                                controller.updateValidationList(value);
                              }
                             return;
                            }
                        ),
                      ),
                      const SizedBox(height: Dimensions.space25),
                      CustomTextField(
                          inputAction: TextInputAction.done,
                          isPassword: true,
                          labelText: MyStrings.confirmPassword.tr,
                          hintText: MyStrings.confirmYourPassword.tr,
                          isShowSuffixIcon: true,
                          controller: controller.confirmPassController,
                          onChanged: (value){
                            return;
                          },
                          validator: (value) {
                          if (controller.passController.text.toLowerCase() != controller.confirmPassController.text.toLowerCase()) {
                            return MyStrings.kMatchPassError.tr;
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: Dimensions.space35),
                      controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
                        color: MyColor.getButtonColor(),
                        textColor: MyColor.getButtonTextColor(),
                        width: 1,
                        text: MyStrings.submit.tr,
                        press: () {
                          if (formKey.currentState!.validate()) {
                            controller.resetPassword();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ),
      ),
    );
  }
}

