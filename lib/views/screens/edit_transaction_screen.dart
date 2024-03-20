import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/constants/categories.dart';
import 'package:flutter_expense_tracker_app/constants/colors.dart';
import 'package:flutter_expense_tracker_app/constants/mystyle.dart';
import 'package:flutter_expense_tracker_app/constants/theme.dart';
import 'package:flutter_expense_tracker_app/controllers/add_transaction_controller.dart';
import 'package:flutter_expense_tracker_app/controllers/language_controller.dart';
import 'package:flutter_expense_tracker_app/controllers/theme_controller.dart';
import 'package:flutter_expense_tracker_app/extension/localization_extension.dart';
import 'package:flutter_expense_tracker_app/models/transaction.dart';
import 'package:flutter_expense_tracker_app/providers/database_provider.dart';
import 'package:flutter_expense_tracker_app/views/widgets/input_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditTransactionScreen extends StatefulWidget {
  final TransactionModel tm;
  EditTransactionScreen({
    Key? key,
    required this.tm,
  }) : super(key: key);

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  final AddTransactionController _addTransactionController =
      Get.put(AddTransactionController());

  final _themeController = Get.find<ThemeController>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _amountController = TextEditingController();
  final LanguageController _languageController = Get.put(LanguageController());
  String? _transactionType;
  String? _selectedDate;
  String? _selectedCategory;
  String? _selectedMode;
  String? _selectedTime;
  String? _selectedImage;

  @override
  void initState() {
    super.initState();
    setState(() {
      _nameController.text = widget.tm.name!;
      _amountController.text = widget.tm.amount!;
      _transactionType = widget.tm.type!;
      _selectedDate = widget.tm.date!;
      _selectedCategory = widget.tm.category!;
      _selectedMode = widget.tm.mode!;
      _selectedImage = widget.tm.image!;
      _selectedTime = widget.tm.time!;
    });
    // _addTransactionController.initializeControllers(widget.tm);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _transactionTypes = [
      context.local.income,
      context.local.expense
    ];
    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _appBar(
          context: context,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(
                  //   'Transaction Image',
                  //   style: Themes().labelStyle,
                  // ),
                  TextButton.icon(
                      onPressed: () async {
                        await DatabaseProvider.deleteTransaction(widget.tm.id!);
                        Get.back();
                      },
                      icon: Icon(
                        Icons.delete,
                        color: pinkClr,
                      ),
                      label: Text(
                        context.local.deleteTransaction,
                        style: TextStyle(
                          color: pinkClr,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              // _selectImage(context),
              SizedBox(
                height: 8.h,
              ),
              InputField(
                hint: context.local.transactionName,
                label: context.local.transactionName,
                controller: _nameController,
              ),
              InputField(
                hint: context.local.transactionAmount,
                label: context.local.transactionAmount,
                controller: _amountController,
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      hint: _addTransactionController.selectedDate.isNotEmpty
                          ? _addTransactionController.selectedDate
                          : _selectedTime!,
                      label: context.local.date,
                      widget: IconButton(
                        onPressed: () => _getDateFromUser(context),
                        icon: Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: InputField(
                      hint: _addTransactionController.selectedTime.isNotEmpty
                          ? _addTransactionController.selectedTime
                          : _selectedTime!,
                      label: context.local.time,
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(context),
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InputField(
                hint: _addTransactionController.selectedCategory.isNotEmpty
                    ? _addTransactionController.selectedCategory
                    : _selectedCategory!,
                label: context.local.category,
                widget: IconButton(
                    onPressed: () => _showDialog(context, true),
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                    )),
              ),
              InputField(
                hint: _addTransactionController.selectedMode.isNotEmpty
                    ? _addTransactionController.selectedMode
                    : _selectedMode!,
                isAmount: true,
                label: context.local.mode,
                widget: IconButton(
                    onPressed: () => _showDialog(context, false),
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                    )),
              ),
            ],
          ),
        ),
        floatingActionButton: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () => _updateTransaction(),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }

  // _selectImage(BuildContext context) {
  //   return _addTransactionController.selectedImage.isNotEmpty
  //       ? GestureDetector(
  //           onTap: () => _showOptionsDialog(context),
  //           child: CircleAvatar(
  //             radius: 30.r,
  //             backgroundImage: FileImage(
  //               File(_addTransactionController.selectedImage),
  //             ),
  //           ),
  //         )
  //       : _selectedImage!.isNotEmpty
  //           ? GestureDetector(
  //               onTap: () => _showOptionsDialog(context),
  //               child: CircleAvatar(
  //                 radius: 30.r,
  //                 backgroundImage: FileImage(
  //                   File(_selectedImage!),
  //                 ),
  //               ),
  //             )
  //           : GestureDetector(
  //               onTap: () => _showOptionsDialog(context),
  //               child: CircleAvatar(
  //                 radius: 30.r,
  //                 backgroundColor: Get.isDarkMode
  //                     ? Colors.grey.shade800
  //                     : Colors.grey.shade300,
  //                 child: Center(
  //                   child: Icon(
  //                     Icons.add_a_photo,
  //                     color: _themeController.color,
  //                   ),
  //                 ),
  //               ),
  //             );
  // }

  _updateTransaction() async {
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
        id: widget.tm.id!,
        type: _addTransactionController.transactionType.isEmpty
            // || _addTransactionController.transactionType == "Income"|| _addTransactionController.transactionType == "آمدنی"
            ? _transactionType!
            : _addTransactionController.transactionType,
        image: _addTransactionController.selectedImage.isNotEmpty
            ? _addTransactionController.selectedImage
            : _selectedImage!,
        name: _nameController.text,
        amount: _amountController.text,
        date: _addTransactionController.selectedDate.isNotEmpty
            ? _addTransactionController.selectedDate
            : _selectedDate!,
        time: _addTransactionController.selectedTime.isNotEmpty
            ? _addTransactionController.selectedTime
            : _selectedTime!,
        category: _addTransactionController.selectedCategory.isNotEmpty
            ? _addTransactionController.selectedCategory
            : _selectedCategory!,
        mode: _addTransactionController.selectedMode.isNotEmpty
            ? _addTransactionController.selectedMode
            : _selectedMode!,
      );
      await DatabaseProvider.updateTransaction(transactionModel);

      Get.back();
    }
  }

  // _showOptionsDialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) => SimpleDialog(
  //             children: [
  //               SimpleDialogOption(
  //                 onPressed: () async {
  //                   final image = await ImagePicker().pickImage(
  //                     source: ImageSource.gallery,
  //                   );
  //                   if (image != null) {
  //                     _addTransactionController.updateSelectedImage(image.path);
  //                   }
  //                 },
  //                 child: Row(children: [
  //                   Icon(Icons.image),
  //                   Padding(
  //                     padding: EdgeInsets.all(7),
  //                     child: Text(
  //                       'Galley',
  //                       style: TextStyle(
  //                         fontSize: 20.sp,
  //                       ),
  //                     ),
  //                   )
  //                 ]),
  //               ),
  //               SimpleDialogOption(
  //                 onPressed: () async {
  //                   final image = await ImagePicker().pickImage(
  //                     source: ImageSource.camera,
  //                   );
  //                   if (image != null) {
  //                     _addTransactionController.updateSelectedImage(image.path);
  //                   }
  //                 },
  //                 child: Row(children: [
  //                   Icon(Icons.camera),
  //                   Padding(
  //                     padding: EdgeInsets.all(7),
  //                     child: Text(
  //                       'Camera',
  //                       style: TextStyle(
  //                         fontSize: 20.sp,
  //                       ),
  //                     ),
  //                   )
  //                 ]),
  //               ),
  //               SimpleDialogOption(
  //                 onPressed: () => Get.back(),
  //                 child: Row(children: [
  //                   Icon(Icons.cancel),
  //                   Padding(
  //                     padding: EdgeInsets.all(7),
  //                     child: Text(
  //                       'Cancel',
  //                       style: TextStyle(
  //                         fontSize: 20.sp,
  //                       ),
  //                     ),
  //                   )
  //                 ]),
  //               ),
  //             ],
  //           ));
  // }

  _showDialog(BuildContext context, bool isCategories) {
    final _categories = [
      Get.context!.local.other,
      Get.context!.local.bills,
      Get.context!.local.clothes,
      Get.context!.local.eatingOut,
      Get.context!.local.education,
      Get.context!.local.entertainment,
      Get.context!.local.food,
      Get.context!.local.fruits,
      Get.context!.local.fuel,
      Get.context!.local.general,
      Get.context!.local.gifts,
      Get.context!.local.holiday,
      Get.context!.local.home,
      Get.context!.local.job,
      Get.context!.local.kids,
      Get.context!.local.misc,
      Get.context!.local.music,
      Get.context!.local.pets,
      Get.context!.local.shopping,
      Get.context!.local.sports,
      Get.context!.local.tickets,
      Get.context!.local.transportation,
      Get.context!.local.travel,
      Get.context!.local.wages,
    ];
    final _cashModes = [
      Get.context!.local.other,
      Get.context!.local.cash,
      Get.context!.local.creditCard,
      Get.context!.local.debitCard,
      Get.context!.local.netBanking,
      Get.context!.local.cheque,
    ];

    Get.defaultDialog(
      title: isCategories
          ? context.local.selectCategory
          : context.local.selectMode,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .7,
        height: MediaQuery.of(context).size.height * .4,
        child: ListView.builder(
          itemCount: isCategories ? _categories.length : _cashModes.length,
          itemBuilder: (context, i) {
            final data = isCategories ? _categories[i] : _cashModes[i];
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
      _addTransactionController.updateSelectedDate(
          DateFormat.yMd(_languageController.selectedLanguageCode)
              .format(pickerDate));
    }
  }

  _appBar({
    required BuildContext context,
  }) {
    final List<String> _transactionTypes = [
      context.local.income,
      context.local.expense
    ];
    final size = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        context.local.editTransaction,
        style: TextStyle(color: _themeController.color),
      ),
      leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: _themeController.color)),
      actions: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Get.isDarkMode ? Colors.white : Color(0xff222222),
                      width: 1)),
              child: Row(
                children: [
                  Text(
                    _addTransactionController.transactionType.isEmpty ||
                            _addTransactionController.transactionType ==
                                context.local.income ||
                            _addTransactionController.transactionType ==
                                "Income" ||
                            _addTransactionController.transactionType == "آمدنی"
                        ? _transactionTypes[0]
                        : _addTransactionController.transactionType,
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
                          color: _themeController.color,
                        ),
                        items: _transactionTypes
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
      ],
    );
  }
}
