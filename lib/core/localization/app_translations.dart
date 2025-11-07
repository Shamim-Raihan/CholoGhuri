import 'package:get/get.dart';

import 'bangla_translations.dart';
import 'english_translations.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': englishTranslations,
    'bn': banglaTranslations,
  };
}
