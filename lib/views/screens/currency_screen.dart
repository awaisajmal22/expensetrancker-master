import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/ads/internstitialads.dart';
import 'package:flutter_expense_tracker_app/ads/openMobAds.dart';
import 'package:flutter_expense_tracker_app/constants/colors.dart';
import 'package:flutter_expense_tracker_app/constants/custom_appbar.dart';
import 'package:flutter_expense_tracker_app/controllers/nav_bar_controller.dart';
import 'package:flutter_expense_tracker_app/controllers/theme_controller.dart';
import 'package:flutter_expense_tracker_app/extension/localization_extension.dart';
import 'package:flutter_expense_tracker_app/models/currency.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CurrencyScreen extends StatelessWidget {
  CurrencyScreen({super.key});
  final _navBarController = Get.find<NavBarController>();
  final _themeController = Get.find<ThemeController>();
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
          //   MaterialPageRoute(builder: (context) => CurrencyScreen()),
          // );
        } else {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => CurrencyScreen()),
          // );
        }
      });
    });
    return Scaffold(
      bottomNavigationBar: Obx(() => _navBarController.isAdLoaded.value == true
          ? SizedBox(
              height: _navBarController.bannerAd.size.height.toDouble(),
              width: _navBarController.bannerAd.size.width.toDouble(),
              child: AdWidget(ad: _navBarController.bannerAd),
            )
          : SizedBox.shrink()),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customAppBar(title: context.local.currency, themeController: _themeController),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  Currency.currencies.length,
                  (index) => GestureDetector(
                        onTap: () {
                          _navBarController.updateSelectedCurrency(
                              (Currency.currencies[index]), index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(Currency.currencies[index].currency),
                              Obx(() => _navBarController.currencyIndex == index
                                  ? Container(
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: primaryColor,
                                      ),
                                      child: Icon(Icons.check,
                                          color: Colors.white))
                                  : SizedBox.shrink()),
                            ],
                          ),
                        ),
                      )),
            ),
          ),
        ],
      )),
    );
  }
}
