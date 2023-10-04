import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AppConfigProvider extends ChangeNotifier {



String appLanguage='en';
ThemeMode appTheme=ThemeMode.dark;


void changeLanguage(String newLanguage){
  if(appLanguage==newLanguage){
    return ;
  }
  appLanguage=newLanguage;
  notifyListeners();
}

void changeThemeMode(ThemeMode newMode){

  if(appTheme==newMode){
    return ;
  }
  appTheme =newMode;
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
