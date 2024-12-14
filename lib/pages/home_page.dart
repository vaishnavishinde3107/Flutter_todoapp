import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/util/dailog_box.dart';
import 'package:todoapp/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  final Function(bool) onThemeChange;
  const HomePage({super.key, required this.onThemeChange});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the box
  final _mybox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  bool isDarkTheme = false; // Track if the current theme is dark

  @override
  void initState() {
    // default data
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // load the existing data
      db.loadData();
    }
    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  // if checkbox was tapped
  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DailogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  // edit task
  void editTask(int index) {
    _controller.text = db.toDoList[index][0]; // pre-filling the existing task
    showDialog(
      context: context,
      builder: (context) {
        return DailogBox(
          controller: _controller,
          onSave: () {
            setState(() {
              db.toDoList[index][0] = _controller.text; // update task
            });
            Navigator.of(context).pop();
          },
          onCancel: () {
            _controller.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  // toggle between light and dark themes
  void toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
      widget.onThemeChange(isDarkTheme); // Notify parent about the theme change
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define colors based on the current theme
    final backgroundColor = isDarkTheme ? Colors.grey[900] : Colors.grey[300];
    final primaryColor = isDarkTheme ? Colors.grey[700] : Colors.grey[400];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            'Quick List',
            style: TextStyle(
              fontFamily: 'PlayfairDisplay',
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(isDarkTheme ? Icons.wb_sunny : Icons.nights_stay),
            onPressed: toggleTheme, // Toggle theme on button press
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (BuildContext context, int index) {
          return TodoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkboxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            editFunction: (context) => editTask(index),
            todoTile: primaryColor!,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: primaryColor,
        foregroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
