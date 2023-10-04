import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/my_theme.dart';
import 'package:todoapp/provider/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeBottomSheet extends StatefulWidget {


  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: (){
            provider.changeThemeMode(ThemeMode.dark);
          },
          child:provider.isDark()?
          getSelectedThemeMode(AppLocalizations.of(context)!.dark):
          getUnSelectedThemeMode(AppLocalizations.of(context)!.dark),
        ),
        InkWell(
          onTap: (){
            provider.changeThemeMode(ThemeMode.light);
          },
          child: provider.isDark()?
          getUnSelectedThemeMode(AppLocalizations.of(context)!.light)  :
          getSelectedThemeMode(AppLocalizations.of(context)!.light),

        ),
      ],
    );
  }

  Widget getSelectedThemeMode(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: MyTheme.primarylight
            ),
            ),
          Icon(Icons.check,size: 30,color: MyTheme.primarylight,),
        ],
      ),
    );
  }

  getUnSelectedThemeMode(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
