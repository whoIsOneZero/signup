import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:signup/data/database.dart';

import '../widgets/dialog_box.dart';
import '../widgets/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _myBox = Hive.box('mybox');

  //INSTANTIATION OF DATABASE
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    //Create default data if this is the first time ever opening the app
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //Some data already exits
      db.loadData();
    }

    super.initState();
  }

  //Text Controller
  final _controller = TextEditingController();

  //IF CHECKBOX IS TAPPED
  void _checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  //SAVE NEW TASK
  void _saveNewTask() {
    setState(() {
      //ADDS A NEW TASK/TILE
      db.toDoList.add([_controller.text, false]);

      //CLEARS THE TEXT FROM THE TEXT FIELD
      _controller.clear();
      Navigator.of(context).pop();
      db.updateDataBase();
    });
  }

  void _createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          textController: _controller,
          onSave: _saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //DELETE TASK
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('TO DO'),
        centerTitle: true,
        elevation: 1,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewTask,
        child: const Icon(
          Icons.add,
        ),
      ),

      //MAKES THE LIST DYNAMIC; TO BE ABLE TO ADD & DELETE TILES.
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => _checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
