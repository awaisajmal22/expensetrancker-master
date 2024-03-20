
  import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/controllers/theme_controller.dart';
import 'package:get/get.dart';

AppBar customAppBar({required String title,required ThemeController themeController}) {
    return AppBar(
                leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Obx(
                    () => Icon(
                      Icons.arrow_back,
                      color: themeController.color,
                    ),
                  ),
                ),
                title: Text(
                 title
                ),
              );
  }