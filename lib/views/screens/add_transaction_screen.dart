import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/ads/internstitialads.dart';
import 'package:flutter_expense_tracker_app/ads/openMobAds.dart';
import 'package:flutter_expense_tracker_app/constants/categories.dart';
import 'package:flutter_expense_tracker_app/constants/colors.dart';
import 'package:flutter_expense_tracker_app/constants/mystyle.dart';
import 'package:flutter_expense_tracker_app/constants/theme.dart';
import 'package:flutter_expense_tracker_app/controllers/add_transaction_controller.dart';
import 'package:flutter_expense_tracker_app/controllers/theme_controller.dart';
import 'package:flutter_expense_tracker_app/extension/localization_extension.dart';
import 'package:flutter_expense_tracker_app/models/transaction.dart';
import 'package:flutter_expense_tracker_app/providers/database_provider.dart';
import 'package:flutter_expense_tracker_app/views/widgets/input_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddTransactionScreen extends StatelessWidget {
  AddTransactionScreen({Key? key}) : super(key: key);

  final AddTransactionController _addTransactionController =
      Get.put(AddTransactionController());

  final _themeController = Get.find<ThemeController>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final DateTime now = DateTime.now();
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();

  Future<void> getAdsData() async {
    AdmobHelper admobHelper = AdmobHelper();
    admobHelper.initialization();
    appOpenAdManager.loadAd();
  }

  @override
  Widget build(BuildContext context) {
    getAdsData().then((value) {
      Future.delayed(const Duration(seconds: 20), () {
        if (AppOpenAdManager.isLoaded) {
          appOpenAdManager.showAdIfAvailable(context);

          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => AddTransactionScreen()),
          // );
        } else {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => AddTransactionScreen()),
          // );
        }
      });
    });
    final size = MediaQuery.of(context).size;
    return Obx(() {
      return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: size.height * 1,
            width: size.width * 1,
            child: Stack(
              alignment: Alignment.bottomCenter,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Positioned(
                  // padding: const EdgeInsets.all(8.0),
                  top: 0,
                  left: 0, right: 0,
                  child: SizedBox(
                    height: size.height * 0.5,
                    child: Obx(() => _appBar(
                        color:
                            _addTransactionController.transactionType.isEmpty ||
                                    _addTransactionController.transactionType ==
                                        context.local.income
                                ? Color(0xff00A86B)
                                : Color(0xffFD3C4A),
                        context: context)),
                  ),
                ),

                // Text(
                //   'Transaction Image',
                //   style: Themes().labelStyle,
                // ),
                // SizedBox(
                //   height: 8.h,
                // ),
                // _addTransactionController.selectedImage.isNotEmpty
                //     ? GestureDetector(
                //         onTap: () => _showOptionsDialog(context),
                //         child: CircleAvatar(
                //           radius: 30.r,
                //           backgroundImage: FileImage(
                //             File(_addTransactionController.selectedImage),
                //           ),
                //         ),
                //       )
                //     : GestureDetector(
                //         onTap: () => _showOptionsDialog(context),
                //         child: CircleAvatar(
                //           radius: 30.r,
                //           backgroundColor: Get.isDarkMode
                //               ? Colors.grey.shade800
                //               : Colors.grey.shade300,
                //           child: Center(
                //             child: Icon(
                //               Icons.add_a_photo,
                //               color: _themeController.color,
                //             ),
                //           ),
                //         ),
                //       ),
                // SizedBox(
                //   height: 8.h,
                // ),
                Container(
                  height: size.height * 0.6,
                  decoration: BoxDecoration(
                      color: Get.isDarkMode ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    children: [
                      InputField(
                        hint: context.local.transactionName,
                        label: context.local.transactionName,
                        controller: _nameController,
                      ),

                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: InputField(
                      //         hint:
                      //             _addTransactionController.selectedDate.isNotEmpty
                      //                 ? _addTransactionController.selectedDate
                      //                 : DateFormat.yMd().format(now),
                      //         label: 'Date',
                      //         widget: IconButton(
                      //           onPressed: () => _getDateFromUser(context),
                      //           icon: Icon(
                      //             Icons.calendar_month_outlined,
                      //             color: Colors.grey,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 12.w,
                      //     ),
                      //     Expanded(
                      //       child: InputField(
                      //         hint:
                      //             _addTransactionController.selectedTime.isNotEmpty
                      //                 ? _addTransactionController.selectedTime
                      //                 : DateFormat('hh:mm a').format(now),
                      //         label: 'Time',
                      //         widget: IconButton(
                      //           onPressed: () => _getTimeFromUser(context),
                      //           icon: Icon(
                      //             Icons.access_time_rounded,
                      //             color: Colors.grey,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      InputField(
                        hint: _addTransactionController
                                .selectedCategory.isNotEmpty
                            ? _addTransactionController.selectedCategory
                            : categories[0],
                        label: 'Category',
                        widget: IconButton(
                            onPressed: () => _showDialog(context, true),
                            icon: Icon(
                              Icons.keyboard_arrow_down_sharp,
                            )),
                      ),
                      InputField(
                        hint: context.local.description,
                        label: context.local.description,
                        controller: _descriptionController,
                      ),
                      InputField(
                        hint: _addTransactionController.selectedMode.isNotEmpty
                            ? _addTransactionController.selectedMode
                            : cashModes[0],
                        isAmount: true,
                        label: context.local.mode,
                        widget: IconButton(
                            onPressed: () => _showDialog(context, false),
                            icon: Icon(
                              Icons.keyboard_arrow_down_sharp,
                            )),
                      ),
                      AttachmentField(
                        onTap: () {
                          _addTransactionController.pickImage();
                        },
                        hint: context.local.attachment,
                      ),
                      SizedBox(
                        height: size.height * 0.010,
                      ),
                      GestureDetector(
                        onTap: () => _addTransaction(context),
                        child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(16)),
                            child: Text(
                              _addTransactionController
                                          .transactionType.isEmpty ||
                                      _addTransactionController
                                              .transactionType ==
                                          context.local.income
                                  ? context.local.addIncome
                                  : context.local.addExpense,
                              style: myStyle(
                                textColor: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        // floatingActionButton:
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }

  _addTransaction(
    BuildContext context,
  ) async {
    final List<String> transactionTypes = [
      context.local.income,
      context.local.expense
    ];
    print(_addTransactionController.transactionType);
    if (_nameController.text.isEmpty || _amountController.text.isEmpty) {
      Get.snackbar(
        context.local.required,
        context.local.requiredall,
        backgroundColor:
            Get.isDarkMode ? Color(0xFF212121) : Colors.grey.shade100,
        colorText: pinkClr,
      );
    } else {
      final TransactionModel transactionModel = TransactionModel(
        id: DateTime.now().toString(),
        type: _addTransactionController.transactionType.isEmpty ||
                _addTransactionController.transactionType == "Income" ||
                _addTransactionController.transactionType == "آمدنی"
            ? transactionTypes[0]
            : _addTransactionController.transactionType,
        image: _addTransactionController.pickedImage.value,
        name: _nameController.text,
        amount: _amountController.text,
        date: DateFormat.yMd().format(now),
        time: DateFormat('hh:mm a').format(now),
        description: _descriptionController.text,
        category: _addTransactionController.selectedCategory.isNotEmpty
            ? _addTransactionController.selectedCategory
            : categories[0],
        mode: _addTransactionController.selectedMode.isNotEmpty
            ? _addTransactionController.selectedMode
            : cashModes[0],
      );
      await DatabaseProvider.insertTransaction(transactionModel);
      Get.back();
    }
  }

  _showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () async {
                    final image = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (image != null) {
                      _addTransactionController.updateSelectedImage(image.path);
                    }
                  },
                  child: Row(children: [
                    Icon(Icons.image),
                    Padding(
                      padding: EdgeInsets.all(7),
                      child: Text(
                        'Galley',
                        style: TextStyle(
                          fontSize: 20.sp,
                        ),
                      ),
                    )
                  ]),
                ),
                SimpleDialogOption(
                  onPressed: () async {
                    final image = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                    );
                    if (image != null) {
                      _addTransactionController.updateSelectedImage(image.path);
                    }
                  },
                  child: Row(children: [
                    Icon(Icons.camera),
                    Padding(
                      padding: EdgeInsets.all(7),
                      child: Text(
                        'Camera',
                        style: TextStyle(
                          fontSize: 20.sp,
                        ),
                      ),
                    )
                  ]),
                ),
                SimpleDialogOption(
                  onPressed: () => Get.back(),
                  child: Row(children: [
                    Icon(Icons.cancel),
                    Padding(
                      padding: EdgeInsets.all(7),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 20.sp,
                        ),
                      ),
                    )
                  ]),
                ),
              ],
            ));
  }

  _showDialog(BuildContext context, bool isCategories) {
    Get.defaultDialog(
      title: isCategories
          ? context.local.selectCategory
          : context.local.selectMode,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .7,
        height: MediaQuery.of(context).size.height * .4,
        child: ListView.builder(
          itemCount: isCategories ? categories.length : cashModes.length,
          itemBuilder: (context, i) {
            final data = isCategories ? categories[i] : cashModes[i];
            return ListTile(
              onTap: () {
                isCategories
                    ? _addTransactionController.updateSelectedCategory(data)
                    : _addTransactionController.updateSelectedMode(data);
                Get.back();
              },
              title: Text(data),
            );
          },
        ),
      ),
    );
  }

  _getTimeFromUser(
    BuildContext context,
  ) async {
    String? formatedTime;
    await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: DateTime.now().hour,
        minute: DateTime.now().minute,
      ),
    ).then((value) => formatedTime = value!.format(context));

    _addTransactionController.updateSelectedTime(formatedTime!);
  }

  _getDateFromUser(BuildContext context) async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2012),
        initialDate: DateTime.now(),
        lastDate: DateTime(2122));

    if (pickerDate != null) {
      _addTransactionController
          .updateSelectedDate(DateFormat.yMd().format(pickerDate));
    }
  }

  _appBar({Color color = Colors.transparent, required BuildContext context}) {
    final List<String> transactionTypes = [
      context.local.income,
      context.local.expense
    ];
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            backgroundColor: color,
            elevation: 0,
            title: Text(
              context.local.addTransaction,
              style: myStyle(
                  textColor: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back, color: Colors.white)),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 10),
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 1)),
                child: Row(
                  children: [
                    Text(
                      _addTransactionController.transactionType.isEmpty ||
                              _addTransactionController.transactionType ==
                                  context.local.income
                          ? transactionTypes[0]
                          : _addTransactionController.transactionType,
                      style: myStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.070,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          padding: EdgeInsets.all(0),
                          // customItemsHeight: 10,
                          isExpanded: true,

                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                          items: transactionTypes
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: FittedBox(
                                    child: Text(
                                      item,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (val) {
                            _addTransactionController
                                .changeTransactionType((val as String));
                          },
                          //  itemHeight: 30.h,
                          //   dropdownPadding: EdgeInsets.all(4),
                          //   dropdownWidth: 105.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
          Text(
            context.local.howMuch,
            style: myStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                textColor: Color(0xffFCFCFC)),
          ),
          Expanded(
            child: TextFormField(
              controller: _amountController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              style: myStyle(
                fontSize: 64,
                fontWeight: FontWeight.w600,
                textColor: Color(0xffFCFCFC),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
