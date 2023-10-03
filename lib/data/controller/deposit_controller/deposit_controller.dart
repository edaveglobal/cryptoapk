

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/data/model/authorized/deposit/deposit_history_response_model.dart';
import 'package:hyip_lab/data/repo/deposit_repo.dart';



class DepositController extends GetxController {

  DepositRepo depositRepo;
  DepositController({required this.depositRepo});
  bool isLoading=false;


  DepositHistoryResponseModel depositModel=DepositHistoryResponseModel();
  String currency='';
  List<DepositHistoryListModel>depositList=[];
  String? nextPageUrl='';
  String trx='';

  int page=1;
  beforeInitLoadData()async{
    currency = depositRepo.apiClient.getCurrencyOrUsername();
    isLoading = true;
    update();
    page=1;

    depositModel = await depositRepo.getDepositHistory(page: page,);

    depositList.clear();
    List<DepositHistoryListModel>?tempDepositList=depositModel.data?.deposits?.data;
    nextPageUrl=depositModel.data?.deposits?.nextPageUrl??'';
    if(tempDepositList!=null && !(tempDepositList==[])){
      depositList.addAll(tempDepositList);
    }

    isLoading = false;
    update();
  }


  int totalPage=0;
  void fetchNewList() async{
    page=page+1;
    depositModel = await depositRepo.getDepositHistory(page: page);
    List<DepositHistoryListModel>?tempDepositList=depositModel.data?.deposits?.data;
    nextPageUrl=depositModel.data?.deposits?.nextPageUrl??'';
    if(tempDepositList!=null && !(tempDepositList==[])){
      depositList.addAll(tempDepositList);
    }
    update();
  }

  bool searchLoading = false;
  TextEditingController searchController = TextEditingController();
  void searchDepositTrx()async{
    trx = searchController.text;
    searchLoading = true;
    update();

    depositModel = await depositRepo.getDepositHistory(isSearch: true,trx: trx);
    List<DepositHistoryListModel>?tempDepositList=depositModel.data?.deposits?.data;
    nextPageUrl=depositModel.data?.deposits?.nextPageUrl??'';
    depositList.clear();
    if(tempDepositList!=null && !(tempDepositList==[])){
      depositList.addAll(tempDepositList);
    }

    page = 1;
    searchLoading = false;
    update();
  }

  bool hasNext(){
    if(nextPageUrl!=null && nextPageUrl!.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  void clearFilter(){
    searchController.text = '';
    trx = '';
    beforeInitLoadData();
  }


  void setTrx(value) {
    trx=value;
  }

  int expandedIndex=-1;
  void changeExpandedIndex(int index){
      if(expandedIndex==index){
        expandedIndex = -1;
      }else{
        expandedIndex=index;
      }
      update();
  }

  bool isSearch = false;
  void changeIsPress() {
    isSearch = !isSearch;
    if(!isSearch){
      clearFilter();
    }
    update();
  }

  String getStatus(int index) {
    String status = depositList[index].status??'';
    String methodCode = depositList[index].methodCode??'1';
    if(status == '1'){
      double code = double.tryParse(methodCode)??1;
      return code>=1000? MyStrings.approved : MyStrings.succeed ;
    } else{
      return status == '2'? MyStrings.pending : status == '3'? MyStrings.rejected : MyStrings.initiated;
    }
  }

  Color getStatusColor(int index) {
    String status = depositList[index].status??'';
    String methodCode = depositList[index].methodCode??'1';
    if(status == '1'){
      double code = double.tryParse(methodCode)??1;
      return code >= 1000? MyColor.greenSuccessColor : MyColor.greenSuccessColor;
    } else{
      return status == '2' ? MyColor.pendingColor : status == '3'? MyColor.redCancelTextColor : MyColor.colorGrey;
    }
  }


}