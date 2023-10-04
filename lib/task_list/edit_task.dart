import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/my_theme.dart';
import 'package:todoapp/provider/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todoapp/provider/auth_provider.dart';

import '../firebase_utlis.dart';
import '../model/task.dart';

class EditTask extends StatelessWidget {

  static const String routeName = 'edit task';


  @override
  Widget build(BuildContext context) {
String newTitle='';
String desc='';
    var args=ModalRoute.of(context)?.settings.arguments as Task;
    Task task=Task(
        title: args.title, description: args.description, dateTime: args.dateTime);
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          provider.appLanguage == 'en'
              ? AppLocalizations.of(context).app_title
              : AppLocalizations.of(context).app_title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: provider.isDark()?
            MyTheme.darkblackcolor:
            MyTheme.whiteColor,
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.only(
            top: 50,
            left: 33,
            right: 33,
            bottom: 30,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  provider.appLanguage == 'en'
                      ? AppLocalizations.of(context)!.edit_task
                      : AppLocalizations.of(context)!.edit_task,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText:args.title,
                   semanticCounterText: provider.appLanguage == 'en'
                        ? AppLocalizations.of(context)!.this_is_title
                        : AppLocalizations.of(context)!.this_is_title,
                    hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: provider.isDark()?
                          MyTheme.botextcolor:
                          MyTheme.blackcolor
                    ),
                  ),

                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText:
                    args.description,
                      semanticCounterText:provider.appLanguage == 'en'
                        ? AppLocalizations.of(context)!.task_details
                        : AppLocalizations.of(context)!.task_details,
                    hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: provider.isDark()?
                        MyTheme.botextcolor:
                        MyTheme.blackcolor

                    ),
                   ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  provider.appLanguage == 'en'
                      ? AppLocalizations.of(context)!.select_time
                      : AppLocalizations.of(context)!.select_time,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: provider.isDark()?
                      MyTheme.botextcolor:
                      MyTheme.blackcolor
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '${args.dateTime?.day}/${args.dateTime?.month}/${args.dateTime?.year}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: MyTheme.greyColor,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(top: 190, bottom: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ElevatedButton (
                    onPressed: () {
                      var authprovider=Provider.of<AuthProvider>(context,listen: false);
                   FirebaseUtils.upDateTask(task,authprovider.currentUser!.id!);
                     Navigator.pop(context);
                    },
                    child: Text(
                      provider.appLanguage == 'en'
                          ? AppLocalizations.of(context)!.save_change
                          : AppLocalizations.of(context)!.save_change,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: MyTheme.whiteColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
