import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/providers/recipe_provider.dart';

class RecipeList extends ConsumerWidget {
  const RecipeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tempRecipes = ref.watch(recipeProvider);
    //var cardsize = MediaQuery.of(context).size.width / 3;

    return ListView.builder(
      itemCount: tempRecipes.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.only(left: 100, right: 100, top: 20),
            child: Card(
                child: InkWell(
                    onTap: () {
                      context.go('/recipe/${tempRecipes[index].id}');
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(tempRecipes[index].name),
                          Container(
                              padding: const EdgeInsets.all(10),
                              child: const Placeholder(
                                fallbackHeight: 100,
                                fallbackWidth: 100,
                              ))
                        ])))); //ListTile(title: Text('${tempRecipes[index].name}')));
      },
    );
  }
}
