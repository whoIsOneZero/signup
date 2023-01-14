import 'package:flutter/material.dart';
import 'my_button.dart';

class DialogBox extends StatelessWidget {
  //Gives you access to what user types in TextField()
  TextEditingController? textController;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    Key? key,
    required this.textController,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          children: [
            //GET USER INPUT
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add a new task',
              ),
            ),

            //SAVE & CANCEL BUTTONS
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //SAVE BUTTON
                  MyButton(buttonText: 'Save', onPressed: onSave),
                  const SizedBox(width: 10.0),

                  //CANCEL BUTTON
                  MyButton(buttonText: 'Cancel', onPressed: onCancel),
                  //const SizedBox(width: 10.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
