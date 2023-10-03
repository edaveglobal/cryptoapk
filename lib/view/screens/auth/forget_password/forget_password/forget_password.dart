import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/core/utils/util.dart';
import 'package:hyip_lab/data/controller/auth/forget_password/forget_password_controller.dart';
import 'package:hyip_lab/data/controller/common/theme_controller.dart';
import 'package:hyip_lab/data/repo/auth/login_repo.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import 'package:hyip_lab/view/components/appbar/custom_appbar.dart';
import 'package:hyip_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:hyip_lab/view/components/text-field/custom_text_field.dart';
import 'package:hyip_lab/view/components/rounded_button.dart';
import 'package:hyip_lab/view/components/text/default_text.dart';
import 'package:hyip_lab/view/components/text/header_text.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ThemeController themeController =
        ThemeController(sharedPreferences: Get.find());
    MyUtils.allScreensUtils(themeController.darkTheme);

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    Get.put(ForgetPasswordController(loginRepo: Get.find()));

    super.initState();
  }

  @override
  void dispose() {
    ThemeController themeController =
        ThemeController(sharedPreferences: Get.find());
    MyUtils.allScreensUtils(themeController.darkTheme);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: MyColor.getScreenBgColor(),
          appBar: CustomAppBar(
            fromAuth: true,
            isShowBackBtn: true,
            title: MyStrings.forgetPassword.tr,
            bgColor: MyColor.getAppbarBgColor(),
          ),
          body: GetBuilder<ForgetPasswordController>(
            builder: (auth) => SingleChildScrollView(
              padding: Dimensions.screenPaddingHV,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Dimensions.space30),
                    HeaderText(text: MyStrings.recoverAccount.tr),
                    const SizedBox(height: 15),
                    DefaultText(
                        text: MyStrings.forgetPasswordSubText.tr,
                        textStyle: interRegularDefault.copyWith(
                            color: MyColor.getTextColor().withOpacity(0.8))),
                    const SizedBox(height: Dimensions.space40),
                    CustomTextField(
                        labelText: MyStrings.usernameOrEmail.tr,
                        hintText: MyStrings.usernameOrEmailHint.tr,
                        textInputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.done,
                        controller: auth.emailOrUsernameController,
                        onSuffixTap: () {},
                        onChanged: (value) {
                          return;
                        },
                        validator: (value) {
                          if (auth.emailOrUsernameController.text.isEmpty) {
                            return MyStrings.enterEmailOrUserName.tr;
                          } else {
                            return null;
                          }
                        }),
                    const SizedBox(height: Dimensions.space25),
                    auth.submitLoading
                        ? const RoundedLoadingBtn()
                        : RoundedButton(
                            press: () {
                              if(_formKey.currentState!.validate()){
                                auth.submitForgetPassCode();
                              }
                            },
                            text: MyStrings.submit.tr,
                            textColor: MyColor.getButtonTextColor(),
                            color: MyColor.getButtonColor(),
                          ),
                    const SizedBox(height: Dimensions.space40)
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
