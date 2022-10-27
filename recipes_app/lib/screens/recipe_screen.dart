import 'package:flutter/material.dart';

import '../dummy_data.dart';

class RecipeScreen extends StatelessWidget {
  static const routeName = '/recipe';

  const RecipeScreen({super.key});

  Container buildList(List list) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      padding: EdgeInsets.all(5),
      width: double.infinity,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list
              .map(
                (listItem) => Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: Text(listItem),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Container buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedRecipe.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildList(selectedRecipe.ingredients),
            buildSectionTitle(context, 'Steps'),
            buildList(selectedRecipe.steps),
          ],
        ),
      ),
    );
  }
}
