// import 'package:get/get.dart';

// class TranslationController extends GetxController {
//   RxList<Language> languages = <Language>[
//     Language(name: "Français", code: "Fr", language_code: "fr"),
//     Language(name: "English", code: "USA", language_code: "en")
//   ].obs;
//   Rx<Language> selectedLanguage =
//       Language(name: "Français", code: "FR", language_code: "fr").obs;

//   void setLanguage(String name) {
//     selectedLanguage.value =
//         languages.firstWhere((Language language) => language.name == name);
//   }
// }

// class Language {
//   String name;
//   String code;
//   String language_code;

//   Language(
//       {required this.name, required this.code, required this.language_code});
// }
