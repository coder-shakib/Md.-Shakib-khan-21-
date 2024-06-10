// lib/todo_controller.dart
import 'package:get/get.dart';
import 'db_helper.dart';

class TodoController extends GetxController {
  var todos = [].obs;
  final DBHelper _dbHelper = DBHelper();

  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  void fetchTodos() async {
    final data = await _dbHelper.queryAll();
    todos.value = data;
  }

  void addTodo(String title, String description) async {
    await _dbHelper.insert({'title': title, 'description': description});
    fetchTodos();
  }

  void updateTodo(int id, String title, String description) async {
    await _dbHelper.update({'id': id, 'title': title, 'description': description});
    fetchTodos();
  }

  void deleteTodo(int id) async {
    await _dbHelper.delete(id);
    fetchTodos();
  }
}
