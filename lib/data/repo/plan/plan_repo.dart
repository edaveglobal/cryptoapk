import 'package:hyip_lab/core/utils/method.dart';
import 'package:hyip_lab/core/utils/url.dart';
import 'package:hyip_lab/data/model/global/response_model/response_model.dart';
import 'package:hyip_lab/data/services/api_service.dart';

class PlanRepo{

  ApiClient apiClient;
  PlanRepo({required this.apiClient});

  // get package data
  Future<ResponseModel> getPackagesData() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.planEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

}