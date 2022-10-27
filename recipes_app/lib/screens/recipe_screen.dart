import 'package:flutter/material.dart';

import '../dummy_data.dart';

class RecipeScreen extends StatelessWidget {
  static const routeName = '/recipe';

  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeId = ModalRoute.of(context)?.settings.arguments;

    final selectedRecipe = DUMMY_RECIPES.firstWhere(
      (recipe) => recipe.id == recipeId,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedRecipe.title,
        ),
      ),
      body: Text(selectedRecipe.title),
    );
  }
}
