import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService extends GetxService {
  static const _kSelectedLangKey = 'selected_language_code';

  // default language code
  final RxString _currentLanguage = 'en'.obs;

  String get currentLanguage => _currentLanguage.value;

  /// Expose the Rx so UI can react to changes
  RxString get currentLanguageObs => _currentLanguage;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_kSelectedLangKey) ?? 'en';
    _currentLanguage.value = code;
    // Optionally set Get.locale if you use GetX translations
    Get.updateLocale(Locale(code));
  }

  Future<void> changeLanguage(String langCode) async {
    if (langCode != 'en' && langCode != 'bn') return;
    _currentLanguage.value = langCode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kSelectedLangKey, langCode);
    // Update Get locale as well for global translations
    Get.updateLocale(Locale(langCode));
  }
}
