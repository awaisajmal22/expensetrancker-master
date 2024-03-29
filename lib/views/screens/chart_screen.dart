import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/constants/colors.dart';
import 'package:flutter_expense_tracker_app/constants/mystyle.dart';
import 'package:flutter_expense_tracker_app/controllers/chart_controller.dart';
import 'package:flutter_expense_tracker_app/controllers/language_controller.dart';
import 'package:flutter_expense_tracker_app/controllers/nav_bar_controller.dart';
import 'package:flutter_expense_tracker_app/controllers/theme_controller.dart';
import 'package:flutter_expense_tracker_app/extension/localization_extension.dart';
import 'package:flutter_expense_tracker_app/views/screens/add_transaction_screen.dart';
import 'package:flutter_expense_tracker_app/views/screens/all_transactions_screen.dart';
import 'package:flutter_expense_tracker_app/views/widgets/chart.dart';
import 'package:flutter_expense_tracker_app/views/widgets/placeholder_info.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ChartScreen extends StatelessWidget {
  ChartScreen({Key? key}) : super(key: key);
  final ChartController _chartController = Get.put(ChartController());
  final _themeController = Get.find<ThemeController>();
  final _homeController = Get.put(NavBarController());
  final _languageController = Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    final List<String> _transactionTypes = [
      context.local.income,
      context.local.expense
    ];
    final size = MediaQuery.of(context).size;
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(
            // horizontal: 20,
            // vertical: 10,
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _appBar(
              context: context,
            ),
            SizedBox(
              height: size.height * 0.020,
            ),
            Chart(
              isExpense: _chartController.isExpense.value,
              myTransactions: _homeController.myTransactions,
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * .01,
            // ),
            _homeController.myTransactions.isEmpty
                ? Container()
                : Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Center(
                            child: IconButton(
                                onPressed: () => _showDatePicker(context),
                                icon: Icon(
                                  Icons.calendar_month,
                                  color: _themeController.color,
                                ))),
                      ),
                      title: Text(
                        _homeController.selectedDate.day == DateTime.now().day
                            ? context.local.today
                            : DateFormat.yMd(
                                    _languageController.selectedLanguageCode)
                                .format(_homeController.selectedDate),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 7.h,
                          ),
                          Text(
                            _homeController.totalForSelectedDate < 0
                                ? context.local.spent
                                : context.local.earn,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            '${_homeController.selectedCurrency.symbol}${_homeController.totalForSelectedDate.toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    ),
                  ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              // color: Colors.red,
              child: Column(
                children: [
                  PlaceholderInfo(),
                  _homeController.myTransactions.isNotEmpty
                      ? Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 10.h),
                          child: GestureDetector(
                            onTap: () => Get.to(() => AllTransactionsScreen()),
                            child: Text(
                              context.local.showAllTransaction,
                              style: myStyle(textColor: _themeController.color),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: primaryColor,
      //   onPressed: () async {
      //     await Get.to(() => AddTransactionScreen());
      //     _homeController.getTransactions();
      //   },
      //   child: Icon(
      //     Icons.add,
      //   ),
      // ),
    );
  }

  _appBar({
    required BuildContext context,
  }) {
    final size = MediaQuery.of(context).size;
    final List<String> _transactionTypes = [
      context.local.income,
      context.local.expense
    ];
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        context.local.statistics,
        style: TextStyle(color: _themeController.color),
      ),
      leading: GetX<NavBarController>(builder: (cont) {
        return IconButton(
          onPressed: () {
            cont.selectedNavBarIndex.value = 0;
          },
          icon: Icon(Icons.arrow_back, color: _themeController.color),
        );
      }),
      actions: _homeController.myTransactions.isEmpty
          ? []
          : [
              Container(
                margin: EdgeInsets.only(right: 10),
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color:
                            Get.isDarkMode ? Colors.white : Color(0xff222222),
                        width: 1)),
                child: Row(
                  children: [
                    Text(
                      _chartController.transactionType.isEmpty ||
                              _chartController.transactionType == "Income" ||
                              _chartController.transactionType == "آمدنی"
                          ? _transactionTypes[0]
                          : _chartController.transactionType,
                      style: myStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: _themeController.color,
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
                            // print(val);
                            _chartController
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
    );
  }

  _showDatePicker(BuildContext context) async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2012),
        initialDate: DateTime.now(),
        lastDate: DateTime(2122));
    if (pickerDate != null) {
      _homeController.updateSelectedDate(pickerDate);
    }
  }
}
