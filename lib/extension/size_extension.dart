
import 'package:flutter/material.dart';

extension Sizer on BuildContext{
  Size get sizer => MediaQuery.of(this).size;
}