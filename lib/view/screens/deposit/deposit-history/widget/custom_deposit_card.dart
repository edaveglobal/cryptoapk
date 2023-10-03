import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/view/components/divider/custom_divider.dart';

import '../../../../components/column/card_column.dart';

class CustomDepositCard extends StatelessWidget {

  final String trxData;
  final String initiatedData;
  final String gatewayData;
  final String conversionData;
  final String amountData;
  final String statusData;
  final String amountConversion;
  final Color statusColor;

  const CustomDepositCard({

    Key? key,
    required this.trxData,
    required this.initiatedData,
    required this.gatewayData,
    required this.conversionData,
    required this.amountData,
    required this.statusData,
    required this.amountConversion,
    required this.statusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: MyColor.getCardBg(),
          borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

                CardColumn(
                  header: MyStrings.trx,
                  body: trxData,
                ),

              CardColumn(
                alignmentEnd: true,
                header: MyStrings.initiated,
                body: initiatedData,
              ),
            ],
          ),

          const CustomDivider(space: Dimensions.space10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardColumn(
                header: MyStrings.amount,
                body: amountData,
              ),

              CardColumn(
                alignmentEnd: true,
                header: MyStrings.gateway,
                body: gatewayData,
              ),
            ],
          ),

          const CustomDivider(space: Dimensions.space10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              CardColumn(
                header: "${MyStrings.conversion.tr}: ($amountConversion)",
                body: conversionData
              ),


              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: MyColor.transparentColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: statusColor, width: 0.5)
                ),
                child: Text(statusData, style: interRegularExtraSmall.copyWith(color: statusColor), textAlign: TextAlign.center),
              )
            ],
          ),
        ],
      ),
    );
  }
}
