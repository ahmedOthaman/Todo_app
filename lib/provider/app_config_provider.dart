import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AppConfigProvider extends ChangeNotifier {



String appLanguage='en';
ThemeMode appTheme=ThemeMode.dark;


Future<void> changeLanguage(String newLanguage) async {
  if(appLanguage==newLanguage){
    return ;
  }
  appLanguage=newLanguage;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('lang', newLanguage);

  notifyListeners();
}

Future<void> changeThemeMode(ThemeMode newMode) async {

  if(appTheme==newMode){
    return ;
  }
  appTheme =newMode;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('theme', newMode==ThemeMode.light?'light':'dark');
  notifyListeners();
}
bool isDark(){
  return appTheme==ThemeMode.dark;
}
save_shaerd()async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  preferences.setBool("isDark()", true);
  print("----------------");
}






}
