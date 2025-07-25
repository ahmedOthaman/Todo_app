import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../firebase_utlis.dart';
import '../model/task.dart';

class ListProvider extends ChangeNotifier{
  List<Task> taskList=[];
  DateTime selectedDate=DateTime.now();

  void getAllTasksFromFireStore(String uId)async{
    QuerySnapshot<Task> querySnapshot= await FirebaseUtils.getTasksCollection(uId).get();
    taskList= querySnapshot.docs.map((doc) {
      return  doc.data();
    }).toList();

    taskList= taskList.where((task){
      if(task.dateTime?.day==selectedDate.day&&
          task.dateTime?.month==selectedDate.month&&
          task.dateTime?.year==selectedDate.year){
        return true;
      }
      return false ;
    }).toList();
    taskList.sort((Task task1,Task task2) {
    return  task1.dateTime!.compareTo(task2.dateTime!);

    });


    notifyListeners();
  }

  void setNewSelectDate(DateTime newDate,String uId){
    selectedDate =newDate;
    getAllTasksFromFireStore(uId);

  }

}