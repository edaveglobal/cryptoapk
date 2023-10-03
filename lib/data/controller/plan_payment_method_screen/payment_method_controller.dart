

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/helper/string_format_helper.dart';
import 'package:hyip_lab/core/routes/route.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/data/model/authorized/deposit/deposit_method_response_model.dart';
import 'package:hyip_lab/data/model/global/response_model/response_model.dart';
import 'package:hyip_lab/data/model/plan/plan_model.dart';
import 'package:hyip_lab/data/model/plan/plan_response_model.dart';
import 'package:hyip_lab/data/model/profile/profile_response_model.dart';
import 'package:hyip_lab/data/repo/deposit_repo.dart';
import 'package:hyip_lab/view/components/show_custom_snackbar.dart';

class PaymentMethodController extends GetxController {

  DepositRepo repo;
  PaymentMethodController({required this.repo});

  late Plans plan;
  loadData(Plans plan)async{
    this.plan = plan;
    configureAmountField(plan);
    isLoading = true;
    update();
    await beforeInitLoadData();
    await retrieveAndAddDepositWalletData();
    setPaymentMethod(paymentMethodList[0]);
    isLoading = false;
    update();
  }

  bool isFixed = false;
  String investAmount = '';
  String interestAmount = '';
  void configureAmountField(Plans plan){
    String fixed = Converter.twoDecimalPlaceFixedWithoutRounding(plan.fixedAmount??'0.0');
    double fixedAmt = double.tryParse(fixed)??0.0;
    if(fixedAmt>0){
      investAmount = '$curSymbol$fixed';
      isFixed = true;
      amountController.text = fixed;
    }else{
      String minAmount = Converter.twoDecimalPlaceFixedWithoutRounding(plan.minimum??'0');
      String maxAmount = Converter.twoDecimalPlaceFixedWithoutRounding(plan.maximum??'0');
      investAmount = '$curSymbol$minAmount - $curSymbol$maxAmount';
    }
    interestAmount = plan.return_??'0.0';
    update();
  }

  TextEditingController amountController=TextEditingController();

  bool isLoading = true;
  String currency = '';
  String curSymbol = '';
  Methods defaultMethod = Methods(id: -1,name:MyStrings.selectOne,currency:"-",symbol:"-",methodCode:"-1",gatewayAlias:"-",minAmount:"0",maxAmount:"0",percentCharge:"0",fixedCharge:"0",rate:"0",method: Method());
  Methods? paymentMethod=Methods();
  String depositLimit='';
  String charge='';
  String payableText = '';
  String conversionRate = '';
  String inLocal = '';

  List<Methods>paymentMethodList=[];


  double rate = 1;
  double mainAmount = 0;
  setPaymentMethod(Methods?method){
    String amt = amountController.text.toString();
    mainAmount = amt.isEmpty?0:double.tryParse(amt)??0;
    paymentMethod = method;
    depositLimit =
    '$curSymbol${Converter.twoDecimalPlaceFixedWithoutRounding(
        method?.minAmount?.toString() ?? '0')} - $curSymbol${Converter
        .twoDecimalPlaceFixedWithoutRounding(
        method?.maxAmount?.toString() ?? '0')}';
    changeInfoWidgetValue(mainAmount);
    update();
  }

  void changeInfoWidgetValue(double amount){

    mainAmount = amount;
    double percent = double.tryParse(paymentMethod?.percentCharge??'0')??0;
    double percentCharge = (amount*percent)/100;
    double temCharge = double.tryParse(paymentMethod?.fixedCharge??'0')??0;
    double totalCharge = percentCharge+temCharge;
    charge = '$curSymbol${Converter.twoDecimalPlaceFixedWithoutRounding('$totalCharge')}';
    double payable = totalCharge + amount;
    payableText = '$curSymbol$payable';

    rate = double.tryParse(paymentMethod?.rate??'0')??0;
    conversionRate = '${curSymbol}1 = ${paymentMethod?.symbol??''}$rate';
    inLocal = Converter.twoDecimalPlaceFixedWithoutRounding('${payable*rate}');
    update();
    return;
  }


  Future<void>beforeInitLoadData()async{

    paymentMethodList.clear();
    currency  = repo.apiClient.getCurrencyOrUsername();
    curSymbol = repo.apiClient.getCurrencyOrUsername(isSymbol: true);
    paymentMethod = defaultMethod;
    paymentMethodList.insert(0, defaultMethod);

    ResponseModel response = await repo.getDepositMethod();
    if(response.statusCode == 200){
      DepositMethodResponseModel model = DepositMethodResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.message?.success!=null){
          List<Methods>?tempList = model.data?.methods;
          if(tempList !=null && tempList.isNotEmpty){
            paymentMethodList.addAll(tempList);
          }
          if(paymentMethodList.isNotEmpty){
            paymentMethod=paymentMethodList[0];
          }
      } else{
         CustomSnackBar.error(errorList: model.message?.error??[MyStrings.somethingWentWrong]);
      }
    } else{
         CustomSnackBar.error(errorList: [response.message]);
    }

  }

  Future<void> retrieveAndAddDepositWalletData()async{

    ResponseModel response = await repo.getUserInfo();
    if(response.statusCode == 200){
      ProfileResponseModel model = ProfileResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){

        String depositWalletAmount = Converter.twoDecimalPlaceFixedWithoutRounding(model.data?.user?.depositWallet??'0.0');
        String interestWalletAmount = Converter.twoDecimalPlaceFixedWithoutRounding(model.data?.user?.interestWallet??'0.0');

        Methods method1 = Methods(id: -1,name:'${"deposit_wallet"} $curSymbol$depositWalletAmount',currency:"-",symbol:"-",methodCode:"deposit_wallet",gatewayAlias:"-",minAmount:"0",maxAmount:"0",percentCharge:"0",fixedCharge:"0",rate:"0",method: Method());
        Methods method2 = Methods(id: -2,name:'${"interest_wallet"} $curSymbol$interestWalletAmount',currency:"",symbol:"",methodCode:"interest_wallet",gatewayAlias:"",minAmount:"",maxAmount:"",percentCharge:"",fixedCharge:"",rate:"",method: Method());

        paymentMethodList.insert(1, method1);
        paymentMethodList.insert(2, method2);
        update();

      }
    }

    return ;

  }


  bool submitLoading = false;
  void submitDeposit()async{


    String? mWalletId = paymentMethod?.methodCode;

    if(mWalletId=='-1'){
      CustomSnackBar.error(errorList: [MyStrings.selectAWallet]);
      return;
    }

    String walletId = '';

    if(mWalletId != null){
      if(mWalletId.toLowerCase() == 'deposit_wallet' || mWalletId.toLowerCase() == 'interest_wallet'){
        walletId = paymentMethod?.name?.split(' ').first??'';
      }else{
        walletId = mWalletId.toString();
      }
    }else{
      CustomSnackBar.showCustomSnackBar(errorList: [MyStrings.invalidAmount], msg: [], isError: true);
      return;
    }

    String amount=amountController.text.toString();



    if(isFixed){

      Map<String,dynamic>params = {
        'plan_id': plan.id.toString(),
        'amount' : amount.toString(),
        'wallet' : walletId,
      };

      submitInvestment(params);

    }else {
      if (amount.isEmpty) {
        return;
      }

      double mAmount = 0;
      try {
        mAmount = double.parse(amount);
      } catch (e) {
        return;
      }

      double maxAmount = double.tryParse(plan.maximum ?? '0') ?? 0;
      double minAmount = double.tryParse(plan.minimum ?? '0') ?? 0;

      if (mAmount > maxAmount || mAmount < minAmount) {
        CustomSnackBar.showCustomSnackBar(
            errorList: [MyStrings.investmentLimitMsg], msg: [], isError: true);
        return;
      }

      Map<String, dynamic> params = {
        'plan_id': plan.id.toString(),
        'amount': amount.toString(),
        'wallet': walletId,
      };

      submitInvestment(params);

    }

  }

  void submitInvestment(Map<String,dynamic>params)async{

    submitLoading = true;
    update();

    ResponseModel response = await repo.submitInvestment(params);


    if(response.statusCode == 200){
      PlanResponseModel model = PlanResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()=='success'){
        String  url = model.data?.redirectUrl??'';
        if(url.isNotEmpty){
          loadWebView(url);
        } else{
          Get.back();
          CustomSnackBar.success(successList: model.message?.success??[MyStrings.requestSuccess]);
        }
      } else{
        CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
      }
    } else{
      CustomSnackBar.error(errorList:[response.message]);
    }

    submitLoading = false;
    update();
  }

  void loadWebView(String url){
    Get.offAndToNamed(RouteHelper.depositWebViewScreen,arguments: url);
  }

  void clearData() {
    depositLimit='';
    charge='';
    paymentMethodList.clear();
    amountController.text='';
    defaultMethod = Methods(id: -1,name:MyStrings.selectOne,currency:"-",symbol:"-",methodCode:"-1",gatewayAlias:"-",minAmount:"0",maxAmount:"0",percentCharge:"0",fixedCharge:"0",rate:"0",method: Method());
    paymentMethod=Methods();
    isLoading = true;
    submitLoading = false;
    isFixed = false;
  }



  bool isShowRate() {
    if(rate>1 && currency.toLowerCase() != paymentMethod?.currency?.toLowerCase()){
      return true;
    }else{
      return false;
    }
  }

  bool isShowPreview() {
    int id = paymentMethod?.id??-1;
   return mainAmount>0 && id>1?true:false; // for deposit and interest you won't show preview widget
  }

}