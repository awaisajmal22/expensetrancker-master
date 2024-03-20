import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_expense_tracker_app/controllers/language_controller.dart';
import 'package:flutter_expense_tracker_app/controllers/theme_controller.dart';
import 'package:flutter_expense_tracker_app/extension/localization_extension.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../constants/colors.dart';
import '../../constants/custom_appbar.dart';

class LangauageScreen extends StatelessWidget {
  LangauageScreen({super.key});
  final _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<LanguageController>(
          init: LanguageController(),
          builder: (controller) {
            return SafeArea(
                child: Column(
              children: [
                customAppBar(title:  context.local.language,themeController: _themeController),
                Expanded(
                    child: Column(
                  children: List.generate(
                      controller.langaugesList.length,
                      (index) => GestureDetector(
                            onTap: () {
                            controller.switchLanguage(languageCode: controller.langaugesList[index].code, index: index,languageName: controller.langaugesList[index].language);
                              // if (index == 0) {
                              //   _themeController.switchTheme(loadTheme: true);
                              // }
                              // if (index == 1) {
                              //   _themeController.switchTheme(loadTheme: false);
                              // }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.langaugesList[index].language),
                                  
                                      controller.selectedLanguageIndex == index
                                          ? Container(
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: primaryColor,
                                              ),
                                              child: Icon(Icons.check,
                                                  color: Colors.white))
                                          : SizedBox.shrink(),
                                ],
                              ),
                            ),
                          )),
                ))
              ],
            ));
          }),
    );
  }

}
