import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/ads/internstitialads.dart';
import 'package:flutter_expense_tracker_app/ads/openMobAds.dart';
import 'package:flutter_expense_tracker_app/constants/colors.dart';
import 'package:flutter_expense_tracker_app/constants/mystyle.dart';
import 'package:flutter_expense_tracker_app/controllers/nav_bar_controller.dart';
import 'package:flutter_expense_tracker_app/controllers/theme_controller.dart';
import 'package:flutter_expense_tracker_app/extension/localization_extension.dart';
import 'package:flutter_expense_tracker_app/models/transaction.dart';
import 'package:flutter_expense_tracker_app/views/screens/nav_bar_screen.dart';
import 'package:flutter_expense_tracker_app/views/widgets/transaction_tile.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  // final NavBarController _navBarController = Get.put(NavBarController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetX<NavBarController>(
        init: NavBarController(),
        builder: (_navBarController) {
          _navBarController.getTimeString(context);
          return Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: 287,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Color(0Xff4498FF),
                        Color(0Xff0072FF),
                      ])),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.08,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.local.hello,
                                    style: myStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    _navBarController.greeting.value,
                                    style: myStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  'assets/icons/alert.png',
                                  height: size.height * 0.040,
                                  width: size.width * 0.080,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.2),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 15, bottom: 30),
                        height: size.height * 0.26,
                        width: size.width * 0.90,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 30,
                                  spreadRadius: 0,
                                  offset: Offset(0, 10))
                            ],
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.local.totalBalance,
                                  style: myStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${_navBarController.selectedCurrency.symbol} ${_navBarController.totalBalance.value.toStringAsFixed(2)}",
                                  style: myStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/icons/arrow_down.png',
                                          height: 24,
                                          width: 24,
                                        ),
                                        Text(
                                          context.local.income,
                                          style: myStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              textColor: Color(0xffD0E5E4)),
                                        )
                                      ],
                                    ),
                                    Text(
                                      '${_navBarController.selectedCurrency.symbol} ${_navBarController.totalIncome.value.toStringAsFixed(2)}',
                                      style: myStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          textColor: Colors.white),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/icons/arrow_top.png',
                                          height: 24,
                                          width: 24,
                                        ),
                                        Text(
                                          context.local.expense,
                                          style: myStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              textColor: Color(0xffD0E5E4)),
                                        )
                                      ],
                                    ),
                                    Text(
                                      '${_navBarController.selectedCurrency.symbol} ${_navBarController.totalExpense.value.toStringAsFixed(2)}',
                                      style: myStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          textColor: Colors.white),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.020,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(context.local.transaction,
                        style: myStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            textColor: Get.isDarkMode
                                ? Colors.white
                                : Color(0xff222222))),
                    GestureDetector(
                      onTap: () {
                        _navBarController.isShowTransactionHistoryScreen.value =
                            true;

                        print("changed");
                      },
                      child: Text(
                        context.local.seeall,
                        style: myStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textColor: Get.isDarkMode
                                ? Colors.white
                                : Color(0xff666666)),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  // color: Colors.red,
                  // height: size.height * 0.40,
                  child: ListView.builder(
                      padding: EdgeInsets.only(bottom: size.height * 0.1),
                      itemCount: _navBarController.myTransactions.length,
                      itemBuilder: (context, index) {
                        TransactionModel _transcation =
                            _navBarController.myTransactions[index];
                        return TransactionTile(
                            transaction: TransactionModel(
                              image: _transcation.image,
                              id: _transcation.id,
                              type: _transcation.type,
                              name: _transcation.name,
                              amount: _transcation.type == "آمدنی" ||
                                      _transcation.type == "Income"
                                  ? "+ ${_navBarController.selectedCurrency.symbol}${_transcation.amount}"
                                  : "- ${_navBarController.selectedCurrency.symbol}${_transcation.amount}",
                              time: _transcation.time,
                              date: _transcation.date,
                              category: _transcation.category,
                              mode: _transcation.mode,
                            ),
                            formatAmount: _transcation.type == "آمدنی" ||
                                    _transcation.type == "Income"
                                ? "+ ${_navBarController.selectedCurrency.symbol}${_transcation.amount}"
                                : "- ${_navBarController.selectedCurrency.symbol}${_transcation.amount}",
                            isIncome: _transcation.type == "آمدنی" ||
                                    _transcation.type == "Income"
                                ? true
                                : false);
                      }))
            ],
          );
        });
  }
}
