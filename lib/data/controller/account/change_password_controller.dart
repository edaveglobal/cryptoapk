import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/data/repo/account/change_password_repo.dart';


class ChangePasswordController extends GetxController  {
  ChangePasswordRepo changePasswordRepo;

  ChangePasswordController({required this.changePasswordRepo});

  List<String> errors = [];
  String? currentPass, password, confirmPass;
  bool isLoading = false;
  TextEditingController currentPassController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  FocusNode currentPassFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPassFocusNode = FocusNode();



  addError({required String error}) {
    if (!errors.contains(error)) {
      errors.add(error);
      update();
    }
  }

  removeError({required String error}) {
    if (errors.contains(error)) {
      errors.remove(error);
      update();
    }
  }

  bool submitLoading=false;
  changePassword() async {

    String currentPass = currentPassController.text.toString();
    String password = passController.text.toString();

      submitLoading = true;
      update();
      bool b = await changePasswordRepo.changePassword(currentPass, password);

      if(b){
        currentPassController.clear();
        passController.clear();
        confirmPassController.clear();
      }

    submitLoading = false;
    update();
  }

  void clearData() {
    isLoading=false;
    errors.clear();
    currentPassController.text='';
    passController.text='';
    confirmPassController.text='';
  }
}
