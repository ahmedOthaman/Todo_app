import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/firebase_utlis.dart';
import 'package:todoapp/provider/app_config_provider.dart';
import 'package:todoapp/provider/list_provider.dart';
import 'package:todoapp/task_list/edit_task.dart';

import '../dialog_utils.dart';
import '../model/task.dart';
import '../my_theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../provider/auth_provider.dart';
class TaskWidget extends StatelessWidget {
  Task task ;
  TaskWidget({required this.task});
  @override
  Widget build(BuildContext context) {
    var listprovider=Provider.of<ListProvider>(context);
    var provider=Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(

        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) async {
                var authprovider=Provider.of<AuthProvider>(context,listen: false);
              await  FirebaseUtils.deleteTaskFromFireStore(task,authprovider.currentUser!.id!).
                timeout(
                  Duration(milliseconds: 500),onTimeout: (){
                  //  print('==========================');
                    listprovider.getAllTasksFromFireStore(authprovider.currentUser!.id!);
                }
                );
              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: MyTheme.whiteColor,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete

            ),
          ],
        ),
        child: InkWell(
          onTap: (){
            Navigator.of(context).pushNamed(EditTask.routeName,
            arguments:Task(
              title:task.title,
             description: task.description,
             dateTime: task.dateTime,
    ),

            );
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: provider.isDark()?
              MyTheme.darkblackcolor:
              MyTheme.whiteColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 21,
                    vertical: 7,
                  ),
                  color: MyTheme.primarylight,
                  width: 4,
                  height: 80,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text( task.title??'',
                       semanticsLabel: provider.appLanguage=='en'?
                        AppLocalizations.of(context)!.add_new_task
                        :AppLocalizations.of(context)!.add_new_task
                       , style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: MyTheme.primarylight,
                            ),
                      ),
                      Text(task.description??'',
                      semanticsLabel: provider.appLanguage=='en'?
                      AppLocalizations.of(context)!.enter_task_decribtions
                          :AppLocalizations.of(context)!.enter_task_decribtions,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 69,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyTheme.primarylight,
                  ),
                  child: Icon(
                    Icons.check,
                    size: 35,
                    color: MyTheme.whiteColor,
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
