import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/data/controller/account/profile_controller.dart';
import 'package:hyip_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:hyip_lab/view/components/rounded_button.dart';
import 'package:hyip_lab/view/components/text-field/custom_text_field.dart';

class EditProfileForm extends StatefulWidget {

  const EditProfileForm({Key? key,}) : super(key: key);

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => Form(
        child: Column(
          children: [

            CustomTextField(
                labelText: MyStrings.firstName.tr,
                onChanged: (value){
                  return;
                },
                focusNode: controller.firstNameFocusNode,
                controller: controller.firstNameController
            ),
            const SizedBox(height: 25),

            CustomTextField(
                labelText: MyStrings.lastName.tr,
                onChanged: (value){
                  return;
                },
                focusNode: controller.lastNameFocusNode,
                controller: controller.lastNameController
            ),
            const SizedBox(height: 25),

            CustomTextField(
                labelText: MyStrings.address.tr,
                onChanged: (value){

                  return;
                },
                focusNode: controller.addressFocusNode,
                controller: controller.addressController
            ),
            const SizedBox(height: 25),

            CustomTextField(
                labelText: MyStrings.state.tr,
                onChanged: (value){
                  return ;
                },
                focusNode: controller.stateFocusNode,
                controller: controller.stateController
            ),
            const SizedBox(height: 25),

            CustomTextField(
                labelText: MyStrings.zipCode.tr,
                onChanged: (value){
                  return;
                },
                focusNode: controller.zipCodeFocusNode,
                controller: controller.zipCodeController
            ),
            const SizedBox(height: 25),

            CustomTextField(
                labelText: MyStrings.city.tr,
                onChanged: (value){
                  return ;
                },
                focusNode: controller.cityFocusNode,
                controller: controller.cityController,
            ),
            const SizedBox(height: 25),

            controller.isSubmitLoading?
            const RoundedLoadingBtn():
            RoundedButton(
              text: MyStrings.updateProfile.tr,
              textColor: MyColor.getButtonTextColor(),
              color: MyColor.getButtonColor(),
              press: (){
                controller.updateProfile();
              }
            )
          ],
        ),
      ),
    );
  }
}
