import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/recipe_provider.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: RecipeWidget());
  }
}

class RecipeWidget extends ConsumerWidget {
  const RecipeWidget({super.key});

  //final Recipe recipeToShow = MockRecipeData().getRandomRecipe();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(recipeProvider);
    var recipeToDisplay = recipes[0];
    return Center(
        child: Column(children: [
      ElevatedButton(
          onPressed: () {
            context.go('/');
          },
          child: const Text('go home')),
      Text("Recipe name: ${recipeToDisplay.name}"),
    ]));
  }
}
