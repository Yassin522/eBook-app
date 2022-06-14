import 'package:book/Helper/String.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String LAGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String HINDI = 'hi';
const String CHINESE = 'zh';
const String SPANISH = 'es';
const String ARABIC = 'ar';
const String RUSSIAN = 'ru';
const String JAPANESE = 'ja';
const String DEUTSCH = 'de';

Locale? loc;
int lang = 0;
Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "en";
  Language_flag = languageCode;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, 'US');
    case HINDI:
      return const Locale(HINDI, "IN");
    case CHINESE:
      return const Locale(CHINESE, "CN");
    case SPANISH:
      return const Locale(SPANISH, "ES");
    case ARABIC:
      return const Locale(ARABIC, "DZ");
    case RUSSIAN:
      return const Locale(RUSSIAN, "RU");
    case JAPANESE:
      return const Locale(JAPANESE, "JP");
    case DEUTSCH:
      return const Locale(DEUTSCH, "DE");
    default:
      return const Locale(ENGLISH, 'US');
  }
}

void changeLanguage(BuildContext context, String language) async {
  Language_flag = language;
  Locale loc = await setLocale(language);
  MyApp.setLocale(context, loc);
}
