import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widgets/recipe_item.dart';

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
          return RecipeItem(
            title: filteredRecipes[index].title,
            complexity: filteredRecipes[index].complexity,
            imageUrl: filteredRecipes[index].imageUrl,
            duration: filteredRecipes[index].duration,
          );
        },
        itemCount: filteredRecipes.length,
      ),
    );
  }
}
