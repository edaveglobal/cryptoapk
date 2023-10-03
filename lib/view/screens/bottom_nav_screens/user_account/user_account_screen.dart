import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/routes/route.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_images.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/data/controller/account/profile_controller.dart';
import 'package:hyip_lab/data/repo/account/profile_repo.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import 'package:hyip_lab/view/components/appbar/custom_appbar.dart';
import 'package:hyip_lab/view/components/divider/custom_divider.dart';
import 'package:hyip_lab/view/screens/bottom_nav_screens/user_account/widget/user_info_field.dart';

class UserAccountScreen extends StatefulWidget {
  const UserAccountScreen({Key? key}) : super(key: key);

  @override
  State<UserAccountScreen> createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find(), ));
    Get.put(ProfileController(profileRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProfileController>().loadProfileInfo();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar: CustomAppBar(
          isShowBackBtn: true,
          title: MyStrings.profile.tr,
          bgColor: MyColor.getAppbarBgColor(),
        ),
        body: GetBuilder<ProfileController>(
          builder: (controller) => controller.isLoading ? Center(
            child: CircularProgressIndicator(color: MyColor.getPrimaryColor()),
          ) : SingleChildScrollView(
            padding: Dimensions.screenPaddingHV,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space15),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: MyColor.getCardBg(), borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage(MyImages.userImage),
                            radius: 20,
                          ),
                          const SizedBox(width: Dimensions.space15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(controller.model.data?.user?.username ?? "", style: interSemiBoldLarge.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w600)),
                              const SizedBox(height: Dimensions.space5),
                              Text(controller.model.data?.user?.address?.country ?? "", style: interRegularSmall.copyWith(color: MyColor.getPrimaryColor())),
                            ],
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () => Get.toNamed(RouteHelper.editProfileScreen),
                        child: Container(
                          height: 30, width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: MyColor.getScreenBgColor(),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Text(MyStrings.editProfile.tr, textAlign: TextAlign.center, style: interRegularSmall.copyWith(color: MyColor.getTextColor())),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: Dimensions.space20),

                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: Dimensions.screenPaddingHV,
                  decoration: BoxDecoration(color: MyColor.getCardBg(), borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserInfoField(
                        icon: MyImages.username,
                        label: MyStrings.username.tr,
                        value: controller.model.data?.user?.username ?? "",
                      ),
                      const CustomDivider(space: Dimensions.space20),
                      UserInfoField(
                        icon: MyImages.email,
                        label: MyStrings.email.tr,
                        value: controller.model.data?.user?.email ?? "",
                      ),
                      const CustomDivider(space: Dimensions.space20),
                      UserInfoField(
                        icon: MyImages.phone,
                        label: MyStrings.phoneNo.tr,
                        value: controller.model.data?.user?.mobile ?? "",
                      ),
                      const CustomDivider(space: Dimensions.space20),
                      UserInfoField(
                        icon: MyImages.country,
                        label: MyStrings.country.tr,
                        value: controller.model.data?.user?.address?.country ?? "",
                      ),
                      const CustomDivider(space: Dimensions.space20),
                      UserInfoField(
                        icon: MyImages.state,
                        label: MyStrings.state.tr,
                        value: controller.model.data?.user?.address?.state ?? "",
                      ),
                      const CustomDivider(space: Dimensions.space20),
                      UserInfoField(
                        icon: MyImages.city,
                        label: MyStrings.city.tr,
                        value: controller.model.data?.user?.address?.city ?? "",
                      ),
                      const CustomDivider(space: Dimensions.space20),
                      UserInfoField(
                        icon: MyImages.zipCode,
                        label: MyStrings.zipCode.tr,
                        value: controller.model.data?.user?.address?.zip ?? "",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
