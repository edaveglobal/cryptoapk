
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/routes/route.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/data/model/global/response_model/response_model.dart';
import 'package:hyip_lab/data/model/withdraw/withdraw_method_response_model.dart';
import 'package:hyip_lab/data/model/withdraw/withdraw_request_response_model.dart';
import 'package:hyip_lab/data/repo/withdraw/withdraw_repo.dart';

import '../../../core/helper/string_format_helper.dart';
import '../../../view/components/show_custom_snackbar.dart';

class AddNewWithdrawController extends GetxController{

  WithdrawRepo repo;
  AddNewWithdrawController({required this.repo});
  bool isLoading = true;
  List<WithdrawMethod>withdrawMethodList=[];
  String currency='';

  TextEditingController amountController=TextEditingController();

  WithdrawMethod? withdrawMethod=WithdrawMethod();
  String depositLimit='';
  String charge='';
  String payableText = '';
  String conversionRate = '';
  String inLocal = '';





  double rate = 1;
  double mainAmount = 0;
  setWithdrawMethod(WithdrawMethod?method){

    withdrawMethod = method;
    depositLimit   = '${MyStrings.depositLimit.tr}: ${Converter.twoDecimalPlaceFixedWithoutRounding(method?.minLimit??'-1')} - ${Converter.twoDecimalPlaceFixedWithoutRounding(method?.maxLimit?.toString()??'-1')} ${method?.currency}';
    charge         = '${MyStrings.charge.tr}: ${Converter.twoDecimalPlaceFixedWithoutRounding(method?.fixedCharge?.toString()??'0')} + ${Converter.twoDecimalPlaceFixedWithoutRounding(method?.percentCharge?.toString()??'0')} %';
    update();

    String amt = amountController.text.toString();
    mainAmount = amt.isEmpty?0:double.tryParse(amt)??0;
    withdrawMethod = method;
    depositLimit   =
    '${Converter.twoDecimalPlaceFixedWithoutRounding(
        method?.minLimit?.toString() ?? '-1')} - ${Converter
        .twoDecimalPlaceFixedWithoutRounding(
        method?.maxLimit?.toString() ?? '-1')} $currency';
    changeInfoWidgetValue(mainAmount);
    update();
  }

  void changeInfoWidgetValue(double amount){

    mainAmount = amount;
    double percent = double.tryParse(withdrawMethod?.percentCharge??'0')??0;
    double percentCharge = (amount*percent)/100;
    double temCharge = double.tryParse(withdrawMethod?.fixedCharge??'0')??0;
    double totalCharge = percentCharge+temCharge;
    charge = '${Converter.twoDecimalPlaceFixedWithoutRounding('$totalCharge')} $currency';
    double payable = amount - totalCharge;
    payableText = '$payable $currency';

    rate = double.tryParse(withdrawMethod?.rate??'0')??0;
    conversionRate = '1 $currency = $rate ${withdrawMethod?.currency??''}';
    inLocal = Converter.twoDecimalPlaceFixedWithoutRounding('${payable*rate}');
    update();
    return;
  }


    Future<void>loadDepositMethod()async{

    currency = repo.apiClient.getCurrencyOrUsername();
    clearPreviousValue();
    WithdrawMethod method1 = WithdrawMethod(id: -1,name:MyStrings.selectOne,currency:"",minLimit:"0",maxLimit:"0",percentCharge:"",fixedCharge:"",rate:"");
    withdrawMethodList.insert(0, method1);
    setWithdrawMethod(withdrawMethodList[0]);

    isLoading = true;
    update();

    ResponseModel responseModel = await repo.getAllWithdrawMethod();

    if(responseModel.statusCode==200){

      WithdrawMethodResponseModel model=WithdrawMethodResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if(model.status ==  'success'){

        List<WithdrawMethod>?tempMethodList=model.data?.withdrawMethod;
        if(tempMethodList!=null && tempMethodList.isNotEmpty){
          withdrawMethodList.addAll(tempMethodList);
        }


      }else{
        CustomSnackBar.error(errorList: model.message?.error??[MyStrings.somethingWentWrong],);
      }
    }else{
      CustomSnackBar.error(errorList:[responseModel.message]);
    }
    isLoading = false;
    update();
    }

    bool submitLoading = false;
    Future<void>submitWithdrawRequest()async{
      String amount=amountController.text;
      String id =withdrawMethod?.id.toString()??'-1';
      if(amount.isEmpty){
        CustomSnackBar.error(errorList: ['${MyStrings.please} ${MyStrings.enterAmount.toLowerCase()}']);
        return;
      }

      if(id == '-1'){
        CustomSnackBar.error(errorList: ['${MyStrings.please} ${MyStrings.selectAWallet.toLowerCase()}']);
        return;
      }

      double amount1 = 0;
      double maxAmount = 0;
      try{
        amount1=double.parse(amount);
        maxAmount=double.parse(withdrawMethod?.maxLimit??'0');
      }catch(e){
        return;
      }
      if(maxAmount==0||amount1==0){
        List<String>errorList=[MyStrings.invalidAmount];
        CustomSnackBar.showCustomSnackBar(errorList: errorList, msg: [], isError: true);
        return;
      }

      submitLoading = true;
      update();

      ResponseModel response =
      await repo.addWithdrawRequest(withdrawMethod?.id ?? -1, amount1);

      if(response.statusCode==200){
        WithdrawRequestResponseModel model= WithdrawRequestResponseModel.fromJson(jsonDecode(response.responseJson));
        if(model.status ==  MyStrings.success){
          Get.offAndToNamed(RouteHelper.confirmWithdrawRequest,arguments: [model,withdrawMethod?.name]);
        }else{
         CustomSnackBar.showCustomSnackBar(errorList: model.message?.error??[MyStrings.requestFail], msg: [], isError: true);
        }
      }else{
        CustomSnackBar.showCustomSnackBar(errorList: [response.message], msg: [], isError: true);
      }

      submitLoading = false;
      update();
    }

  bool isShowRate() {
    if(rate>1 && currency.toLowerCase()!= withdrawMethod?.currency?.toLowerCase()){
      return true;
    }else{
      return false;
    }
  }

  void clearPreviousValue(){
    withdrawMethodList.clear();
    amountController.text = '';
    rate = 1;
    submitLoading = false;
    withdrawMethod = WithdrawMethod();
  }

}