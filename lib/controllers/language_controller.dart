import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/extension/localization_extension.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final _box = GetStorage();
  final _key = "langaugeCode";
  final _languageName = 'languageName';
  List<LanguageModel> langaugesList = <LanguageModel>[
    LanguageModel(language: "English", code: 'en'),
    LanguageModel(language: "اردو", code: 'ur'),
  ];

  RxInt _selectedLanguageIndex = (-1).obs;
  RxString _selectedLanguageCode = ''.obs;
  RxString _selectedLanguage = ''.obs;
  String get selectedLanguage => _selectedLanguage.value;
  String get selectedLanguageCode => _selectedLanguageCode.value;
  int get selectedLanguageIndex => _selectedLanguageIndex.value;
  switchLanguage(
      {required String languageCode,
      required int index,
      required String languageName}) async {
    await _box.write(_key, languageCode);
    await _box.write(_languageName, languageName);
    await _box.write('langaugeIndex', index);
    Get.updateLocale(Locale(languageCode));
    _selectedLanguageIndex.value = _box.read('langaugeIndex') ?? (-1);
    _selectedLanguageCode.value = _box.read(_key) ?? 'en';
    _selectedLanguage.value = _box.read(_languageName) ?? "English";
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _selectedLanguageIndex.value = _box.read('langaugeIndex') ?? (-1);
    _selectedLanguageCode.value = _box.read(_key) ?? 'en';
    _selectedLanguage.value = _box.read(_languageName) ?? "English";
  }
}

class LanguageModel {
  final String language;
  final String code;
  LanguageModel({required this.language, required this.code});
}
