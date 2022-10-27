import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/recipe.dart';

import 'dummy_data.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = '/category';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final String categoryId = routeArgs['id'] ?? '';
    final String categoryTitle = routeArgs['title'] ?? '';

    final filteredRecipes = DUMMY_RECIPES
        .where((recipe) => recipe.categoryIds.contains(categoryId))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Text(filteredRecipes[index].title);
        },
        itemCount: filteredRecipes.length,
      ),
    );
  }
}
