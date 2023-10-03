
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/routes/route.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/messages.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/data/controller/localization/localization_controller.dart';
import 'package:hyip_lab/data/model/global/response_model/response_model.dart';
import 'package:hyip_lab/data/model/language/language_model.dart';
import 'package:hyip_lab/data/repo/auth/general_setting_repo.dart';
import 'package:hyip_lab/view/components/show_custom_snackbar.dart';

import '../../../../../core/helper/shared_preference_helper.dart';

class LanguageDialogBody extends StatefulWidget {
  final List<LanguageModel>langList ;
  final bool fromSplashScreen;
  const LanguageDialogBody({Key? key,required this.langList,this.fromSplashScreen = false}) : super(key: key);

  @override
  State<LanguageDialogBody> createState() => _LanguageDialogBodyState();
}

class _LanguageDialogBodyState extends State<LanguageDialogBody> {

  int pressIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: Text(MyStrings.selectALanguage,style: interRegularDefault.copyWith(color:MyColor.getTextColor(),fontSize: Dimensions.fontLarge),),),
          const SizedBox(height: Dimensions.space15,),
          Flexible(child: ListView.builder(
              shrinkWrap: true,
              itemCount:  widget.langList.length,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: ()async{
                    setState(() {
                      pressIndex = index;
                    });
                    String languageCode = widget.langList[index].languageCode;
                    final repo = Get.put(GeneralSettingRepo(apiClient: Get.find()));
                    final localizationController = Get.put(LocalizationController(sharedPreferences: Get.find()));
                    ResponseModel response = await repo.getLanguage(languageCode);
                    if(response.statusCode == 200){
                      try{
                        Map<String,Map<String,String>> language = {};
                        var resJson = jsonDecode(response.responseJson);
                        await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageListKey, response.responseJson);
                        var value = jsonDecode(resJson['data']['file']) as Map<String,dynamic>;
                        Map<String,String> json = {};
                        value.forEach((key, value) {
                          json[key] = value.toString();
                        });

                        language['${widget.langList[index].languageCode}_${'US'}'] = json;

                        Get.clearTranslations();
                        Get.addTranslations(Messages(languages: language).keys);

                        Locale local = Locale(widget.langList[index].languageCode,'US');
                        localizationController.setLanguage(local);
                        if(widget.fromSplashScreen){
                          Get.offAndToNamed(RouteHelper.loginScreen,);
                        }else{
                          Get.back();
                        }
                      }catch(e){
                        CustomSnackBar.showCustomSnackBar(errorList: [e.toString()], msg: [], isError: true);
                      }

                    } else{
                      CustomSnackBar.showCustomSnackBar(errorList: [response.message], msg: [], isError: true);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                    decoration: BoxDecoration(color: MyColor.getCardBg(), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                    child: pressIndex==index?const  Center(
                      child: SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(color: MyColor.primaryColor)),
                    ):Text(
                     ( widget.langList[index].languageName).tr,
                      style: interRegularDefault.copyWith(color: MyColor.getTextColor()),
                    ),
                  ),
                );
              })),
        ],
      ),
    );
  }
}
