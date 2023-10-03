import 'package:hyip_lab/core/utils/method.dart';
import 'package:hyip_lab/core/utils/url.dart';
import 'package:hyip_lab/data/services/api_service.dart';

class FaqRepo{

  ApiClient apiClient;
  FaqRepo({required this.apiClient});

  Future<dynamic>loadFaq()async{

    String template = apiClient.getTemplateName();
    String url='${UrlContainer.baseUrl}${UrlContainer.faqEndPoint}?template=$template';
    final response=await apiClient.request(url,Method.getMethod,null);
    return response;
  }

}