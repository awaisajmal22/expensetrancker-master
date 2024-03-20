import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/constants/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputField extends StatelessWidget {
  final String label;
  final String hint;
  final bool? isAmount;
  final TextEditingController? controller;
  final Widget? widget;
  InputField({
    Key? key,
    required this.hint,
    required this.label,
    this.isAmount = false,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 14.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   label,
          //   style: Themes().labelStyle,
          // ),
          Container(
            height: 48.h,
            margin: EdgeInsets.only(
              top: 6.h,
            ),
            padding: EdgeInsets.only(left: 14.w, right: 14.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffF1F1FA),
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(
                10.r,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType:
                        isAmount! ? TextInputType.number : TextInputType.text,
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    cursorColor: Get.isDarkMode
                        ? Colors.grey.shade100
                        : Colors.grey.shade700,
                    controller: controller,
                    style: Themes().labelStyle,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                        hintStyle: Themes().labelStyle),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AttachmentField extends StatelessWidget {
  // final String label;
  final String hint;
  final bool? isAmount;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  AttachmentField({
    Key? key,
    required this.hint,
    // required this.label,
    this.isAmount = false,
    this.controller,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 14.h,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   label,
            //   style: Themes().labelStyle,
            // ),
            Container(
                height: 48.h,
                margin: EdgeInsets.only(
                  top: 6.h,
                ),
                padding: EdgeInsets.only(
                  left: 14.w,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffF1F1FA),
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(
                    10.r,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/attachment.svg'),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      hint,
                      style: Themes().labelStyle,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
