import 'package:flutter/material.dart';

import 'dummy_data.dart';
import 'models/recipe.dart';
import 'screens/category_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/recipe_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _settings = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Recipe> _availableRecipes = DUMMY_RECIPES;
  List<Recipe> _favouriteRecipes = [];

  void _setSettings(Map<String, bool> settingsData) {
    setState(() {
      _settings = settingsData;

      _availableRecipes = DUMMY_RECIPES.where((recipe) {
        if (_settings['gluten'] as bool && !recipe.isGlutenFree) return false;
        if (_settings['lactose'] as bool && !recipe.isLactoseFree) return false;
        if (_settings['vegan'] as bool && !recipe.isVegan) return false;
        if (_settings['vegetarian'] as bool && !recipe.isVegetarian)
          return false;

        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String recipeId) {
    final existingIndex =
        _favouriteRecipes.indexWhere((recipe) => recipe.id == recipeId);

    if (existingIndex >= 0) {
      setState(() => _favouriteRecipes.removeAt(existingIndex));
    } else {
      setState(() => _favouriteRecipes
          .add(DUMMY_RECIPES.firstWhere((recipe) => recipe.id == recipeId)));
    }
  }

  bool _isRecipeFavourite(String recipeId) {
    return _favouriteRecipes.any((recipe) => recipe.id == recipeId);
  }

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
        '/': (context) => TabsScreen(_favouriteRecipes),
        CategoryScreen.routeName: (context) =>
            CategoryScreen(_availableRecipes),
        RecipeScreen.routeName: (context) =>
            RecipeScreen(_toggleFavourite, _isRecipeFavourite),
        SettingsScreen.routeName: (context) =>
            SettingsScreen(_setSettings, _settings),
      },
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (context) => CategoriesScreen()),
    );
  }
}
