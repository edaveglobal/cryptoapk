

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/helper/shared_preference_helper.dart';
import 'package:hyip_lab/core/routes/route.dart';
import 'package:hyip_lab/core/utils/messages.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/data/controller/localization/localization_controller.dart';

import '../../../../view/components/show_custom_snackbar.dart';
import '../../model/general_setting/general_settings_response_model.dart';
import '../../model/global/response_model/response_model.dart';
import '../../repo/auth/general_setting_repo.dart';



class SplashController extends GetxController  {

  GeneralSettingRepo repo;
  LocalizationController localizationController;
  bool isLoading = true;

  SplashController({required this.repo,required this.localizationController});

  gotoNextPage() async {

    await loadLanguage();

    bool isRemember = repo.apiClient.sharedPreferences
        .getBool(SharedPreferenceHelper.rememberMeKey) ?? false;
    noInternet=false;
    update();

    initSharedData();


    try{
      RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null && initialMessage.data.isNotEmpty) {

      }else{
        getGSData(isRemember);
        return;
      }

    }catch(e){
      getGSData(isRemember);
      //Get.offAndToNamed(RouteHelper.loginScreen);
    }


  }

  bool noInternet=false;
  void getGSData(bool isRemember)async{
    ResponseModel response = await repo.getGeneralSetting();
    if(response.statusCode==200){
      GeneralSettingsResponseModel model =
      GeneralSettingsResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase()==MyStrings.success) {
        repo.apiClient.storeGeneralSetting(model);
      }
      else {
        List<String>message=[MyStrings.somethingWentWrong];
        CustomSnackBar.showCustomSnackBar(errorList:model.message?.error??message, msg:[], isError: true);
        return;
      }
    }else{
      if(response.statusCode==503){
        noInternet=true;
        update();
      }
      CustomSnackBar.showCustomSnackBar(errorList:[response.message], msg:[], isError: true);
      return;
    }


    isLoading = false;
    update();


    if (isRemember) {
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAndToNamed(RouteHelper.homeScreen);
      });
    }
    else {
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAndToNamed(RouteHelper.loginScreen);
      });
    }
  }


  Future<bool> initSharedData() {

    if(!repo.apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.countryCode)) {
      return repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.countryCode, MyStrings.languages[0].countryCode);
    }
    if(!repo.apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.languageCode)) {
      return repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageCode, MyStrings.languages[0].languageCode);
    }

    return Future.value(true);
  }

  Future<void>loadLanguage()async{
    localizationController.loadCurrentLanguage();
    String languageCode = localizationController.locale.languageCode;
    ResponseModel response = await repo.getLanguage(languageCode);
    if(response.statusCode == 200){
      try{
        Map<String,Map<String,String>> language = {};
        var resJson = jsonDecode(response.responseJson);
        saveLanguageList(response.responseJson);
        var value = jsonDecode(resJson['data']['file']) as Map<String,dynamic>;
        print(value.toString());
        Map<String,String> json = {};
        value.forEach((key, value) {
          json[key] = value.toString();
        });
        language['${localizationController.locale.languageCode}_${localizationController.locale.countryCode}'] = json;
        Get.addTranslations(Messages(languages: language).keys);
      }catch(e){
        CustomSnackBar.showCustomSnackBar(errorList: [e.toString()], msg: [], isError: true);
      }

    } else{
      CustomSnackBar.showCustomSnackBar(errorList: [response.message], msg: [], isError: true);
    }

  }

  void saveLanguageList(String languageJson)async{
    await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageListKey, languageJson);
    return;
  }


}
