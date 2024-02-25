import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/providers/recipe_provider.dart';

class CategoryPage extends StatelessWidget {
  final String category;
  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CategoryScreen(category: category));
  }
}

class CategoryScreen extends ConsumerWidget {
  final String category;

  const CategoryScreen({super.key, required this.category});

  @override
  build(BuildContext context, WidgetRef ref) {
    var allRecipes = ref.watch(recipeProvider);
    var recipesWithCorrectCategory =
        allRecipes.where((recipe) => recipe.category == category);
    List<Widget> recipeCards =
        recipesWithCorrectCategory.map((recipe) => Text("hello")).toList();
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              ElevatedButton(
                  onPressed: () {
                    context.go('/');
                  },
                  child: const Text('Go home')),
              Text('Showing recipies with category $category'),
              ...recipeCards
            ])));
  }
}
