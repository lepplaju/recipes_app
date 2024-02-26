import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/recipe_provider.dart';

class RecipeScreen extends StatelessWidget {
  final String name;
  const RecipeScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: RecipeWidget(name));
  }
}

class RecipeWidget extends ConsumerWidget {
  final String name;
  const RecipeWidget(this.name, {super.key});

  //final Recipe recipeToShow = MockRecipeData().getRandomRecipe();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final recipes = ref.watch(recipeProvider);
    // var recipeToDisplay = recipes[0];
    var allRecipes = ref.watch(recipeProvider);
    var recipeToDisplay = allRecipes.firstWhere((r) => r.name == name);
    List<Widget> ingredients = recipeToDisplay.ingredients
        .map((ingredient) => Text(ingredient))
        .toList();
    List<Widget> steps =
        recipeToDisplay.steps.map((step) => Text(step)).toList();
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              ElevatedButton(
                  onPressed: () {
                    context.go('/');
                  },
                  child: const Text('go home')),
              Text("Recipe name: ${recipeToDisplay.name}"),
              Text("Recipe categories: ${recipeToDisplay.categories}"),
              const SizedBox(
                  width: 300,
                  child: Placeholder(
                    fallbackHeight: 300,
                  )),
              const Text(
                "Ingredients:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...ingredients,
              const Text(
                "Steps:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...steps
            ])));
  }
}
