import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/providers/user_provider.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);
    var allRecipes = ref.watch(recipeProvider);
    var yourRecipes =
        allRecipes.where((recipe) => recipe.userId == user.value!.uid);
    List<Widget> recipeCards = yourRecipes
        .map((recipe) => Card(
              child: Text(recipe.name),
            ))
        .toList();

    return Center(
        child: Column(children: [
      ElevatedButton(
        child: const Text("add recipe"),
        onPressed: () {
          context.go("/newRecipe");
        },
      ),
      const Text("your recipes:"),
      yourRecipes.isEmpty
          ? const SizedBox(height: 100)
          : Column(
              children: [...recipeCards],
            ),
      const Text("your favorites:")
    ]));
  }
}
