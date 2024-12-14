import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase{
  List toDoList = [];

  final _mybox = Hive.box('mybox');

  void createInitialData(){
    toDoList = [
    ['Learn flutter', false],
    ['Do homework', false]
  ];
  }

  void loadData(){
    toDoList = _mybox.get("TODOLIST");
  }

  void updateDatabase(){
    _mybox.put("TODOLIST", toDoList);
  }
}