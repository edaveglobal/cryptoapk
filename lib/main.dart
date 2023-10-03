import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/routes/route.dart';
import 'package:hyip_lab/core/theme/dark.dart';
import 'package:hyip_lab/core/theme/light.dart';
import 'package:hyip_lab/core/utils/messages.dart';
import 'package:hyip_lab/data/controller/localization/localization_controller.dart';
import 'core/utils/my_strings.dart';
import 'data/controller/common/theme_controller.dart';
import 'core/di_service/di_services.dart' as di_service;
import 'view/push_notification_service.dart';


Future<void> _messageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Map<String, Map<String, String>> languages = await di_service.init();

  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  await PushNotificationService().setupInteractedMessage();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp(languages: languages));

}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({Key? key,required this.languages}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (theme){
     return GetBuilder<LocalizationController>(builder: (localizeController){
       return GetMaterialApp(
         title:MyStrings.appName,
         initialRoute: RouteHelper.splashScreen,
         defaultTransition: Transition.topLevel,
         transitionDuration: const Duration(milliseconds: 200),
         getPages: RouteHelper.routes,
         navigatorKey: Get.key,
         theme: theme.darkTheme?dark:light,
         debugShowCheckedModeBanner: false,
         locale: localizeController.locale,
         translations: Messages(languages: languages),
         fallbackLocale: Locale(localizeController.locale.languageCode, localizeController.locale.countryCode),
       );
     });
    });
  }


}
