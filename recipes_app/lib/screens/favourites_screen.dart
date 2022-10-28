import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../widgets/recipe_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Recipe> favouriteRecipes;

  const FavouritesScreen(this.favouriteRecipes);

  @override
  Widget build(BuildContext context) {
    if (favouriteRecipes.isEmpty) {
      return Center(
        child: Text('You have no favourites yet.'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return RecipeItem(
            id: favouriteRecipes[index].id,
            title: favouriteRecipes[index].title,
            complexity: favouriteRecipes[index].complexity,
            imageUrl: favouriteRecipes[index].imageUrl,
            duration: favouriteRecipes[index].duration,
          );
        },
        itemCount: favouriteRecipes.length,
      );
    }
  }
}
