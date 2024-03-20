import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/constants/mystyle.dart';
import 'package:flutter_expense_tracker_app/controllers/nav_bar_controller.dart';
import 'package:flutter_expense_tracker_app/controllers/theme_controller.dart';
import 'package:flutter_expense_tracker_app/extension/localization_extension.dart';
import 'package:flutter_expense_tracker_app/views/widgets/show_transaction_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PlaceholderInfo extends StatelessWidget {
  PlaceholderInfo({Key? key}) : super(key: key);
  final _themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Get.find<NavBarController>().myTransactions.isEmpty
          ? Center(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/appicon.png',
                      height: size.height * 0.3,
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Text(context.local.chartDescription,
                        style: myStyle(
                            fontSize: 15, textColor: _themeController.color)),
                    Text(context.local.chartSubDescription,
                        style: myStyle(
                            fontSize: 13, textColor: _themeController.color))
                  ],
                ),
              ),
            )
          : ShowTransactions(),
    );
  }
}
