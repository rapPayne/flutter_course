import 'package:flutter/material.dart';
import 'Task.dart';

class TaskList extends StatelessWidget {
  List<Task> _todos = [
    Task()
      ..id = 1
      ..completed = false
      ..description = "Go home",
    Task()
      ..id = 2
      ..completed = false
      ..description = "Cure cancer",
    Task()
      ..id = 3
      ..completed = false
      ..description = "Eat a burger",
    Task()
      ..id = 4
      ..completed = false
      ..description = "Move to a new house",
    Task()
      ..id = 5
      ..completed = false
      ..description = "Go for a long run",
  ];

  TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo list"),
      ),
      body: Container(
          child: ListView(
        children: _makeTodoList(_todos),
      )),
    );
  }

  List<Widget> _makeTodoList(List<Task> todos) {
    return todos.map((todo) {
      return ListTile(
        title: Text(todo.description),
        leading: Icon(Icons.check_box_outline_blank),
      );
    }).toList();
  }
}
