import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe_app/models/mock_data.dart';
import 'package:recipe_app/models/recipe.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Recipe trendingRecipe = MockRecipeData().getRandomRecipe();
    return Center(
        child: Column(children: [
      Text('Welcome!'),
      Text('Today\'s Trending Recipe:'),
      Card(
        child: Text(trendingRecipe.name),
      )
    ]));
  }
}
