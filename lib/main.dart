
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/home/homescreen.dart';
import 'package:todoapp/login/login_screen.dart';
import 'package:todoapp/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todoapp/provider/app_config_provider.dart';
import 'package:todoapp/provider/auth_provider.dart';
import 'package:todoapp/provider/list_provider.dart';
import 'package:todoapp/register/regiester.dart';
import 'package:todoapp/task_list/edit_task.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseFirestore.instance.disableNetwork();
  // FirebaseFirestore.instance.settings =
  //     const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>AppConfigProvider()),
      ChangeNotifierProvider(create: (context)=>ListProvider()),
      ChangeNotifierProvider(create: (context)=>AuthProvider()),
    ],
        child: MyApp()),
  );
}


class MyApp extends StatelessWidget {

late AppConfigProvider provider;
  @override
  Widget build(BuildContext context) {
    provider=Provider.of<AppConfigProvider>(context);
    initSharedPrefs();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Login.routeName ,

      routes: {
        HomeScreen.routeName:(context)=>HomeScreen(),
        EditTask.routeName:(context)=>EditTask(),
        Login.routeName:(context)=>Login(),
        RegisterScreen.routeName:(context)=>RegisterScreen(),

      },
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: provider.appTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
    );
  }
initSharedPrefs()async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String lang=prefs.getString('lang')??'en';

  String theme=prefs.getString('theme')??'light';
  provider.changeLanguage(lang);
  if(theme=='light')
  {
    provider.changeThemeMode(ThemeMode.light);
  }
  else
  {
    provider.changeThemeMode(ThemeMode.dark);
  }
}
}
