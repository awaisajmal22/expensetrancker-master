import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/ads/internstitialads.dart';
import 'package:flutter_expense_tracker_app/ads/openMobAds.dart';
import 'package:flutter_expense_tracker_app/constants/colors.dart';
import 'package:flutter_expense_tracker_app/constants/custom_appbar.dart';
import 'package:flutter_expense_tracker_app/constants/theme.dart';
import 'package:flutter_expense_tracker_app/controllers/nav_bar_controller.dart';
import 'package:flutter_expense_tracker_app/controllers/theme_controller.dart';
import 'package:flutter_expense_tracker_app/extension/localization_extension.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ThemeScreen extends StatelessWidget {
  ThemeScreen({super.key});
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
          //   MaterialPageRoute(builder: (context) => ThemeScreen()),
          // );
        } else {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => ThemeScreen()),
          // );
        }
      });
    });
     RxList<ThemeModel> _themeDataList = <ThemeModel>[
    ThemeModel(
      title: context.local.lightTheme,
    ),
    ThemeModel(
      title: context.local.darkTheme,
    )
  ].obs;
    return Scaffold(
      bottomNavigationBar: GetX<NavBarController>(
          init: NavBarController(),
          builder: (_navBarController) {
            return _navBarController.isAdLoaded.value == true
                ? SizedBox(
                    height: _navBarController.bannerAd.size.height.toDouble(),
                    width: _navBarController.bannerAd.size.width.toDouble(),
                    child: AdWidget(ad: _navBarController.bannerAd),
                  )
                : SizedBox.shrink();
          }),
      body: SafeArea(
          child: Column(
        children: [
          customAppBar(title: context.local.themeTitle, themeController: _themeController),
          Expanded(
              child: Column(
            children: List.generate(
                _themeDataList.length,
                (index) => GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          _themeController.switchTheme(isDark: false);
                        }
                        if (index == 1) {
                          _themeController.switchTheme(isDark: true);
                        }
                       
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_themeDataList[index].title),
                            Obx(() => _themeController.selectedThemeIndex ==
                                    index
                                ? Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: primaryColor,
                                    ),
                                    child:
                                        Icon(Icons.check, color: Colors.white))
                                : SizedBox.shrink()),
                          ],
                        ),
                      ),
                    )),
          ))
        ],
      )),
    );
  }
}
