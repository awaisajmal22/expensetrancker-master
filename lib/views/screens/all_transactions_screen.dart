import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/constants/mystyle.dart';
import 'package:flutter_expense_tracker_app/controllers/add_transaction_controller.dart';

import 'package:flutter_expense_tracker_app/controllers/nav_bar_controller.dart';
import 'package:flutter_expense_tracker_app/controllers/theme_controller.dart';
import 'package:flutter_expense_tracker_app/extension/localization_extension.dart';
import 'package:flutter_expense_tracker_app/views/screens/edit_transaction_screen.dart';
import 'package:flutter_expense_tracker_app/views/widgets/transaction_tile.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllTransactionsScreen extends StatelessWidget {
  AllTransactionsScreen({Key? key}) : super(key: key);
  final NavBarController _homeController = Get.find();
  final AddTransactionController _addTransactionController =
      Get.put(AddTransactionController());
  final ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final List<String> _transactionTypes = [
      context.local.income,
      context.local.expense
    ];
    return Obx(() {
      return Scaffold(
        appBar: _appBar(
          context: context,
        ),
        body: ListView.builder(
          itemCount: _homeController.myTransactions.length,
          itemBuilder: (context, i) {
            final transaction = _homeController.myTransactions[i];
            print(transaction.type);
            final text =
                '${_homeController.selectedCurrency.symbol}${transaction.amount}';
bool backendtype = transaction.type == "آمدنی" || transaction.type == "Income"
                      ? true
                      : false;
bool frontendtype =_addTransactionController.transactionType == "آمدنی" || _addTransactionController.transactionType == "Income"
                      ? true
                      : false;

            if (backendtype ==frontendtype ) {
              final bool isIncome =
                  transaction.type == "آمدنی" || transaction.type == "Income"
                      ? true
                      : false;
              final formatAmount = isIncome ? '+ $text' : '- $text';
              return GestureDetector(
                onTap: () async {
                  await Get.to(() => EditTransactionScreen(tm: transaction));
                  _homeController.getTransactions();
                },
                child: TransactionTile(
                    transaction: transaction,
                    formatAmount: formatAmount,
                    isIncome: isIncome),
              );
            }
            return SizedBox();
          },
        ),
      );
    });
  }

  AppBar _appBar({
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
        context.local.allTransactions,
        style: TextStyle(color: _themeController.color),
      ),
      leading: GetX<NavBarController>(
          init: NavBarController(),
          builder: (_navBarController) {
            return IconButton(
                onPressed: () {
                  Get.back();
                  _navBarController.isShowTransactionHistoryScreen.value =
                      false;
                },
                icon: Icon(Icons.arrow_back, color: _themeController.color));
          }),
      actions: [
        Row(
          children: [
            // Text(
            //   _addTransactionController.transactionType.isEmpty
            //       ? _transactionTypes[0]
            //       : _addTransactionController.transactionType,
            //   style: TextStyle(
            //     fontSize: 14.sp,
            //     color: _themeController.color,
            //   ),
            // ),
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
                          print("aaa" + val.toString());
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
