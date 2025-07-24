import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/provider/app_config_provider.dart';
import 'package:todoapp/settinges/language_bottom_sheet.dart';
import 'package:todoapp/settinges/theme_bottom_sheet.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingesTab extends StatefulWidget {


  @override
  State<SettingesTab> createState() => _SettingesTabState();
}

class _SettingesTabState extends State<SettingesTab> {
  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppLocalizations.of(context)!.language,
            style:TextStyle(
              color:provider.isDark()?
            MyTheme.whiteColor:
            MyTheme.blackcolor,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: MyTheme.whiteColor
            ),
            child: InkWell(
              onTap: (){
                showLanguageBottomSheet();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( provider.appLanguage=='en'?
                  AppLocalizations.of(context)!.english:
                  AppLocalizations.of(context)!.arabic,
                  style: TextStyle(
                    color: MyTheme.primarylight,
                  ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),SizedBox(
            height: 15,
          ),
          Text(AppLocalizations.of(context)!.theme,
              style:TextStyle(
              color:provider.isDark()?
              MyTheme.whiteColor:
              MyTheme.blackcolor,
          ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: MyTheme.whiteColor
          ),
            child: InkWell(
              onTap: (){
             showThemeBottomSheet();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( provider.isDark()?
                  AppLocalizations.of(context)!.dark:
                  AppLocalizations.of(context)!.light,
                    style: TextStyle(
                      color: MyTheme.primarylight,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context)=>LanguageBottomSheet() ,
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context)=>ThemeBottomSheet()  ,
    );
  }
}
