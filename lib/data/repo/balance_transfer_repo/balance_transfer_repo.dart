

import 'package:hyip_lab/core/utils/method.dart';
import 'package:hyip_lab/data/model/global/response_model/response_model.dart';
import 'package:hyip_lab/data/services/api_service.dart';

import '../../../core/utils/url.dart';

class BalanceTransferRepo{

  ApiClient apiClient;
  BalanceTransferRepo({required this.apiClient});


  Future<ResponseModel> transferBalance(String username,String amount,String wallet,String code) async{
    late Map<String, String> map;
    if(code.isNotEmpty){
      map = {'username': username, 'amount': amount,'wallet':wallet,'authenticator_code':code};
    } else{
      map = {'username': username, 'amount': amount,'wallet':wallet};
    }

    String url = '${UrlContainer.baseUrl}${UrlContainer.balanceTransfer}';
    ResponseModel model=await apiClient.request(url, Method.postMethod, map,passHeader: true);
    return model;
  }


}