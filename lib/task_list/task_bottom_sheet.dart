import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todoapp/dialog_utils.dart';
import 'package:todoapp/firebase_utlis.dart';
import 'package:todoapp/model/task.dart';
import 'package:todoapp/my_theme.dart';
import 'package:todoapp/provider/auth_provider.dart';
import '../provider/app_config_provider.dart';
import '../provider/list_provider.dart';



class AddTaskBottomSheet extends StatefulWidget{


  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedate=DateTime.now();

   DateFormat formatter = DateFormat('yyyy-MM-dd');
  String title='';
  String description='';
  bool isDone=true;
  late ListProvider listProvider;

var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    listProvider=Provider.of<ListProvider>(context);
    var provider=Provider.of<AppConfigProvider>(context);
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Text(provider.appLanguage=='en' ?
          AppLocalizations.of(context)!.add_new_task
              :AppLocalizations.of(context)!.add_new_task
            , style: Theme.of(context).textTheme.titleMedium,
          ),
          Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (text){
                      title =text;
                    },
                    validator: (text){
                      if(text== null ||text.isEmpty ){
                        return 'Please enter task title';
                      }
                      return null;
                    },
                   decoration: InputDecoration(
                     hintText: provider.appLanguage=='en' ?
                     AppLocalizations.of(context)!.add_new_task
                         :AppLocalizations.of(context)!.add_new_task,
                     hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                         color:  provider.isDark()?
                         MyTheme.whiteColor:
                         MyTheme.blackcolor
                     ),
                   ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (text){
                      description =text;
                    },
                    validator: (text){
                      if(text== null ||text.isEmpty ){
                        return 'Please enter Description of the task';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: provider.appLanguage=='en'?
                      AppLocalizations.of(context)!.enter_task_decribtions
                :      AppLocalizations.of(context)!.enter_task_decribtions
                      , hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color:  provider.isDark()?
                        MyTheme.whiteColor:
                        MyTheme.blackcolor
                    ),
                  ),
                    maxLines: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(provider.appLanguage=='en'?
                      AppLocalizations.of(context)!.select_date
                :      AppLocalizations.of(context)!.select_date,

                  style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      ShowClaender();

                    },
                    child: Text('${selectedate.day}/${selectedate.month}/${selectedate.year}',
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: (){

                      addtask();
                      },

                    child: Text(provider.appLanguage=='en'?
                 AppLocalizations.of(context)!.add  :
                          AppLocalizations.of(context)!.add
                      ,
                    style: Theme.of(context).textTheme.titleLarge,
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void ShowClaender()async {
   var chossen=await showDatePicker(
        context: context,
        initialDate: selectedate,
        firstDate:DateTime.now() ,
        lastDate: DateTime.now().add(Duration(days: 365)) ,
    );
   if(chossen!=null){
    selectedate =chossen ;
     setState(() {

     });
   }
  }


  Future<void> addtask() async {
  if(formkey.currentState!.validate()==true){
    Task task =Task(
        title: title,
        description: description,
        dateTime:selectedate,
      isDone: isDone,
    );

    var authprovider=Provider.of<AuthProvider>(context,listen: false);
    DialogUtils.showLoading(context, 'Loading...');
       await FirebaseUtils.AddTaskToFireBase(task,authprovider.currentUser!.id!).then((value)
       {
         DialogUtils.hideDialog(context);
       DialogUtils.showMessage(context, "task added successfully");
       }).
       timeout(
    const Duration(seconds: 1),onTimeout: (){
         DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, "task added successfully");
      listProvider.getAllTasksFromFireStore(authprovider.currentUser!.id!);
      Navigator.pop(context);

  },


  );

  }
}

}
