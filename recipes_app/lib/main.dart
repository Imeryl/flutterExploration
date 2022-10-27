import 'package:flutter/material.dart';

import 'screens/category_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/recipe_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.purple,
        ),
        fontFamily: 'Raleway',
      ),
      routes: {
        '/': (context) => CategoriesScreen(),
        CategoryScreen.routeName: (context) => CategoryScreen(),
        RecipeScreen.routeName: (context) => RecipeScreen(),
      },
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (context) => CategoriesScreen()),
    );
  }
}