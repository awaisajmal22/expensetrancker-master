import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/ads/internstitialads.dart';
import 'package:flutter_expense_tracker_app/ads/openMobAds.dart';
import 'package:flutter_expense_tracker_app/extension/localization_extension.dart';
import 'package:flutter_expense_tracker_app/views/screens/nav_bar_screen.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Onboarding extends StatelessWidget {
  Onboarding({super.key});
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
          //   MaterialPageRoute(builder: (context) => Onboarding()),
          // );
        } else {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => Onboarding()),
          // );
        }
      });
    });

    return Scaffold(
      // backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              SvgPicture.asset(
                "assets/onboard background.svg",
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 0, // Adjust the top value as needed
                left: 0, // Adjust the left value as needed
                right: 0, // Adjust the right value as needed
                child: Image.asset(
                  "assets/Man.png",
                  // width: 200,
                  // height: 200,
                ),
              ),
              Positioned(
                top: 110, // Adjust the top value as needed
                left: 30, // Adjust the left value as needed
                // right: 0, // Adjust the right value as needed
                child: Image.asset(
                  "assets/Coint.png",
                  // width: 200,
                  // height: 200,
                ),
              ),
              Positioned(
                top: 160, // Adjust the top value as needed
                // left: 0, // Adjust the left value as needed
                right: 30, // Adjust the right value as needed
                child: Image.asset(
                  "assets/Donut.png",
                  // width: 200,
                  // height: 200,
                ),
              ),
            ],
          ),
          Center(
              child: Text(
            context.local.onboardingTitle1,
            style: TextStyle(
                color: Color(0xff2788FF),
                fontWeight: FontWeight.w600,
                fontSize: 26),
          )),
          Center(
              child: Text(context.local.onboardingTitle2,
                  style: TextStyle(
                      color: Color(0xff2788FF),
                      fontWeight: FontWeight.w600,
                      fontSize: 26))),
          ElevatedButton(
            onPressed: () async {
              // Navigator.pushNamed(context, '/homepage');
              await Get.offAll(NavBarScreen());
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                Size.fromWidth(200),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(
                Color(0xff2788FF), // Set your desired background color
              ),
            ),
            child: Text(
              context.local.onboardingButtonText,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
