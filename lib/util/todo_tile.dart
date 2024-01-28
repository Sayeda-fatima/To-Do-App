import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function (BuildContext)? deleteFunction;

  ToDoTile({
    super.key, 
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0, bottom: 0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
              )
          ]),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Row(
            children: [
              //checkbox
              Checkbox(
                value: taskCompleted, 
                onChanged: onChanged,
                activeColor: Color.fromARGB(255, 223, 62, 115),
                ),
        
              //TASK NAME
              Text(
                taskName,
                style: TextStyle( color: Colors.black,
                  decoration: taskCompleted               //if task completes then strikethrough
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
                ),
                ),
            ],
          ),
          decoration: BoxDecoration(
          color: Colors.pink[200],
          borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}