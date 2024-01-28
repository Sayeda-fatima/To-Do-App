import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:flutter_application_1/util/dialog_box.dart';
import 'package:flutter_application_1/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //reference the hive box( store data)
  final _myBox = Hive.box('mybox');

  //use database to create, update list of to-do tasks 
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the first time opening the app, then create default data
    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();
    }
    else{
      //there already exists data
      db.loadData();
    }
    super.initState();
  }

  //text controller
  final _controller = TextEditingController();

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1]= !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  //create a new task
  void createNewTask(){
    showDialog(
      context: context, 
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
      );
  }

  //delete task
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100], 
      appBar: AppBar(
        backgroundColor: Colors.pink[200],            
        title: Center(
          child: Text("TO DO", style: TextStyle(color: Colors.black, 
          ),),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[200],
        onPressed: createNewTask,
        child: Icon(Icons.add, color: Colors.black,),
        ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: ((context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        }))
    );
  }
}