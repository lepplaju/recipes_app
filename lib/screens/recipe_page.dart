import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/models/recipe.dart';
import '../providers/recipe_provider.dart';

class RecipeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: RecipeWidget()));
  }
}

class RecipeWidget extends ConsumerWidget {
  //final Recipe recipeToShow = MockRecipeData().getRandomRecipe();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(recipeProvider);
    print("RECIPE LIST: $recipes");
    var recipeToDisplay = recipes[0];
    print(recipeToDisplay);
    return Center(
        child: Column(children: [
      ElevatedButton(
          onPressed: () {
            context.go('/');
          },
          child: Text('go home')),
      Text("Recipe name: ${recipeToDisplay.name}"),
    ]));
  }
}
