import 'package:flutter/material.dart';
import 'package:hyip_lab/core/utils/my_strings.dart';
import 'package:hyip_lab/view/components/no_data/no_data_widget.dart';


class NoDataFoundScreen extends StatelessWidget {

  const NoDataFoundScreen({
    Key? key,
    this.title = MyStrings.noDataFound,
    this.topMargin = 5,
    this.bottomMargin = 10,
    this.height = .8,
  }) : super(key: key);

  final double height;
  final String title;
  final double bottomMargin;
  final double topMargin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SizedBox(height:MediaQuery.of(context).size.height*height,
            child: NoDataWidget(
              bottomMargin: bottomMargin,topMargin: topMargin,title: title,)));
  }
}
