import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/data/controller/account/transaction_history_controller.dart';
import 'package:hyip_lab/view/components/animated_widget/expanded_widget.dart';
import 'package:hyip_lab/view/components/column/card_column.dart';
import 'package:hyip_lab/view/components/divider/custom_divider.dart';

class CustomTransactionCard extends StatelessWidget {

  final String trxData;
  final String dateData;
  final String amountData;
  final String detailsText;
  final String postBalanceData;
  final int index;

  const CustomTransactionCard({

    Key? key,
    required this.index,
    required this.trxData,
    required this.dateData,
    required this.amountData,
    required this.postBalanceData,
    required this.detailsText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<TransactionController>(
      builder: (controller) => GestureDetector(
        onTap: (){
          controller.changeSelectedCardIndex(index);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 13),
          decoration: BoxDecoration(
              color: MyColor.getCardBg(),
              borderRadius: BorderRadius.circular(5)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardColumn(header:MyStrings.trx, body: trxData),
                  CardColumn(alignmentEnd:true,header:MyStrings.date, body: dateData),
                ],
              ),

              const CustomDivider(space: Dimensions.space15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  CardColumn(header:MyStrings.amount, body: amountData),
                  CardColumn(alignmentEnd:true,header:MyStrings.postBalance, body: postBalanceData),
                ],
              ),

              ExpandedSection(
                expand: controller.selectedCardIndex==index,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomDivider(space: Dimensions.space15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(MyStrings.details.tr, style: interRegularExtraSmall.copyWith(color: MyColor.getLabelTextColor())),
                      const SizedBox(height: 8),
                      Text(detailsText, style: interRegularDefault.copyWith(color: MyColor.getTextColor()))
                    ],
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
  
  Color changeTextColor(String trxType, TransactionController controller){
    trxType = controller.transactionList[index].trxType ?? "";
    return trxType == "-" ? MyColor.red : MyColor.green;
  }
}
