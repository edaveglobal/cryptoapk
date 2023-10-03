import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyip_lab/core/utils/dimensions.dart';
import 'package:hyip_lab/core/utils/my_color.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/core/utils/style.dart';
import 'package:hyip_lab/data/controller/deposit_controller/deposit_controller.dart';
import 'package:hyip_lab/view/components/text-field/search_text_field.dart';

import '../../../../../core/utils/util.dart';

class DepositHistoryTop extends StatefulWidget {

  const DepositHistoryTop({Key? key}) : super(key: key);

  @override
  State<DepositHistoryTop> createState() => _DepositHistoryTopState();
}

class _DepositHistoryTopState extends State<DepositHistoryTop> {

  @override
  Widget build(BuildContext context) {

    return GetBuilder<DepositController>(
      builder: (controller) =>  Container(
          padding: const EdgeInsets.symmetric(horizontal:  Dimensions.space15,vertical: Dimensions.space15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.defaultRadius1),
              color: MyColor.getCardBg(),
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(MyStrings.transactionNo.tr, style: interRegularSmall.copyWith(color: MyColor.getLabelTextColor(),fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,),
            const SizedBox(height: Dimensions.space5 + 3),
            IntrinsicHeight(
              child: Row(
                children: [
                Expanded(
                  child: SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: SearchTextField(
                          needOutlineBorder: true,
                          controller: controller.searchController,
                          onChanged: (value){
                            return;
                          },
                          hintText: MyStrings.searchByTrxId.tr,
                        ),
                      ),
                ),
                  const SizedBox(width: Dimensions.space10),
                  InkWell(
                    onTap: () {
                      controller.searchDepositTrx();
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(4),
                        color: MyColor.getPrimaryColor(),
                      ),
                      child: Icon(Icons.search_outlined, color:  MyColor.getButtonTextColor(), size: 18),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
