import 'package:flutter/material.dart';

myStyle({
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.normal,
  Color textColor = Colors.white,
}){
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: 'Inter',
    color: textColor,
  );
}