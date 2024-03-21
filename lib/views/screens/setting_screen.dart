import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/constants/colors.dart';
import 'package:flutter_expense_tracker_app/constants/constant.dart';
import 'package:flutter_expense_tracker_app/constants/theme.dart';
import 'package:flutter_expense_tracker_app/controllers/language_controller.dart';
import 'package:flutter_expense_tracker_app/controllers/nav_bar_controller.dart';
import 'package:flutter_expense_tracker_app/controllers/settings_controller.dart';
import 'package:flutter_expense_tracker_app/controllers/theme_controller.dart';
import 'package:flutter_expense_tracker_app/extension/localization_extension.dart';
import 'package:flutter_expense_tracker_app/extension/size_extension.dart';
import 'package:flutter_expense_tracker_app/views/screens/about_screen.dart';
import 'package:flutter_expense_tracker_app/views/screens/currency_screen.dart';
import 'package:flutter_expense_tracker_app/views/screens/language_screen.dart';
import 'package:flutter_expense_tracker_app/views/screens/theme_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final _themeController = Get.find<ThemeController>();
  final NavBarController _navBarController = Get.put(NavBarController());
  final LanguageController _languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    Widget _socialMediaIcons =
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      GestureDetector(
        onTap: () async {
          if (await canLaunch(Constant.facebookUrl)) {
            await launch(Constant.facebookUrl);
          } else {
            throw 'Could not launch ${Constant.facebookUrl}';
          }
        },
        child: Icon(
          FontAwesomeIcons.facebook,
          size: context.sizer.width * 0.1,
        ),
      ),
      GestureDetector(
        onTap: () async {
          if (await canLaunch(Constant.instagramUrl)) {
            await launch(Constant.instagramUrl);
          } else {
            throw 'Could not launch ${Constant.instagramUrl}';
          }
        },
        child: Icon(
          FontAwesomeIcons.instagram,
          size: context.sizer.width * 0.1,
        ),
      ),
      GestureDetector(
        onTap: () async {
          if (await canLaunch(Constant.twitterUrl)) {
            await launch(Constant.twitterUrl);
          } else {
            throw 'Could not launch ${Constant.twitterUrl}';
          }
        },
        child: Icon(
          FontAwesomeIcons.twitter,
          size: context.sizer.width * 0.1,
        ),
      ),
      GestureDetector(
        onTap: () async {
          if (await canLaunch(Constant.linkdinUrl)) {
            await launch(Constant.linkdinUrl);
          } else {
            throw 'Could not launch ${Constant.linkdinUrl}';
          }
        },
        child: Icon(
          FontAwesomeIcons.linkedin,
          size: context.sizer.width * 0.1,
        ),
      ),
    ]);
    RxList<SettingsModel> _settingsList = <SettingsModel>[
      SettingsModel(
          onTap: () {
            Get.to(CurrencyScreen());
          },
          subtitle: '',
          title: context.local.currency),
      SettingsModel(
          onTap: () {
            Get.to(LangauageScreen());
          },
          subtitle: '',
          title: context.local.language),
      SettingsModel(
          onTap: () {
            Get.to(ThemeScreen());
          },
          subtitle: '',
          title: context.local.themeTitle),
      // SettingsModel(
      //     onTap: () {}, subtitle: '', title: context.local.notification),
      SettingsModel(
          onTap: () {
            Get.to(AboutUsScreen());
          },
          subtitle: '',
          title: context.local.about),
      SettingsModel(
          onTap: () async {
            if (await canLaunch(Constant.appPlaystoreUrl)) {
              await launch(Constant.appPlaystoreUrl);
            } else {
              throw 'Could not launch ${Constant.appPlaystoreUrl}';
            }
          },
          subtitle: '',
          title: context.local.rate),
    ].obs;
    return Column(
      children: [
        AppBar(
          elevation: 0,
          leading: Obx(
            () => IconButton(
              onPressed: () {
                _navBarController.selectedNavBarIndex.value = 0;
              },
              icon: Icon(Icons.arrow_back, color: _themeController.color),
            ),
          ),
          title: Text(
            context.local.settings,
          ),
        ),
        Flexible(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: _settingsList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: _settingsList[index].onTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _settingsList[index].title,
                          ),
                          Row(
                            children: [
                              if (index == 0)
                                Obx(() => Text(
                                    _navBarController.selectedCurrency.symbol)),
                              if (index == 1)
                                Text(_languageController.selectedLanguage),
                              if (index == 2)
                                Text(_themeController.selectedThemeIndex == 0
                                    ? context.local.lightTheme
                                    : context.local.darkTheme)
                              else
                                Text(_settingsList[index].subtitle),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: primaryColor,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                })),
        SizedBox(
          height: context.sizer.height * 0.05,
        ),
        _socialMediaIcons
      ],
    );
  }
}
