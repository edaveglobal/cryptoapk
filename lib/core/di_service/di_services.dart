import 'package:get/get.dart';
import 'package:hyip_lab/data/controller/localization/localization_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/controller/common/theme_controller.dart';
import '../../data/controller/splash/splash_controller.dart';
import '../../data/repo/auth/general_setting_repo.dart';
import '../../data/repo/splash/splash_repo.dart';
import '../../data/services/api_service.dart';

Future<Map<String, Map<String, String>>> init()async{

  final sharedPreferences=await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(sharedPreferences: Get.find()));
  Get.lazyPut(() => GeneralSettingRepo(apiClient: Get.find()));
  Get.lazyPut(() => SplashRepo(apiClient: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(repo:Get.find(),localizationController: Get.find()));
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => GeneralSettingRepo(apiClient: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));

  Map<String,Map<String,String>> language = {};
  language['en_US'] = {'':''};

  return language;

}
