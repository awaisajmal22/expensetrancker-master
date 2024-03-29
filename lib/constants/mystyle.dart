import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

myStyle({
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.normal,
  Color textColor = Colors.white,
}) {
  return TextStyle(
    fontSize: fontSize.h,
    fontWeight: fontWeight,
    fontFamily: 'Inter',
    color: textColor,
  );
}
