import 'package:database/Model/todo_model.dart';
import 'package:database/sql_helper/sql_helper.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> todoItem = [];

  Future<void> selectData() async {
    final dataList = await DHhelper.selectAll(DHhelper.todo);

    todoItem = dataList
        .map(
          (item) => TodoModel(
            id: item['id'],
            title: item['title'],
            description: item['description'],
            date: item['date'],
          ),
        )
        .toList();
    notifyListeners();
  }

  Future insertData(
    String title,
    String description,
    String date,
  ) async {
    final newTodo = TodoModel(
      id: const Uuid().v1(),
      title: title,
      description: description,
      date: date,
    );
    todoItem.add(newTodo);

    DHhelper.insert(
      DHhelper.todo,
      {
        'id': newTodo.id,
        'title': newTodo.title,
        'description': newTodo.description,
        'date': newTodo.date,
      },
    );
    notifyListeners();
  }
}
