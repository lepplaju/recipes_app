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
            padding: EdgeInsets.only(left: 100, right: 100, top: 20),
            child: Card(
                child: InkWell(
                    onTap: () {
                      context.go('/recipe/${tempRecipes[index].name}');
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(tempRecipes[index].name),
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Placeholder(
                                fallbackHeight: 100,
                                fallbackWidth: 100,
                              ))
                        ])))); //ListTile(title: Text('${tempRecipes[index].name}')));
      },
    );
  }
}
