

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/model/user.dart';
import 'model/task.dart';

class FirebaseUtils{

  static CollectionReference<Task> getTasksCollection(String uId){
   return getUserCollection().doc(uId).collection(Task.collectionName).
    withConverter<Task>(
      fromFirestore: (snapshot,options)=>Task.fromFireStore(snapshot.data()!),
      toFirestore:(task,options)=>task.toFireStore(),
    );

  }

  static Future<void> AddTaskToFireBase(Task task,String uId){
  var taskCollection= getTasksCollection(uId);
  DocumentReference<Task> taskDocRef = taskCollection.doc();
  task.id=taskDocRef.id ;
  return taskDocRef.set(task);
  }

  static  Future<void> deleteTaskFromFireStore(Task task,String uId){
   return getTasksCollection(uId).doc(task.id).delete();
  }

  static Future<void> upDateTask(Task task,String uId ) {

   return getTasksCollection(uId).doc(task.id).update({'title':task.title,'desc':task.description});
  }


  static CollectionReference<MyUser> getUserCollection(){
    return FirebaseFirestore.instance.collection(MyUser.collectionNmae).
    withConverter<MyUser>(
        fromFirestore: (snapshot,options)=>MyUser.fromFireStore(snapshot.data()),
        toFirestore:(user,options)=>user.toFireStore() ,
    );
  }

  static void AddUserToFireStore(MyUser myUser){
    getUserCollection().doc(myUser.id).set(myUser);
  }

   static Future<MyUser?> readUserFormFireStore(String uId)async{
      var   querySnapshot=await  getUserCollection().doc(uId).get();
      return  querySnapshot.data();
   }

}