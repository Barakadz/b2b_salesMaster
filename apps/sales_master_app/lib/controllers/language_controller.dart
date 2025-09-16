import 'package:core_utility/core_utility.dart';
import 'package:data_layer/data_layer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_master_app/models/language_model.dart';

class LanguageController extends GetxController {
  Rx<Locale> appLocale = const Locale('en').obs; // Default to English

  RxList<Language> languages = <Language>[
    Language(
        name: "Français",
        code: "Fr",
        language_code: "fr",
        locale: Locale("en")),
    Language(
        name: "English", code: "USA", language_code: "en", locale: Locale("en"))
  ].obs;
  Rx<Language> selectedLanguage = Language(
          name: "English",
          code: "en",
          language_code: "en",
          locale: Locale("en"))
      .obs;

  @override
  void onInit() {
    super.onInit();
    _loadLocale();
  }

  void setLanguage(String name) {
    print(name);
    selectedLanguage.value =
        languages.firstWhere((Language language) => language.name == name);
    appLocale.value = Locale(selectedLanguage.value.language_code);
    updateLocale(appLocale.value);
  }

  Future<void> _loadLocale() async {
    String? savedLocale = AppStorage().getString('locale');
    if (savedLocale != null) {
      appLocale.value = Locale(savedLocale);
      RepoLocalizations.setLocale(Locale(savedLocale));
      //Get.updateLocale(appLocale.value);
    } else {
      RepoLocalizations.setLocale(Locale(appLocale.value.languageCode));
    }
    RepoLocalizations.setLocale(appLocale.value);
  }

  Future<void> updateLocale(Locale locale) async {
    appLocale.value = locale;
    RepoLocalizations.setLocale(appLocale.value);
    Get.updateLocale(locale);
    // translation
    RepoLocalizations.setLocale(Locale(locale.languageCode));

    await AppStorage().setString('locale', locale.languageCode);
  }
}
