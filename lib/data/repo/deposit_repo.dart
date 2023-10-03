
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/method.dart' as method;
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/url.dart';
import 'package:hyip_lab/data/model/authorized/deposit/deposit_history_response_model.dart';
import 'package:hyip_lab/data/model/authorized/deposit/deposit_insert_method.dart';
import 'package:hyip_lab/data/model/authorized/deposit/deposit_insert_response_model.dart';

import '../../view/components/show_custom_snackbar.dart';
import '../model/global/response_model/response_model.dart';
import '../services/api_service.dart';

class DepositRepo{
  ApiClient apiClient;
  DepositRepo({required this.apiClient});
  Future<dynamic> getDepositHistory({int page=-1,bool isSearch=false,String? trx='-1'}) async{

    Map<String, dynamic> params = isSearch?{'search': trx}:{'page':page};

    String url='${UrlContainer.baseUrl}${UrlContainer.depositHistoryUrl}${isSearch?'?search=$trx':'?page=$page'}';
    ResponseModel response= await apiClient.request(url,method.Method.getMethod, params,passHeader: true);

    if (kDebugMode) {
      print(response.responseJson);
      print(response.statusCode);
    }

    if(response.statusCode==200){
      DepositHistoryResponseModel model =
      DepositHistoryResponseModel.fromJson(jsonDecode(response.responseJson));
      if (!(model.status=='error')) {
        return model;
      } else {
        CustomSnackBar.showCustomSnackBar(errorList: model.message?.error??['Unknown Validation Error'], msg: [], isError: true);
        return model;
      }
    }
    else{
      return DepositHistoryResponseModel();
    }

  }

  Future<dynamic>getDepositMethod() async {

    String url='${UrlContainer.baseUrl}${UrlContainer.depositMethodUrl}';
    ResponseModel response= await apiClient.request(url,method.Method.getMethod, null,passHeader: true);
    return response;
  }


  Future<dynamic>insertDeposit(DepositInsertModel model)async{

    String url='${UrlContainer.baseUrl}${UrlContainer.depositInsertUrl}';

    Map<String,dynamic>param={
      'method_code':model.methodCode.toString(),
      'amount':model.amount.toString(),
      'currency':model.currency
    };

    ResponseModel response= await apiClient.request(url,method.Method.postMethod, param,passHeader: true);

    if(response.statusCode==200){

      DepositInsertResponseModel model =
      DepositInsertResponseModel.fromJson(jsonDecode(response.responseJson));

      if (model.message?.success!=null) {
        return model;
      }
      else {
        CustomSnackBar.showCustomSnackBar(
            errorList: model.message?.error??[MyStrings.somethingWentWrong.tr],
            msg: [],
            isError: true);
        return model;
      }
    }else{
      return DepositInsertResponseModel();
    }
  }

  Future<dynamic>getUserInfo() async {
    String url='${UrlContainer.baseUrl}${UrlContainer.getProfileEndPoint}';
    ResponseModel response= await apiClient.request(url,method.Method.getMethod, null,passHeader: true);
    return response;
  }

  Future<ResponseModel>submitInvestment(Map<String,dynamic>params)async{
    String url = '${UrlContainer.baseUrl}${UrlContainer.investStoreUrl}';
    ResponseModel model = await apiClient.request(url,method.Method.postMethod, params,passHeader: true);
    return model;
  }



}