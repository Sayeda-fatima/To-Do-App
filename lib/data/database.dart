import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase{

  List toDoList=[];

  // reference the box
  final _myBox = Hive.box('mybox');


  // run this method when first time opening this app
  void createInitialData(){
    toDoList = [['Wake up early', false], ['Do exercise', false]];
  }

  //load the data from database
  void loadData(){
    toDoList = _myBox.get("TODOLIST");
  }

  // update database
  void updateDatabase(){
    _myBox.put("TODOLIST", toDoList);
  }

}