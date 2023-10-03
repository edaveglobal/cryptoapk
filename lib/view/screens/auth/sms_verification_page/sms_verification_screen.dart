import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_images.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/data/controller/auth/auth/sms_verification_controler.dart';
import 'package:hyip_lab/data/repo/auth/sms_email_verification_repo.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import 'package:hyip_lab/view/components/appbar/custom_appbar.dart';
import 'package:hyip_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:hyip_lab/view/components/rounded_button.dart';
import 'package:hyip_lab/view/components/text/small_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class SmsVerificationScreen extends StatefulWidget {
  const SmsVerificationScreen({Key? key}) : super(key: key);

  @override
  State<SmsVerificationScreen> createState() => _SmsVerificationScreenState();
}

class _SmsVerificationScreenState extends State<SmsVerificationScreen> {
  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SmsEmailVerificationRepo(apiClient: Get.find()));
   final controller = Get.put(SmsVerificationController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.isProfileCompleteEnable = Get.arguments[0];
      controller.loadBefore();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar: CustomAppBar(
          fromAuth: true,
          title: MyStrings.smsVerification.tr,
          isShowBackBtn: true,
          isShowActionBtn: false,
          bgColor: MyColor.getAppbarBgColor(),
        ),
        body: GetBuilder<SmsVerificationController>(
          builder: (controller) => controller.isLoading ? Center(
              child: CircularProgressIndicator(color: MyColor.getPrimaryColor())
          ) : SingleChildScrollView(
              padding: Dimensions.screenPaddingHV,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: Dimensions.space30),
                    Container(
                      height: 100, width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: MyColor.getCardBg(),
                          shape: BoxShape.circle
                      ),
                      child: SvgPicture.asset(MyImages.emailVerifyImage, height: 50, width: 50, color: MyColor.getPrimaryColor()),
                    ),
                    const SizedBox(height: Dimensions.space50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30 ),
                      child: SmallText(text: MyStrings.smsVerificationMsg.tr, textAlign: TextAlign.center, textStyle: interRegularDefault.copyWith(color: MyColor.getLabelTextColor())),
                    ),
                    const SizedBox(height: 30),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: interRegularDefault.copyWith(color: MyColor.getPrimaryColor()),
                        length: 6,
                        textStyle: interRegularDefault.copyWith(color: MyColor.getPrimaryColor()),
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
                        animationDuration:
                        const Duration(milliseconds: 100),
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
                    const SizedBox(height: Dimensions.space30),

                    controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
                      text: MyStrings.verify.tr,
                      textColor: MyColor.getButtonTextColor(),
                      press: (){
                        controller.verifyYourSms(controller.currentText);
                      },
                      color: MyColor.getButtonColor(),
                    ),
                    const SizedBox(height: Dimensions.space30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(MyStrings.didNotReceiveCode.tr, style: interRegularDefault.copyWith(color: MyColor.getLabelTextColor())),
                        const SizedBox(width: Dimensions.space10),
                        controller.resendLoading ?
                        Container(margin: const EdgeInsets.all(5),height:20,width:20,child: CircularProgressIndicator(color: MyColor.getPrimaryColor(),)):
                        GestureDetector(
                            onTap: () {
                              controller.sendCodeAgain();
                            },
                            child: Text(
                                MyStrings.resend.tr,
                                style: interRegularDefault.copyWith(decoration: TextDecoration.underline, color: MyColor.getPrimaryColor())
                            )
                        ),
                      ],
                    )
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}








