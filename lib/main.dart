// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'todo_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BU-Todo',
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BU-Todo'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: todoController.todos.length,
          itemBuilder: (context, index) {
            final todo = todoController.todos[index];
            return ListTile(
              title: Text(todo['title']),
              subtitle: Text(todo['description']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Get.to(() => TodoEditScreen(todo: todo));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      todoController.deleteTodo(todo['id']);
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => TodoAddScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoAddScreen extends StatelessWidget {
  final TodoController todoController = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                todoController.addTodo(
                  titleController.text,
                  descriptionController.text,
                );
                Get.back();
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}

class TodoEditScreen extends StatelessWidget {
  final Map<String, dynamic> todo;
  final TodoController todoController = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  TodoEditScreen({required this.todo}) {
    titleController.text = todo['title'];
    descriptionController.text = todo['description'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                todoController.updateTodo(
                  todo['id'],
                  titleController.text,
                  descriptionController.text,
                );
                Get.back();
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
