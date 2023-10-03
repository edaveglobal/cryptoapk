import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:hyip_lab/core/routes/route.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/data/model/authorization/authorization_response_model.dart';
import 'package:hyip_lab/data/model/global/response_model/response_model.dart';
import 'package:hyip_lab/data/repo/auth/sms_email_verification_repo.dart';
import 'package:hyip_lab/view/components/show_custom_snackbar.dart';

class EmailVerificationController extends GetxController {


  SmsEmailVerificationRepo repo;

  EmailVerificationController({required this.repo});


  String currentText = "";
  bool needSmsVerification = false;
  bool isProfileCompleteEnable = false;

  bool needTwoFactor = false;
  bool submitLoading = false;
  bool isLoading = false;
  bool resendLoading = false;

  loadData() async {
    isLoading = true;
    update();
    await repo.sendAuthorizationRequest();
    isLoading = false;
    update();
  }


  Future<void> verifyEmail(String text) async {

    if (text.isEmpty) {
      CustomSnackBar.showCustomSnackBar(errorList: [MyStrings.otpFieldEmptyMsg], msg: [], isError: true);
      return;
    }

    submitLoading=true;
    update();

    ResponseModel responseModel = await repo.verify(text);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if (model.status == MyStrings.success) {

          CustomSnackBar.showCustomSnackBar(errorList: [], msg: model.message?.success??[(MyStrings.emailVerificationSuccess)] , isError: false);

          if(needSmsVerification){
            Get.offAndToNamed(RouteHelper.smsVerificationScreen, arguments: [isProfileCompleteEnable,needTwoFactor]);
          } else if(needTwoFactor){
            Get.offAndToNamed( RouteHelper.twoFactorScreen,arguments: isProfileCompleteEnable);
          }
          else{
            Get.offAndToNamed(isProfileCompleteEnable?
            RouteHelper.profileCompleteScreen : RouteHelper.homeScreen,);
          }

      } else {
         CustomSnackBar.showCustomSnackBar(errorList: model.message?.error??[(MyStrings.emailVerificationFailed)] , msg: [], isError: true);
        }
    }
    else {
        CustomSnackBar.showCustomSnackBar(errorList: [responseModel.message] , msg: [], isError: true);
    }

    submitLoading=false;
    update();

  }



  Future<void> sendCodeAgain() async {
    resendLoading = true;
    update();
    await repo.resendVerifyCode(isEmail: true);
    resendLoading = false;
    update();
  }




}
