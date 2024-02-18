import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/providers/recipe_provider.dart';

class RecipeList extends ConsumerWidget {
  const RecipeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tempRecipes = ref.watch(recipeProvider);

    return ListView.builder(
      itemCount: tempRecipes.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              context.go('/recipe/${tempRecipes[index].name}');
            },
            child: Card(
                child: Text(tempRecipes[index]
                    .name))); //ListTile(title: Text('${tempRecipes[index].name}')));
      },
    );
  }
}
