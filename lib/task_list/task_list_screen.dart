

import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/provider/list_provider.dart';
import 'package:todoapp/task_list/task_widget.dart';
import '../provider/app_config_provider.dart';
import '../provider/auth_provider.dart';

class TaskTab extends StatefulWidget {

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {


  @override
  Widget build(BuildContext context) {
    var authprovider=Provider.of<AuthProvider>(context,listen: false);
    var listprovider=Provider.of<ListProvider>(context);
    var provider=Provider.of<AppConfigProvider>(context);
    if(listprovider.taskList.isEmpty){
     listprovider.getAllTasksFromFireStore(authprovider.currentUser!.id!);
    }


    return Column(
      children: [
        CalendarAgenda(
          initialDate: listprovider.selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          locale:provider.appLanguage ,
          onDateSelected: (date) {
            listprovider.setNewSelectDate(date,authprovider.currentUser!.id!);
      },
    ),
        Expanded(
        child: ListView.builder(
            itemBuilder: (context,index)=>TaskWidget(task:listprovider.taskList[index] ,),
            itemCount: listprovider.taskList.length,
        ),
      ),
      ],
    );
  }


}
