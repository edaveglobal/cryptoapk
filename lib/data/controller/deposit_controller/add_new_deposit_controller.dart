
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/helper/string_format_helper.dart';
import 'package:hyip_lab/core/routes/route.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/data/model/authorized/deposit/deposit_insert_method.dart';
import 'package:hyip_lab/data/model/authorized/deposit/deposit_insert_response_model.dart';
import 'package:hyip_lab/data/model/authorized/deposit/deposit_method_response_model.dart';
import 'package:hyip_lab/data/model/global/response_model/response_model.dart';

import '../../../view/components/show_custom_snackbar.dart';
import '../../repo/deposit_repo.dart';

class AddNewDepositController extends GetxController{

  DepositRepo depositRepo;
  AddNewDepositController({required this.depositRepo});
  TextEditingController amountController=TextEditingController();

  bool isLoading = false;
  String currency = '';
  Methods? paymentMethod = Methods();
  String depositLimit = '';
  String charge = '';
  String payableText = '';
  String conversionRate = '';
  String inLocal = '';



  List<Methods>paymentMethodList=[];

  double rate = 1;
  double mainAmount = 0;
  setPaymentMethod(Methods?method) {
    String amt = amountController.text.toString();
    mainAmount = amt.isEmpty?0:double.tryParse(amt)??0;
    paymentMethod = method;
    depositLimit =
    '${Converter.twoDecimalPlaceFixedWithoutRounding(
        method?.minAmount?.toString() ?? '-1')} - ${Converter
        .twoDecimalPlaceFixedWithoutRounding(
        method?.maxAmount?.toString() ?? '-1')} $currency';
    changeInfoWidgetValue(mainAmount);
    update();
  }

  void changeInfoWidgetValue(double amount){

    mainAmount = amount;
    double percent = double.tryParse(paymentMethod?.percentCharge??'0')??0;
    double percentCharge = (amount*percent)/100;
    double temCharge = double.tryParse(paymentMethod?.fixedCharge??'0')??0;
    double totalCharge = percentCharge+temCharge;
    charge = '${Converter.twoDecimalPlaceFixedWithoutRounding('$totalCharge')} $currency';
    double payable = totalCharge + amount;
    payableText = '$payable $currency';

    rate = double.tryParse(paymentMethod?.rate??'0')??0;
    conversionRate = '1 $currency = $rate ${paymentMethod?.currency??''}';
    inLocal = Converter.twoDecimalPlaceFixedWithoutRounding('${payable*rate}');
    update();
    return;
  }

  beforeInitLoadData()async{

    currency = depositRepo.apiClient.getCurrencyOrUsername();
    isLoading = true;
    update();

    ResponseModel response = await depositRepo.getDepositMethod();
    paymentMethodList.clear();
    Methods method1 = Methods(id: -2,name:MyStrings.selectOne,currency:"",symbol:"",methodCode:"-1",gatewayAlias:"",minAmount:"0",maxAmount:"0",percentCharge:"",fixedCharge:"",rate:"",method: Method());
    paymentMethodList.insert(0, method1);

    if(response.statusCode == 200){

      DepositMethodResponseModel model = DepositMethodResponseModel.fromJson(jsonDecode(response.responseJson));


      if(model.message?.success!=null){
        List<Methods>?tempMethodList = model.data?.methods;
        if(tempMethodList !=null || tempMethodList!.isNotEmpty){
          paymentMethodList.addAll(tempMethodList);
        }
        if(paymentMethodList.isNotEmpty){
          paymentMethod = paymentMethodList[0];
          setPaymentMethod(paymentMethod);
        }
      }

    }else{
      CustomSnackBar.error(errorList: [response.message]);
    }

   isLoading = false;
   update();
  }

  bool submitLoading = false;

  void submitDeposit()async{

    String amount=amountController.text.toString();
    String methodCode= paymentMethod?.methodCode.toString()??'-1';
    if(amount.isEmpty){
      CustomSnackBar.error(errorList: ['${MyStrings.please} ${MyStrings.enterAmount.toLowerCase()}']);
      return;
    }
    if(methodCode=='-1'){
      CustomSnackBar.error(errorList: ['${MyStrings.please} ${MyStrings.selectAWallet.toLowerCase()}']);
      return;
    }

    double amount1=0;
    double maxAmount=0;

    try{
      amount1=double.parse(amount);
      maxAmount=double.parse(paymentMethod?.maxAmount??'0');
    }catch(e){
      return;
    }

    if(maxAmount==0||amount1==0){
      List<String>errorList=[MyStrings.invalidAmount];
      CustomSnackBar.error(errorList: errorList);
      return;
    }

    submitLoading = true;
    update();

    DepositInsertModel model = DepositInsertModel(methodCode: paymentMethod?.methodCode.toString()??'-1', amount: amount1, currency: paymentMethod?.currency??'');
    DepositInsertResponseModel insertModel = await depositRepo.insertDeposit(model);

    if(insertModel.data == null || insertModel.data?.redirectUrl == null){
      CustomSnackBar.error(errorList: insertModel.message?.error??[MyStrings.requestFail]);
    }else{
      String redirectUrl = insertModel.data?.redirectUrl??'';
      if(redirectUrl.isEmpty){
        List<String>error=[MyStrings.noRedirectUrlFound];
        CustomSnackBar.error(errorList:error);
      }else{
        amountController.text='';
        showWebView(redirectUrl);
      }
    }

    submitLoading = false;
    update();

  }

  setStatusTrue(){
    isLoading = true;
    update();
  }

  setStatusFalse(){
    isLoading=false;
    update();
  }

  bool isShowRate() {
    if(rate>1 && currency.toLowerCase()!= paymentMethod?.currency?.toLowerCase()){
      return true;
    }else{
      return false;
    }
  }


  void clearData() {
    depositLimit='';
    charge='';
    paymentMethodList.clear();
    amountController.text='';
    setStatusFalse();
  }

  void showWebView(String redirectUrl) {
    Get.back();
    Get.toNamed(RouteHelper.depositWebViewScreen,arguments: redirectUrl)?.then((value){
      clearData();
      //Get.back();
    });
  }

}