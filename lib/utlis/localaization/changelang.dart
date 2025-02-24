import 'package:al_amine_store/utlis/const/apptheme.dart';
import 'package:al_amine_store/utlis/services/services.dart';
import 'package:al_amine_store/utlis/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalController extends GetxController {
  Locale? langauge;
  MyServices myServices = Get.find();

  ThemeData appTheme = themeEnglish;
  bool isEnglish = true;

  changeLang(String langcode) {
    Locale locale = Locale(langcode);
    myServices.sharedPreferences.setString("lang", langcode);
    appTheme = langcode == "ar" ? AppTheme.arabicTheme : AppTheme.englishTheme;
    isEnglish = !isEnglish;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    String? sharedPerfLang = myServices.sharedPreferences.getString("lang");
    if (sharedPerfLang == "en") {
      langauge = const Locale("en");
      appTheme = AppTheme.englishTheme;
    } else if (sharedPerfLang == "ar") {
      langauge = const Locale("ar");
      appTheme = AppTheme.arabicTheme;
    } else {
      langauge = Locale(Get.deviceLocale!.languageCode);
      appTheme = AppTheme.englishTheme;
    }
  }
}
