import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/data/model/global/response_model/response_model.dart';
import 'package:hyip_lab/data/repo/account/transaction_log_repo.dart';
import 'package:hyip_lab/data/model/transctions/transaction_response_model.dart';
import 'package:hyip_lab/view/components/show_custom_snackbar.dart';

class TransactionController extends GetxController{

  TransactionRepo transactionRepo;
  TransactionController({required this.transactionRepo});

  bool isLoading = true;

  final formKey = GlobalKey<FormState>();

  List<String> transactionTypeList = [MyStrings.all,MyStrings.plus,MyStrings.minus];
  List<String> walletTypeList = [MyStrings.all, MyStrings.depositWallet,MyStrings.interestWallet];

  List<Data> transactionList = [];
  List<Remarks> remarksList = [(Remarks(remark: MyStrings.all)),];

  String trxSearchText = '';
  String? nextPageUrl;
  int page = 0;
  int index = 0;

  String currency = '';

  TextEditingController trxController = TextEditingController();

  String selectedRemark = MyStrings.all;
  String selectedTrxType = MyStrings.all;
  String selectedWalletType = MyStrings.all;



  void initData(String? arg) async{
    page = 0;
    if(arg!=null && arg.isNotEmpty && arg!='null'){
      selectedWalletType = arg;
      changeFilterOrSearchStatus(filter: true);
    } else{
      selectedWalletType = MyStrings.all;
    }
    selectedRemark = MyStrings.all;
    selectedTrxType = MyStrings.all;

    transactionList.clear();
    isLoading = true;
    update();

    await loadInitialTransaction();
    isLoading=false;
    update();
  }

  void loadPaginationData()async{
    await loadInitialTransaction();
    update();
  }

  Future<void> loadInitialTransaction() async{

    page = page + 1;

    if(page == 1){
      remarksList.clear();
      remarksList.insert(0, Remarks(remark: MyStrings.all));
      transactionList.clear();
    }

    ResponseModel responseModel = await transactionRepo.getTransactionList(
        page,
        type: selectedTrxType.toLowerCase(),
        remark: selectedRemark.toLowerCase(),
        searchText: trxSearchText,
        walletType:  selectedWalletType.replaceAll(' ', '_').toString().toLowerCase()
    );

    if(responseModel.statusCode == 200){
      TransactionResponseModel model = TransactionResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      nextPageUrl = model.data?.transactions?.nextPageUrl;

      if(model.status.toString().toLowerCase() == "success"){
        List<Data>? tempDataList = model.data?.transactions?.data;
        if(page == 1){
          List<Remarks>? tempRemarksList = model.data?.remarks;
          if (tempRemarksList != null && tempRemarksList.isNotEmpty) {
            remarksList.addAll(tempRemarksList);
          }
        }
        if(tempDataList != null && tempDataList.isNotEmpty){
          transactionList.addAll(tempDataList);
        }
      }
      else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
      return ;
    }
    else {
      CustomSnackBar.error(errorList: [responseModel.message]);
      return;
    }
  }

  void changeSelectedRemark(String remarks){
    selectedRemark = remarks;
    update();
  }

  void changeSelectedTrxType(String trxType){
    selectedTrxType = trxType;
    update();
  }

  void changeSelectedWalletType(String walletType){
    selectedWalletType = walletType;
    update();
  }

  bool filterLoading = false;

  Future<void> filterData()async{
    trxSearchText = trxController.text;
    page=0;
    filterLoading=true;
    update();

    await loadInitialTransaction();

    filterLoading=false;
    update();
  }

  bool hasNext(){
    return nextPageUrl !=null && nextPageUrl!.isNotEmpty && nextPageUrl != 'null'? true:false;
  }

  bool isFilter = false;
  bool isSearch = false;

  void changeFilterOrSearchStatus({bool filter = true}){

    if(filter){
      isFilter = !isFilter;
    } else{
      isSearch = !isSearch;
    }
    clearFilterData();
    update();
  }

  void clearFilterData(){
    if(!isFilter){
      selectedTrxType = selectedTrxType[0];
      selectedRemark = remarksList[0].remark??MyStrings.all;
    }
    if(!isSearch){
      trxController.text = '';
    }
    filterData();
  }

  int selectedCardIndex = -1;
  void changeSelectedCardIndex(int index) {
    if(selectedCardIndex==index){
      selectedCardIndex = -1;
    } else{
      selectedCardIndex = index;
    }
    update();
  }
}