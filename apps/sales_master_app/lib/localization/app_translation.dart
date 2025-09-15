import 'package:get/get.dart';
import 'package:sales_master_app/localization/en.dart';
import 'package:sales_master_app/localization/fr.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': englishDict,
        'fr': frenchDict,
      };
}
