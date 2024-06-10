import 'package:flutter/material.dart';
import 'news_screen.dart';
import 'date_picker_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple News App by Tahura 4',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => NewsScreen(),
        '/datePicker': (context) => DatePickerScreen(),
      },
    );
  }
}
