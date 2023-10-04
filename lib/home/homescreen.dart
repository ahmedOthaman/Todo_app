import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/my_theme.dart';
import 'package:todoapp/provider/app_config_provider.dart';
import 'package:todoapp/provider/auth_provider.dart';
import 'package:todoapp/provider/list_provider.dart';
import 'package:todoapp/settinges/settinges_tab.dart';
import 'package:todoapp/task_list/task_bottom_sheet.dart';
import 'package:todoapp/task_list/task_list_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName='home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
int selectedindex=0;

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    var authprovider=Provider.of<AuthProvider>(context);
    var listprovider=Provider.of<ListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(provider.appLanguage=='en' ?
            AppLocalizations.of(context).app_title:
              AppLocalizations.of(context).app_title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: provider.isDark()?
                  MyTheme.titlecolor:
                  MyTheme.whiteColor,
            ),
            ),
            SizedBox(width: 5,),
            Text( '${authprovider.currentUser!.name}'),
          ],
        ),
        actions: [
          IconButton(
              onPressed: (){
            listprovider.taskList=[];
            authprovider.currentUser=null;
            Navigator.pushNamed(context, Login.routeName);
            },
           icon:Icon(Icons.logout)),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex:selectedindex ,
          onTap: (index){
            selectedindex=index;
            setState(() {

            });
          },
          items: [
            BottomNavigationBarItem(
                icon:Icon(Icons.list)  ,
              label: provider.appLanguage=='en'?
              AppLocalizations.of(context).task:
              AppLocalizations.of(context).task,
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.settings)  ,
              label: AppLocalizations.of(context)!.settings,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
          side: BorderSide(
            color: MyTheme.whiteColor,
            width: 6,
          ),

        ),
        onPressed: (){
          showAddBottomSheet();
        },
        child: Icon(Icons.add,size: 30,),

      ),
      floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked ,
      body:tabs[selectedindex] ,
   );
  }
  List<Widget>tabs=[
  TaskTab(),SettingesTab()
  ];

  void showAddBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder:(context)=>AddTaskBottomSheet(),
    );
  }
}
