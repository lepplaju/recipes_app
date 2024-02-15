import 'package:flutter/material.dart';
import 'package:recipe_app/models/mock_data.dart';
import 'package:recipe_app/models/recipe.dart';

class RecipePage extends StatelessWidget {
  final Recipe recipeToShow = MockRecipeData().getRandomRecipe();

  RecipePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      Text("Category: ${recipeToShow.category}"),
      Text("${recipeToShow.name}"),
      Text("Ingredients: ${recipeToShow.ingredients[0]}"),
    ])));
  }
}
