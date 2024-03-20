import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/constants/colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final Rx<Color> _color = Colors.white.obs;
  final _box = GetStorage();
  final _key = 'isDarkMode';
  RxInt _selectedThemeIndex = 0.obs;
  Color get color => _color.value;
  @override
  void onInit() {
    super.onInit();
    _color.value = _loadThemeFromBox ? Colors.white : Colors.black;
    _selectedThemeIndex.value = _box.read('isDark') ?? 0;
  }

  ThemeMode get theme => _loadThemeFromBox ? ThemeMode.dark : ThemeMode.light;
  bool get _loadThemeFromBox => _box.read(_key) ?? false;
  int get selectedThemeIndex => _selectedThemeIndex.value;
  switchTheme({required bool isDark}) async {
   

    if (isDark == false) {
      await _box.write('isDark', 0);
      await _box.write(_key, isDark);
      Get.changeThemeMode(theme);
      _selectedThemeIndex.value = _box.read('isDark') ?? 0;
      _color.value = blackClr;
    } else if (isDark == true) {
      await _box.write('isDark', 1);
      await _box.write(_key, isDark);
      Get.changeThemeMode(theme);
      _selectedThemeIndex.value = _box.read('isDark') ?? 0;
      _color.value = Colors.white;
    }
    // await _box.write(_key, isDark);
    // _selectedThemeIndex.value = _box.read('isDark') ?? 0;
  }

 
}

class ThemeModel {
  final String title;

  ThemeModel({
    required this.title,
  });
}
