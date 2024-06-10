import 'package:flutter/material.dart';
import 'product_list_screen.dart';
import 'single_product_screen.dart';
import 'category_grid_screen.dart';
import 'product_category_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Semi-Ecommerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ProductListScreen(),
        '/singleProduct': (context) => SingleProductScreen(),
        '/categoryGrid': (context) => CategoryGridScreen(),
        '/productCategory': (context) => ProductCategoryScreen(categoryName: '',),
      },
    );
  }
}
