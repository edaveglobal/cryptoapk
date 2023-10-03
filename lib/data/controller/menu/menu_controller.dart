import 'dart:convert';

import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/data/model/general_setting/general_settings_response_model.dart';
import 'package:hyip_lab/data/model/global/response_model/response_model.dart';
import 'package:hyip_lab/data/repo/auth/general_setting_repo.dart';
import 'package:hyip_lab/view/components/show_custom_snackbar.dart';

class MenuController extends GetxController  {

  GeneralSettingRepo repo;
  bool isLoading = true;
  bool noInternet = false;

  bool balTransferEnable = true;
  bool langSwitchEnable = true;

  MenuController({required this.repo});

  void loadData()async{
    isLoading = true;
    update();
    await configureMenuItem();
    isLoading = false;
    update();
  }

  configureMenuItem()async{

    ResponseModel response = await repo.getGeneralSetting();

    if(response.statusCode==200){
      GeneralSettingsResponseModel model =
      GeneralSettingsResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase()==MyStrings.success.toLowerCase()) {
        bool langStatus = model.data?.generalSetting?.langSwitch == '0'?false:true;
        bool bTransferStatus  = model.data?.generalSetting?.bTransfer== '0'?false:true;
        langSwitchEnable = langStatus;
        balTransferEnable = bTransferStatus;
        repo.apiClient.storeGeneralSetting(model);
        update();
      }
      else {
        List<String>message=[MyStrings.somethingWentWrong];
        CustomSnackBar.error(errorList:model.message?.error??message);
        return;
      }
    }else{
      if(response.statusCode==503){
        noInternet=true;
        update();
      }
      CustomSnackBar.error(errorList:[response.message]);
      return;
    }
  }

}