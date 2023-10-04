


class Task{
  static const String collectionName='task';
  String? id;
  String? title;
  String? description;
  DateTime? dateTime;
  bool? isDone;
  Task({
this.id='',required this.title,
    required this.description,
    required this.dateTime,
    this.isDone=false,
});
  Task.fromFireStore(Map<String,dynamic> data):this(
    id: data['id'] as String,
    title: data['title'] as String,
    description:  data['description'] as String,
    dateTime:  DateTime.fromMillisecondsSinceEpoch(data[ 'datetime']) ,
    isDone: data['isDone'] ,
  );

 Map<String ,dynamic>  toFireStore(){
     return{
       'id':id,
       'title':title,
       'description':description,
       'datetime':dateTime?.millisecondsSinceEpoch,
       'isDone':isDone
     };
   }
}