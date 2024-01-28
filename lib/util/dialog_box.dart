import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({
    super.key, 
    required this.controller,
    required this.onSave,
    required this.onCancel,
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.pink[100],
      content: Container(
        height: 120,
        width: 300,
        alignment: Alignment.center,
        child: Column(children: [
          //get user input
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Add a new task",
              ),
          ),

          //buttons -> save -> cancel
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            //save button
            MyButton(text: "SAVE", onPressed: onSave,),

            const SizedBox(width: 4),
            //cancel button
            MyButton(text: "CANCEL", onPressed: onCancel,),

          ],)
        ],)
        )
    );
  }
}