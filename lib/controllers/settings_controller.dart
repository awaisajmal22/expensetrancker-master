import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/constants/theme.dart';
import 'package:flutter_expense_tracker_app/controllers/theme_controller.dart';
import 'package:flutter_expense_tracker_app/extension/localization_extension.dart';
import 'package:flutter_expense_tracker_app/views/screens/currency_screen.dart';
import 'package:flutter_expense_tracker_app/views/screens/language_screen.dart';
import 'package:flutter_expense_tracker_app/views/screens/theme_screen.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
 
}

class SettingsModel {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  SettingsModel(
      {required this.onTap, required this.subtitle, required this.title});
}
