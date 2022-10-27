import 'package:flutter/material.dart';

import 'category_screen.dart';
import 'categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.purple,
          secondary: Colors.pink,
        ),
        fontFamily: 'Raleway',
      ),
      routes: {
        '/': (context) => CategoriesScreen(),
        CategoryScreen.routeName: (context) => CategoryScreen(),
      },
    );
  }
}
