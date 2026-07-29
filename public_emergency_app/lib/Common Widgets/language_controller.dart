import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Global controller that manages the app's current language/locale.
/// Call `Get.put(LanguageController())` once (e.g. in main.dart) so the
/// same instance is shared across the whole app.
class LanguageController extends GetxController {
  // Change these codes/locales to match the languages you support.
  static const Locale english = Locale('en', 'US');
  static const Locale urdu = Locale('ur', 'PK');

  final Rx<Locale> currentLocale = english.obs;

  bool get isEnglish => currentLocale.value.languageCode == 'en';

  void toggleLanguage() {
    final newLocale = isEnglish ? urdu : english;
    currentLocale.value = newLocale;
    Get.updateLocale(newLocale); // <-- this makes the change app-wide
  }
}