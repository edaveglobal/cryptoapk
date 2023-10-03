import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/data/controller/account/profile_complete_controller.dart';
import 'package:hyip_lab/data/repo/account/profile_repo.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import 'package:hyip_lab/view/components/appbar/custom_appbar.dart';
import 'package:hyip_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:hyip_lab/view/components/rounded_button.dart';
import 'package:hyip_lab/view/components/text-field/custom_text_field.dart';
import 'package:hyip_lab/view/components/will_pop_widget.dart';


class ProfileCompleteScreen extends StatefulWidget {
  const ProfileCompleteScreen({Key? key}) : super(key: key);

  @override
  State<ProfileCompleteScreen> createState() => _ProfileCompleteScreenState();
}

class _ProfileCompleteScreenState extends State<ProfileCompleteScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find(), ));
    Get.put(ProfileCompleteController(profileRepo: Get.find()));
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }
  
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return WillPopWidget(
      nextRoute: '',
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.getScreenBgColor(),
          appBar: CustomAppBar(
            title: MyStrings.profileComplete.tr,
            isShowBackBtn: true,
            fromAuth: false,
            isProfileCompleted: true,
            bgColor: MyColor.getAppbarBgColor(),
          ),
          body: GetBuilder<ProfileCompleteController>(
            builder: (controller) => SingleChildScrollView(
              padding: Dimensions.screenPaddingHV,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      labelText: MyStrings.firstName.tr,
                      hintText: "${MyStrings.enterYour.tr} ${MyStrings.firstName.toLowerCase().tr}",
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      focusNode: controller.firstNameFocusNode,
                      controller: controller.firstNameController,
                      nextFocus: controller.lastNameFocusNode,
                      onChanged: (value){
                        return;
                      },
                    ),
                    const SizedBox(height: Dimensions.space25),

                    CustomTextField(
                      labelText: MyStrings.lastName.tr,
                      hintText: "${MyStrings.enterYour.tr} ${MyStrings.lastName.toLowerCase().tr}",
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      focusNode: controller.lastNameFocusNode,
                      controller: controller.lastNameController,
                      nextFocus: controller.addressFocusNode,
                      onChanged: (value){
                        return;
                      },
                    ),
                    const SizedBox(height: Dimensions.space25),

                    CustomTextField(
                      labelText: MyStrings.address,
                      hintText: "${MyStrings.enterYour.tr} ${MyStrings.address.toLowerCase().tr}",
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      focusNode: controller.addressFocusNode,
                      controller: controller.addressController,
                      nextFocus: controller.stateFocusNode,
                      onChanged: (value){
                        return;
                      },
                    ),
                    const SizedBox(height: Dimensions.space25),

                    CustomTextField(
                      labelText: MyStrings.state,
                      hintText: "${MyStrings.enterYour.tr} ${MyStrings.state.toLowerCase().tr}",
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      focusNode: controller.stateFocusNode,
                      controller: controller.stateController,
                      nextFocus: controller.cityFocusNode,
                      onChanged: (value){
                        return ;
                      },
                    ),
                    const SizedBox(height: Dimensions.space25),

                    CustomTextField(
                      labelText: MyStrings.city.tr,
                      hintText: "${MyStrings.enterYour.tr} ${MyStrings.city.toLowerCase().tr}",
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      focusNode: controller.cityFocusNode,
                      controller: controller.cityController,
                      nextFocus: controller.zipCodeFocusNode,
                      onChanged: (value){
                        return ;
                      },
                    ),
                    const SizedBox(height: Dimensions.space25),

                    CustomTextField(
                      labelText: MyStrings.zipCode.tr,
                      hintText: "${MyStrings.enterYour.tr} ${MyStrings.zipCode.toLowerCase().tr}",
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.done,
                      focusNode: controller.zipCodeFocusNode,
                      controller: controller.zipCodeController,
                      onChanged: (value){
                        return;
                      },
                    ),
                    const SizedBox(height: Dimensions.space35),

                    controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
                      text: MyStrings.updateProfile.tr,
                      textColor: MyColor.getButtonTextColor(),
                      press: (){
                        controller.updateProfile();
                      },
                      color: MyColor.getButtonColor(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
