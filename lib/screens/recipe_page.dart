import 'package:flutter/material.dart';
import 'package:recipe_app/models/mock_data.dart';
import 'package:recipe_app/models/recipe.dart';

class RecipePage extends StatelessWidget {
  Recipe recipeToShow = MockRecipeData().getRandomRecipe();
  @override
  Widget build(BuildContext context) {
    print(recipeToShow);
    return Scaffold(
        body: Center(
            child: Column(children: [
      Text("Category: ${recipeToShow.category}"),
      Text("${recipeToShow.name}"),
      Text("Ingredients: ${recipeToShow.ingredients[0]}"),
    ])));
  }
}
