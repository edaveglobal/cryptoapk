
import 'dart:convert';

import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/method.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/url.dart';
import 'package:hyip_lab/data/model/global/response_model/response_model.dart';

import '../../../view/components/show_custom_snackbar.dart';
import '../../model/authorization/authorization_response_model.dart';
import '../../services/api_service.dart';

class ChangePasswordRepo{

 ApiClient apiClient;

 ChangePasswordRepo({required this.apiClient});
 String token = '', tokenType = '';

 Future<bool> changePassword(String currentPass, String password) async{
  final params = modelToMap(currentPass,password);
  String url = '${UrlContainer.baseUrl}${UrlContainer.changePasswordEndPoint}';

  ResponseModel responseModel= await apiClient.request(url, Method.postMethod, params,passHeader: true);
  if(responseModel.statusCode==200){
   AuthorizationResponseModel model=AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
   if(model.message?.success!=null && model.message!.success!.isNotEmpty){

    CustomSnackBar.showCustomSnackBar(
        errorList: [],
        msg: model.message?.success??[MyStrings.passwordChanged.tr],
        isError: false);

    return true;

   }else{

    CustomSnackBar.showCustomSnackBar(errorList: model.message?.error??[MyStrings.requestFail.tr], msg: [], isError: true);
    return false;

   }
  }else{
   //handle error
   return false;
  }
 }

 modelToMap(String currentPassword,String newPass) {

  Map<String,dynamic>map2={
   'current_password':currentPassword,
   'password':newPass,
   'password_confirmation':newPass
  };
  return map2;
 }

}