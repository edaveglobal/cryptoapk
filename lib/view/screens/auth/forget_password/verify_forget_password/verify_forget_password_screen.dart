import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_images.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/data/controller/auth/forget_password/verify_password_controller.dart';
import 'package:hyip_lab/data/repo/auth/login_repo.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import 'package:hyip_lab/view/components/appbar/custom_appbar.dart';
import 'package:hyip_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:hyip_lab/view/components/rounded_button.dart';
import 'package:hyip_lab/view/components/text/default_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyForgetPassScreen extends StatefulWidget {
  const VerifyForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<VerifyForgetPassScreen> createState() => _VerifyForgetPassScreenState();
}

class _VerifyForgetPassScreenState extends State<VerifyForgetPassScreen> {



  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient:Get.find()));
    final controller=Get.put(VerifyPasswordController(loginRepo: Get.find()));
    controller.email=Get.arguments;
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: MyColor.getScreenBgColor(),
          appBar: CustomAppBar(
            fromAuth: true,
            isShowBackBtn: true,
            bgColor: MyColor.getAppbarBgColor(),
            title: MyStrings.passVerification.tr,
          ),
          body: GetBuilder<VerifyPasswordController>(
              builder: (controller) => controller.isLoading ?
              Center(
                  child: CircularProgressIndicator(color: MyColor.getPrimaryColor())
              ) : SingleChildScrollView(
                  padding: Dimensions.screenPaddingHV,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: Dimensions.space50),

                        Container(
                          height: 100, width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: MyColor.getCardBg(),
                              shape: BoxShape.circle
                          ),
                          child: SvgPicture.asset(MyImages.emailVerifyImage, height: 50, width: 50, color: MyColor.getPrimaryColor()),
                        ),
                        const SizedBox(height: Dimensions.space25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: DefaultText(text: MyStrings.verifyPasswordSubText.tr, textAlign: TextAlign.center, textColor: MyColor.getSecondaryTextColor())),
                        const SizedBox(height: Dimensions.space40),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30),
                          child: PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: interRegularDefault.copyWith(color: MyColor.getPrimaryColor()),
                            length: 6,
                            textStyle: interRegularDefault.copyWith(color: MyColor.getTextColor()),
                            obscureText: false,
                            obscuringCharacter: '*',
                            blinkWhenObscuring: false,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderWidth: 1,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 40,
                                fieldWidth: 40,
                                inactiveColor:  MyColor.getFieldDisableBorderColor(),
                                inactiveFillColor: MyColor.getScreenBgColor(),
                                activeFillColor: MyColor.getScreenBgColor(),
                                activeColor: MyColor.getPrimaryColor(),
                                selectedFillColor: MyColor.getScreenBgColor(),
                                selectedColor: MyColor.getPrimaryColor()
                            ),
                            cursorColor: MyColor.getTextColor(),
                            animationDuration: const Duration(milliseconds: 100),
                            enableActiveFill: true,
                            keyboardType: TextInputType.number,
                            beforeTextPaste: (text) {
                              return true;
                            },
                            onChanged: (value) {
                              setState(() {
                                controller.currentText = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: Dimensions.space25),

                        controller.verifyLoading ? const RoundedLoadingBtn() : RoundedButton(
                            color: MyColor.getButtonColor(),
                            textColor: MyColor.getButtonTextColor(),
                            text: MyStrings.verify.tr,
                            press: () {
                              if (controller.currentText.length != 6) {
                                controller.hasError=true;
                              }
                              else {
                                controller.verifyForgetPasswordCode(controller.currentText);
                              }
                            }
                        ),
                        const SizedBox(height: Dimensions.space25),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultText(text: MyStrings.didNotReceiveCode.tr, textColor: MyColor.getTextColor2()),
                            const SizedBox(width: Dimensions.space5),
                           controller.isResendLoading?
                           const SizedBox(
                             height: 17,
                             width: 17,
                             child: CircularProgressIndicator(color: MyColor.primaryColor,),):
                           TextButton(
                              onPressed: (){
                                controller.resendForgetPassCode();
                              },
                              child: DefaultText(text: MyStrings.resend.tr, textStyle: interRegularDefault.copyWith(color: MyColor.getPrimaryColor())
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
              )
          )
      ),
    );
  }
}

