
import 'dart:convert';

import 'package:get/get.dart';
import 'package:hyip_lab/core/helper/string_format_helper.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/data/model/global/response_model/response_model.dart';
import 'package:hyip_lab/data/model/plan/plan_model.dart';
import 'package:hyip_lab/data/repo/plan/plan_repo.dart';
import 'package:hyip_lab/view/components/show_custom_snackbar.dart';

class PlanController extends GetxController{

  PlanRepo planRepo;
  PlanController({required this.planRepo});

  bool isLoading = true;
  List<Plans> planList = [];
  String currency = '';
  String curSymbol = '';

  Future<void> getAllPackageData() async{
    selectedIndex = -1;
    isLoading = true;
    update();
    currency  = planRepo.apiClient.getCurrencyOrUsername();
    curSymbol = planRepo.apiClient.getCurrencyOrUsername(isSymbol: true);
    ResponseModel responseModel = await planRepo.getPackagesData();
    if(responseModel.statusCode == 200){
      PricingPlanModel planModel = PricingPlanModel.fromJson(jsonDecode(responseModel.responseJson));
      if(planModel.status.toString().toLowerCase() == "success"){
        List<Plans>? tempPackageList = planModel.data?.plans;
        if(tempPackageList != null && tempPackageList.isNotEmpty){
          planList.addAll(tempPackageList);
        }
      }
      else{
        CustomSnackBar.showCustomSnackBar(errorList: planModel.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    }
    else{
      CustomSnackBar.showCustomSnackBar(errorList: [], msg: [responseModel.message], isError: true);
    }

    isLoading = false;
    update();
  }

  int selectedIndex = 0;
  void changeSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }

  String  getAmount(int index) {
    double fixedAmt = double.tryParse(planList[index].fixedAmount??'')??0.0;
    if(fixedAmt>0){
      String formatedAmt = Converter.roundDoubleAndRemoveTrailingZero('$fixedAmt');
      return '$formatedAmt $currency';
    }else{
      String minimum = Converter.twoDecimalPlaceFixedWithoutRounding(planList[index].minimum??'0');
      String maximum = Converter.twoDecimalPlaceFixedWithoutRounding(planList[index].maximum??'0');
      return '$minimum - $maximum $currency';
    }
  }
  String  getTotalReturn(int index) {
    String totalReturn = planList[index].totalReturn??'';
    String value = totalReturn;
    try{
     List<String>tempList = totalReturn.split('+');
     value = tempList.first;
     if(tempList.length==2){
     value = '$value+ ';
     }
    }catch(e){
      value = totalReturn;
    }
    return value;
  }
}