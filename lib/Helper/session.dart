import 'package:shared_preferences/shared_preferences.dart';

setDarkMode(bool dark_mode) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.setBool("Dark_Mode", dark_mode);
}
