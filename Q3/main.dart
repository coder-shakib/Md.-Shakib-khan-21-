import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'news_search_page.dart'; // Assuming the NewsSearchPage code is in this file
import 'news_provider.dart'; // Assuming the NewsProvider code is in this file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsProvider(),
      child: MaterialApp(
        title: 'Country-Based News App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NewsSearchPage(),
      ),
    );
  }
}
