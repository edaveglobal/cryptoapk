import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/helper/date_converter.dart';
import 'package:hyip_lab/core/helper/string_format_helper.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/data/controller/investment/investment_controller.dart';
import 'package:hyip_lab/data/model/my_investment/my_investment_response_model.dart';
import 'package:hyip_lab/data/repo/investment_repo/investment_repo.dart';
import 'package:hyip_lab/data/services/api_service.dart';
import 'package:hyip_lab/view/components/appbar/custom_appbar.dart';
import 'package:hyip_lab/view/components/custom_loader/custom_loader.dart';
import 'package:hyip_lab/view/screens/investment/widget/active_plan_card.dart';
import 'package:hyip_lab/view/screens/investment/widget/plan_tab_bar.dart';

import '../../components/no_data/no_data_widget.dart';

class InvestmentScreen extends StatefulWidget {
  const InvestmentScreen({Key? key}) : super(key: key);

  @override
  State<InvestmentScreen> createState() => _InvestmentScreenState();
}

class _InvestmentScreenState extends State<InvestmentScreen> {

  var selectedIndex = 0;

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(InvestmentRepo(apiClient: Get.find()));
    final controller = Get.put(InvestmentController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.addListener(_scrollListener);
      controller.loadData();
    });
  }

  final ScrollController _controller = ScrollController();


  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if(Get.find<InvestmentController>().hasNext()){
        Get.find<InvestmentController>().loadPaginationData();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvestmentController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.getScreenBgColor(),
          appBar: CustomAppBar(
            isShowBackBtn: true,
            title: MyStrings.investment.tr,
            bgColor: MyColor.getAppbarBgColor(),
          ),
          body: Padding(
            padding: Dimensions.screenPaddingHV,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColor.colorGrey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: PlanTabBar(text: MyStrings.activePlan.tr,isActive:controller.isActive,press: (){
                          controller.changeIndex();
                        },)),
                        Expanded(child: PlanTabBar(text: MyStrings.completePlan.tr,isActive:!controller.isActive,press: (){
                          controller.changeIndex();
                        },),)
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: Dimensions.space25),

                controller.isLoading?const Expanded(child:CustomLoader()):
                controller.investmentList.isEmpty ? const Expanded(child: NoDataWidget()):
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    padding: EdgeInsets.zero,
                    controller: _controller,
                    shrinkWrap: true,
                    itemCount: controller.investmentList.length+1,
                    separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                    itemBuilder: (context, index) {
                      if(controller.investmentList.length == index){
                        return Center(
                          child: controller.hasNext()?Container(
                            margin: const EdgeInsets.all(10),
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(color: MyColor.getPrimaryColor()),
                          ): const SizedBox(),
                        );
                      }
                      Data model = controller.investmentList[index];
                      return ActivePlanCard(
                        hasCapital: model.plan?.capitalBack == '1'?true:false,
                        percent: controller.getPercent(index),
                        name: (model.plan?.name??'').tr,
                        nextReturn: DateConverter.nextReturnTime(model.nextTime??''),
                        totalReturn: '${Converter.twoDecimalPlaceFixedWithoutRounding(model.interest??'0')} X ${Converter.twoDecimalPlaceFixedWithoutRounding(model.returnRecTime??'0',precision: 0)} = ${controller.curSymbol}${Converter.twoDecimalPlaceFixedWithoutRounding(model.paid??'0')}',
                        invested: '${Converter.twoDecimalPlaceFixedWithoutRounding(model.amount??'')} ${controller.currency}',
                        isActive: controller.isActive,
                        message: controller.getMessage(index),
                      ) ;
                    },
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
