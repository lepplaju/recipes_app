import 'package:flutter/material.dart';
import 'package:recipe_app/models/mock_data.dart';
import 'package:recipe_app/models/recipe.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  Widget build(BuildContext context) {
    List<Recipe> tempRecipes = MockRecipeData().getRecipes();

    return ListView.builder(
      itemCount: tempRecipes.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text('${tempRecipes[index].name}'));
      },
    );
  }
}
