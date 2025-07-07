import 'package:get/get.dart';

class TranslationController extends GetxController {
  RxList<Language> languages = <Language>[
    Language(name: "Français", code: "Fr"),
    Language(name: "English", code: "USA")
  ].obs;
  Rx<Language> selectedLanguage = Language(name: "Français", code: "FR").obs;

  void setLanguage(String name) {
    selectedLanguage.value =
        languages.firstWhere((Language language) => language.name == name);
  }
}

class Language {
  String name;
  String code;

  Language({required this.name, required this.code});
}
