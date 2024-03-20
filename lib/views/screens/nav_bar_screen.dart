import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_expense_tracker_app/constants/colors.dart';
import 'package:flutter_expense_tracker_app/constants/mystyle.dart';
import 'package:flutter_expense_tracker_app/controllers/nav_bar_controller.dart';
import 'package:flutter_expense_tracker_app/controllers/theme_controller.dart';
import 'package:flutter_expense_tracker_app/models/currency.dart';
import 'package:flutter_expense_tracker_app/views/screens/add_transaction_screen.dart';
import 'package:flutter_expense_tracker_app/views/screens/all_transactions_screen.dart';
import 'package:flutter_expense_tracker_app/views/screens/chart_screen.dart';
import 'package:flutter_expense_tracker_app/views/screens/home_screen.dart';
import 'package:flutter_expense_tracker_app/views/screens/setting_screen.dart';
import 'package:flutter_expense_tracker_app/views/widgets/income_expense.dart';
import 'package:flutter_expense_tracker_app/views/widgets/placeholder_info.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

import '../../ads/internstitialads.dart';
import '../../ads/openMobAds.dart';

// ignore: must_be_immutable
class NavBarScreen extends StatelessWidget {
  NavBarScreen({super.key});

  // final NavBarController _navBarController = Get.find();
  final _themeController = Get.find<ThemeController>();
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();

  Future<void> getAdsData() async {
    AdmobHelper admobHelper = AdmobHelper();
    admobHelper.initialization();
    appOpenAdManager.loadAd();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    getAdsData().then((value) {
      Future.delayed(const Duration(seconds: 20), () {
        if (AppOpenAdManager.isLoaded) {
          appOpenAdManager.showAdIfAvailable(context);
          // Get.to(NavBarScreen());
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => NavBarScreen()),
          // );
        } else {
          // Get.to(NavBarScreen());
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => NavBarScreen()),
          // );
        }
      });
    });
    return Scaffold(

      // appBar: _appBar(),

      body: GetX<NavBarController>(
          init: NavBarController(),
          builder: (_navBarController) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                    height: size.height * 1.0,
                    width: size.width * 1.0,
                    child: _navBarController.selectedNavBarIndex.value == 0
                        ? _navBarController
                                    .isShowTransactionHistoryScreen.value ==
                                true
                            ? AllTransactionsScreen()
                            : HomeScreen()
                        : _navBarController.selectedNavBarIndex.value == 1
                            ? ChartScreen()
                            : SettingScreen()),
                GetX<NavBarController>(builder: (_navBarController) {
                  return SizedBox(
                    height: size.height * 0.1,
                    width: size.width,
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffD7D7D7),
                                width: 1,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                                _navBarController.navBarIconList.length,
                                (index) => GestureDetector(
                                      onTap: () {
                                        _navBarController
                                            .selectedNavBarIndex.value = index;
                                        _navBarController
                                            .isShowTransactionHistoryScreen
                                            .value = false;
                                        print(true);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              _navBarController
                                                  .navBarIconList[index],
                                              color: _navBarController
                                                          .selectedNavBarIndex
                                                          .value ==
                                                      index
                                                  ? primaryColor
                                                  : Colors.black),
                                          Container(
                                            width: size.width * 0.050,
                                            height: 1.5,
                                            color: _navBarController
                                                        .selectedNavBarIndex
                                                        .value ==
                                                    index
                                                ? primaryColor
                                                : Colors.transparent,
                                          )
                                        ],
                                      ),
                                    )),
                          ),
                        )),
                        SizedBox(
                          width: size.width * 0.040,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Get.to(() => AddTransactionScreen());
                            _navBarController.getTransactions();
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: primaryColor, shape: BoxShape.circle),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.040,
                        ),
                      ],
                    ),
                  );
                }),
              ],
            );
          }),
    );
  }

  Widget Homscreen_tree(BuildContext context) {
    return GetX<NavBarController>(
        init: NavBarController(),
        builder: (_navBarController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Balance',
                    style: TextStyle(
                      fontSize: 23.sp,
                      fontWeight: FontWeight.w400,
                      color: _themeController.color,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_navBarController.selectedCurrency.symbol}${_navBarController.totalBalance.value.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IncomeExpence(
                    isIncome: true,
                    symbol: _navBarController.selectedCurrency.symbol,
                    amount: _navBarController.totalIncome.value,
                  ),
                  // SizedBox(
                  //   width: 30.w,
                  // ),
                  IncomeExpence(
                    isIncome: false,
                    symbol: _navBarController.selectedCurrency.symbol,
                    amount: _navBarController.totalExpense.value,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .04.h,
              ),
              _navBarController.myTransactions.isEmpty
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
                                  onPressed: () => _showDatePicker(
                                      context, _navBarController),
                                  icon: Icon(
                                    Icons.calendar_month,
                                    color: _themeController.color,
                                  ))),
                        ),
                        title: Text(
                          _navBarController.selectedDate.day ==
                                  DateTime.now().day
                              ? 'Today'
                              : DateFormat.yMd()
                                  .format(_navBarController.selectedDate),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 7.h,
                            ),
                            Text(
                              _navBarController.totalForSelectedDate < 0
                                  ? 'You spent'
                                  : 'You earned',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              '${_navBarController.selectedCurrency.symbol}${_navBarController.totalForSelectedDate.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              PlaceholderInfo(),
              _navBarController.myTransactions.isNotEmpty
                  ? Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: GestureDetector(
                        onTap: () => Get.to(() => AllTransactionsScreen()),
                        child: Text('Show all transactions,'),
                      ),
                    )
                  : SizedBox(),
            ],
          );
        });
  }

  _showDatePicker(
      BuildContext context, NavBarController _navBarController) async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2012),
        initialDate: DateTime.now(),
        lastDate: DateTime(2122));
    if (pickerDate != null) {
      _navBarController.updateSelectedDate(pickerDate);
    }
  }

  Widget _appBar() {
    return GetX<NavBarController>(
        init: NavBarController(),
        builder: (_navBarController) {
          return AppBar(
            leading: IconButton(
              onPressed: () async {
                // _themeController.switchTheme();
              },
              icon: Icon(Get.isDarkMode ? Icons.nightlight : Icons.wb_sunny),
              color: _themeController.color,
            ),
            actions: [
              IconButton(
                onPressed: () => Get.to(() => ChartScreen()),
                icon: Icon(
                  Icons.bar_chart,
                  size: 27.sp,
                  color: _themeController.color,
                ),
              ),
              Row(
                children: [
                  Text(
                    _navBarController.selectedCurrency.currency,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        // customItemsHeight: 10,

                        icon: Obx(
                          () => Icon(
                            Icons.keyboard_arrow_down,
                            color: _themeController.color,
                          ),
                        ),
                        items: Currency.currencies
                            .map(
                              (item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item.currency,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (val) {
                          // _navBarController
                          //     .updateSelectedCurrency((val as Currency));
                        },
                        // itemHeight: 30.h,
                        // dropdownPadding: EdgeInsets.all(4),
                        // dropdownWidth: 105.w,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              )
            ],
          );
        });
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 20); // Start from the top-left
    path.quadraticBezierTo(size.width / 2, size.height, size.width,
        size.height - 20); // Define a quadratic Bezier curve
    path.lineTo(size.width, 0); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
