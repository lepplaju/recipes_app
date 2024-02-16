import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/models/mock_data.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/recipe_provider.dart';

class RecipeList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tempRecipes = ref.watch(recipeProvider);
    print("TEMP RECIPES:$tempRecipes");

    return ListView.builder(
      itemCount: tempRecipes.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              context.go('/recipe');
            },
            child: Text(
                'hello $index')); //ListTile(title: Text('${tempRecipes[index].name}')));
      },
    );
  }
}
