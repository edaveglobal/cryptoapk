
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/data/model/withdraw/withdraw_history_response_model.dart';
import 'package:hyip_lab/data/repo/withdraw/withdraw_repo.dart';

class WithdrawHistoryController extends GetxController {

  WithdrawRepo repo;

  String searchText = "";
  WithdrawHistoryController({required this.repo});
  WithdrawHistoryResponseModel withdrawHistoryResponseModel = WithdrawHistoryResponseModel();
  bool isLoading = true;
  String? nextPageUrl ='';
  List<WithdrawListModel>historyList=[];
  String gsCurrency = '';

  int page = 0;

  initData() async{
    historyList.clear();
    isLoading=true;
    update();
    withdrawHistoryResponseModel= await repo.getAllWithdrawHistory(page, searchText: searchText);

   if(withdrawHistoryResponseModel.data!=null){
     nextPageUrl=withdrawHistoryResponseModel.data?.withdrawals?.nextPageUrl;
     List<WithdrawListModel>?list=withdrawHistoryResponseModel.data?.withdrawals?.data;
     if(list!=null && list.isNotEmpty){
       historyList.addAll(list);
     }
   }
   isLoading=false;
   update();
  }


  void fetchNewList() async{

    page = page + 1;
    withdrawHistoryResponseModel = await repo.getAllWithdrawHistory(page, searchText: searchText);

    if(withdrawHistoryResponseModel.data!=null){
      nextPageUrl=withdrawHistoryResponseModel.data?.withdrawals?.nextPageUrl;
      List<WithdrawListModel>?list=withdrawHistoryResponseModel.data?.withdrawals?.data;
      if(list!=null && list.isNotEmpty){
        historyList.addAll(list);
      }
    }

    update();
  }

  void searchList() async{
    withdrawHistoryResponseModel = await repo.getAllWithdrawHistory(page, searchText: searchText);
    historyList.clear();
    if(withdrawHistoryResponseModel.data!=null){
      List<WithdrawListModel>?list=withdrawHistoryResponseModel.data?.withdrawals?.data;
      if(list!=null && list.isNotEmpty){
        historyList.addAll(list);
      }
    }
    update();
  }

  bool hasNext() {
    return nextPageUrl!=null && nextPageUrl!.isNotEmpty? true : false;
  }

  void clearData() {
    page=0;
    historyList.clear();
    nextPageUrl='';
  }

  /// filter data
  bool filterLoading = false;
  Future<void> filterData()async{
    searchText = searchController.text;
    page=0;
    filterLoading = true;
    update();
    await initData();

    filterLoading=false;
    update();
  }

  bool isSearch = false;
  TextEditingController searchController = TextEditingController();
  void changeSearchStatus() async{
    isSearch = ! isSearch;
    update();
    if(!isSearch){
      page = 0;
      searchController.text = '';
      searchText = '';
      historyList.clear();
      isLoading = true;
      update();

      await initData();
      isLoading = false;
    }
  }
}