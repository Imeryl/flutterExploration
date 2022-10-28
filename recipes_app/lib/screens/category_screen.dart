import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/recipe.dart';

import '../widgets/recipe_item.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = '/category';

  final List<Recipe> availableRecipes;

  CategoryScreen(this.availableRecipes);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String categoryTitle = '';
  List<Recipe> filteredRecipes = [];

  void _removeRecipe(String recipeId) {
    setState(
        () => filteredRecipes.removeWhere((recipe) => recipe.id == recipeId));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final String categoryId = routeArgs['id'] ?? '';
    categoryTitle = routeArgs['title'] ?? '';

    filteredRecipes = widget.availableRecipes
        .where((recipe) => recipe.categoryIds.contains(categoryId))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return RecipeItem(
            id: filteredRecipes[index].id,
            title: filteredRecipes[index].title,
            complexity: filteredRecipes[index].complexity,
            imageUrl: filteredRecipes[index].imageUrl,
            duration: filteredRecipes[index].duration,
            removeItem: _removeRecipe,
          );
        },
        itemCount: filteredRecipes.length,
      ),
    );
  }
}
