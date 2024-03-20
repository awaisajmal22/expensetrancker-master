import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/constants/colors.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Themes {
  static final lightTheme = ThemeData(
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    primarySwatch: Colors.grey,
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightModeScaffoldBgCle,
    appBarTheme: AppBarTheme(
      backgroundColor: lightModeScaffoldBgCle,
      elevation: 0,
    ),
  );
  static final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.black,
      elevation: 0,
    ),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkModeScaffoldBgClr,
    appBarTheme: AppBarTheme(
      backgroundColor: darkModeScaffoldBgClr,
      elevation: 0,
    ),
  );

  TextStyle get subHeadingTextStyle => TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        fontFamily: 'Inter',
        color: Get.isDarkMode ? Colors.grey.shade400 : Colors.grey,
      );

  TextStyle get headingTextStyle => TextStyle(
        fontSize: 18.sp,
        fontFamily: 'Inter',
        fontWeight: FontWeight.bold,
      );

  TextStyle get titleStyle => TextStyle(
      fontSize: 18,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      color: Get.isDarkMode ? Colors.white : Color(0xff222222));
  TextStyle get subTitleStyle => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode ? Colors.grey.shade100 : Color(0xff91919F),
      );

  TextStyle get labelStyle => TextStyle(
        fontSize: 13.sp,
        fontFamily: 'Inter',
        color: Get.isDarkMode ? Colors.grey.shade100 : Color(0xff91919F),
      );
}
