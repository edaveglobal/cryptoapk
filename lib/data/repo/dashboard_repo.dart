import 'package:hyip_lab/core/utils/method.dart';
import 'package:hyip_lab/core/utils/url.dart';
import 'package:hyip_lab/data/model/global/response_model/response_model.dart';

import '../services/api_service.dart';




class DashboardRepo {

  ApiClient apiClient;
  DashboardRepo({required this.apiClient});
  String token = '', tokenType = '';

  Future<ResponseModel> getDashboardData() async{
    String url = '${UrlContainer.baseUrl}${UrlContainer.dashBoardUrl}';
    ResponseModel response = await apiClient.request(url,Method.getMethod, null,passHeader: true);
    return response;
  }

  Future<dynamic>getInvestmentData(String type,int page)async{
    String url='${UrlContainer.baseUrl}${UrlContainer.investUrl}?type=$type&take=10';
    final response=await apiClient.request(url,Method.getMethod,null,passHeader: true);
    return response;
  }


}
