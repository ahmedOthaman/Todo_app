import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/my_theme.dart';
import 'package:todoapp/provider/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageBottomSheet extends StatefulWidget {


  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () {
            provider.changeLanguage('en');
          },
          child:provider.appLanguage=='en'?
          getSelectedItemWidget(AppLocalizations.of(context).english)
         :getUnSelectedItemWidget(AppLocalizations.of(context).english) ,
        ),
        InkWell(
          onTap: () {
         provider.changeLanguage('ar');
          },
          child:provider.appLanguage=='ar'?
          getSelectedItemWidget(AppLocalizations.of(context)!.arabic)
          :getUnSelectedItemWidget(AppLocalizations.of(context)!.arabic),
        ),
      ],
    );
  }

  Widget getSelectedItemWidget(String text) {
    return  Padding(
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

  Widget getUnSelectedItemWidget(String text) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );

  }
}
