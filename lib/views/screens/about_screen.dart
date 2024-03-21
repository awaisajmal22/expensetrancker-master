import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_expense_tracker_app/constants/custom_appbar.dart';
import 'package:flutter_expense_tracker_app/constants/mystyle.dart';
import 'package:flutter_expense_tracker_app/controllers/theme_controller.dart';
import 'package:flutter_expense_tracker_app/extension/localization_extension.dart';
import 'package:flutter_expense_tracker_app/extension/size_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({super.key});

  final ThemeController _themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        customAppBar(
            title: context.local.aboutus, themeController: _themeController),
        Expanded(
            child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.local.aboutus,
                style: myStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    textColor: _themeController.color),
              ),
              SizedBox(
                height: context.sizer.height * 0.020,
              ),
              Text(
                context.local.aboutVconekt1,
                style: myStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    textColor: _themeController.color),
              ),
              SizedBox(
                height: context.sizer.height * 0.01,
              ),
              Text(
                context.local.aboutVconekt2,
                style: myStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    textColor: _themeController.color),
              ),
              SizedBox(
                height: context.sizer.height * 0.01,
              ),
              Text(
                context.local.aboutVconekt3,
                style: myStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    textColor: _themeController.color),
              ),
              SizedBox(
                height: context.sizer.height * 0.01,
              ),
              Text(
                context.local.aboutVconekt4,
                style: myStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    textColor: _themeController.color),
              ),
              SizedBox(
                height: context.sizer.height * 0.1,
              ),
            ],
          ),
        ))
      ])),
    );
  }
}
