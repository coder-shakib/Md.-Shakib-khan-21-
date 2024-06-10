import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'todo.dart';
import 'service_locator.dart';

class TodoModel extends ChangeNotifier {
  final DBHelper dbHelper = getIt<DBHelper>();
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<void> fetchTodos() async {
    final List<Map<String, dynamic>> maps = await dbHelper.queryAll();
    _todos = List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
    notifyListeners();
  }

  Future<void> addTodo(Todo todo) async {
    await dbHelper.insert(todo.toMap());
    fetchTodos();
  }

  Future<void> updateTodo(Todo todo) async {
    await dbHelper.update(todo.toMap());
    fetchTodos();
  }

  Future<void> deleteTodo(int id) async {
    await dbHelper.delete(id);
    fetchTodos();
  }
}
